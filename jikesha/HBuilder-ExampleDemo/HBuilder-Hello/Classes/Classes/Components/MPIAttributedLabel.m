//
//  MPIAttributedLabel.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "MPIAttributedLabel.h"
#import "MPITextAsyncLayer.h"
#import "MPITextRendererKey.h"
#import "MPITextGeometryHelpers.h"
#import "MPITextEqualityHelpers.h"
#import "MPITextDefaultsValueHelpers.h"
#import "MPITextAttachmentsInfo.h"
#import "MPITextCache.h"

#import "NSMutableAttributedString+MPITextKit.h"
#import "NSAttributedString+MPITextKit.h"

static dispatch_queue_t MPITextLabelGetReleaseQueue() {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}

static MPITextCache *sharedRendererCache()
{
    static dispatch_once_t onceToken;
    static MPITextCache *rendererCache = nil;
    dispatch_once(&onceToken, ^{
        rendererCache = [[MPITextCache alloc] init];
        rendererCache.countLimit = 500;
    });
    return rendererCache;
}

static MPITextCache *sharedTextSizeCache()
{
    static dispatch_once_t onceToken;
    static MPITextCache *textViewSizeCache = nil;
    dispatch_once(&onceToken, ^{
        textViewSizeCache = [[MPITextCache alloc] init];
        textViewSizeCache.countLimit = 1000;
    });
    return textViewSizeCache;
}

static CCTextRenderer *rendererForAttributes(MPITextRenderAttributes *attributes, CGSize constrainedSize) {
    if (constrainedSize.width < FLT_EPSILON ||
        constrainedSize.height < FLT_EPSILON) {
        return nil;
    }
    MPITextRendererKey *key = [[MPITextRendererKey alloc] initWithAttributes:attributes constrainedSize:constrainedSize];
    
    MPITextCache *cache = sharedRendererCache();
    
    CCTextRenderer *renderer = [cache objectForKey:key];
    if (renderer == nil) {
        renderer = [[CCTextRenderer alloc] initWithTextKitAttributes:attributes constrainedSize:constrainedSize];
        [cache setObject:renderer forKey:key];
    }
    
    return renderer;
}

static void cacheRenderer(CCTextRenderer *renderer, MPITextRenderAttributes *attributes, CGSize constrainedSize) {
    MPITextCache *cache = sharedRendererCache();
    
    MPITextRendererKey *key = [[MPITextRendererKey alloc] initWithAttributes:attributes constrainedSize:constrainedSize];
    
    [cache setObject:renderer forKey:key];
}

static NSValue *textSizeForKey(MPITextRendererKey *key) {
    MPITextCache *cache = sharedTextSizeCache();
    
    return [cache objectForKey:key];
}

static void cacheTextSizeForKey(MPITextRendererKey *key, CGSize textSize) {
    MPITextCache *cache = sharedTextSizeCache();
    
    [cache setObject:[NSValue valueWithCGSize:textSize] forKey:key];
}

CGSize MPITextSuggestFrameSizeForAttributes(MPITextRenderAttributes *attributes,
                                            CGSize fitsSize,
                                            UIEdgeInsets textContainerInset) {
    if (attributes.attributedText.length == 0) {
        return CGSizeZero;
    }
    
    if (fitsSize.width < FLT_EPSILON || fitsSize.width > CCTextContainerMaxSize.width) {
        fitsSize.width = CCTextContainerMaxSize.width;
    }
    if (fitsSize.height < FLT_EPSILON || fitsSize.height > CCTextContainerMaxSize.width) {
        fitsSize.height = CCTextContainerMaxSize.height;
    }
    
    CGFloat horizontalValue = MPITextUIEdgeInsetsGetHorizontalValue(textContainerInset);
    CGFloat verticalValue = MPITextUIEdgeInsetsGetVerticalValue(textContainerInset);
    
    CGSize constrainedSize = fitsSize;
    if (constrainedSize.width < CCTextContainerMaxSize.width - FLT_EPSILON) {
        constrainedSize.width = fitsSize.width - horizontalValue;
    }
    if (constrainedSize.height < CCTextContainerMaxSize.height - FLT_EPSILON) {
        constrainedSize.height = fitsSize.height - verticalValue;
    }
    
    MPITextRendererKey *key = [[MPITextRendererKey alloc] initWithAttributes:attributes constrainedSize:constrainedSize];
    
    CCTextRenderer *renderer = nil;
    CGSize textSize = CGSizeZero;
    NSValue *textSizeValue = textSizeForKey(key);
    if (textSizeValue) {
        textSize = textSizeValue.CGSizeValue;
    } else {
        renderer = [[CCTextRenderer alloc] initWithTextKitAttributes:attributes constrainedSize:constrainedSize];
        textSize = renderer.size;
        
        cacheTextSizeForKey(key, textSize);
    }
    
    CGSize suggestSize = CGSizeMake(textSize.width + horizontalValue, textSize.height + verticalValue);
    
    if (suggestSize.width > fitsSize.width) {
        suggestSize.width = fitsSize.width;
    }
    if (suggestSize.height > fitsSize.height) {
        suggestSize.height = fitsSize.height;
    }
    
    if (renderer) {
        // Cache Renderer for render.
        if (constrainedSize.width > CCTextContainerMaxSize.width - FLT_EPSILON) {
            constrainedSize.width = textSize.width;
        }
        if (constrainedSize.height > CCTextContainerMaxSize.height - FLT_EPSILON) {
            constrainedSize.height = textSize.height;
        }
        cacheRenderer(renderer, attributes, constrainedSize);
    }
    
    return suggestSize;
}

static CGFloat const kAsyncFadeDuration = 0.08; // Time in seconds for async display fadeout animation.
static NSString *const kAsyncFadeAnimationKey = @"contents";

@interface MPIAttributedLabel () <
    MPITextAsyncLayerDelegate,
    MPITextViewModelDelegate,
    MPITextDebugTarget
> {
    struct {
        unsigned int contentsUpdated : 1;
        unsigned int attachmentsNeedsUpdate : 1;
    } _state;
}

@property (nonatomic, strong) MPITextViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray<UIView *> *attachmentViews;
@property (nonatomic, strong) NSMutableArray<CALayer *> *attachmentLayers;

@end

@implementation MPIAttributedLabel
@synthesize truncationAttributedText = _truncationAttributedText;

- (void)dealloc {
#ifdef DEBUG
    [MPITextDebugOption removeDebugTarget:self];
#endif
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    _viewModel = [[MPITextViewModel alloc] initWithTextView:self];
    _viewModel.delegate = self;
    
    self.layer.contentsScale = MPITextScreenScale();
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.userInteractionEnabled = YES;
    self.displaysAsynchronously = NO;
    
    _activeLinkTextAttributes = MPITextDefaultActiveLinkTextAttributes();
    
    _clearContentsBeforeAsynchronouslyDisplay = YES;
    _fadeOnAsynchronouslyDisplay = YES;
    
    _numberOfLines = 1;
    _lineBreakMode = NSLineBreakByTruncatingTail;
    _textVerticalAlignment = MPITextVerticalAlignmentCenter;
    _shadowOffset = CGSizeMake(0, -1);
    
    _attachmentViews = [NSMutableArray new];
    _attachmentLayers = [NSMutableArray new];
    
#ifdef DEBUG
    _debugOption = [MPITextDebugOption sharedDebugOption];
    [MPITextDebugOption addDebugTarget:self];
#endif
}

#pragma mark - Override

+ (Class)layerClass {
    return [MPITextAsyncLayer class];
}

- (CGSize)intrinsicContentSize {
    if (self.textRenderer) {
        return CGSizeMake(self.textRenderer.size.width +
                          MPITextUIEdgeInsetsGetHorizontalValue(self.textContainerInset),
                          self.textRenderer.size.height +
                          MPITextUIEdgeInsetsGetVerticalValue(self.textContainerInset));
    }
    
    CGFloat width = CGRectGetWidth(self.frame);
    if (self.numberOfLines == 1) {
        width = CCTextContainerMaxSize.width;
    }
    
    CGFloat preferredMaxLayoutWidth = self.preferredMaxLayoutWidth;
    if (preferredMaxLayoutWidth > FLT_EPSILON) {
        width = preferredMaxLayoutWidth;
    }
    
    return [self sizeThatFits:CGSizeMake(width, CCTextContainerMaxSize.height)];
}

- (CGSize)sizeThatFits:(CGSize)size {
    MPITextRenderAttributes *renderAttributes = [self renderAttributes];
    if (CGSizeEqualToSize(self.bounds.size, size)) { // sizeToFit called.
        size.height = CCTextContainerMaxSize.height;
    }
    return MPITextSuggestFrameSizeForAttributes(renderAttributes, size, self.textContainerInset);
}

- (void)setBounds:(CGRect)bounds {
    // https://stackoverflow.com/questions/17491376/ios-autolayout-multi-line-uilabel
    CGSize oldSize = self.bounds.size;
    [super setBounds:bounds];
    CGSize newSize = self.bounds.size;
    if (!CGSizeEqualToSize(oldSize, newSize)) {
        [self invalidate];
    }
}

- (void)setFrame:(CGRect)frame {
    CGSize oldSize = self.bounds.size;
    [super setFrame:frame];
    CGSize newSize = self.bounds.size;
    if (!CGSizeEqualToSize(oldSize, newSize)) {
        [self invalidate];
    }
}

#pragma mark - UIAccessibility

- (NSString *)accessibilityLabel {
    return self.text;
}

- (NSAttributedString *)accessibilityAttributedLabel {
    return self.attributedText;
}

#pragma mark - Custome Accessors

- (void)setTruncationAttributedToken:(NSAttributedString *)truncationAttributedToken {
    if (MPITextObjectIsEqual(_truncationAttributedToken, truncationAttributedToken)) {
        return;
    }
    
    _truncationAttributedToken = truncationAttributedToken;
    
    [self invalidateAttachments];
    [self invalidateTruncationAttributedText];
    
    [self setNeedsUpdateContents];
}

- (void)setAdditionalTruncationAttributedMessage:(NSAttributedString *)additionalTruncationAttributedMessage {
    if (MPITextObjectIsEqual(_additionalTruncationAttributedMessage, additionalTruncationAttributedMessage)) {
        return;
    }
    
    _additionalTruncationAttributedMessage = additionalTruncationAttributedMessage;
    
    [self invalidateAttachments];
    [self invalidateTruncationAttributedText];
    
    [self setNeedsUpdateContents];
}

- (NSAttributedString *)truncationAttributedText {
    if (_truncationAttributedText == nil) {
        if (self.truncationAttributedToken != nil && self.additionalTruncationAttributedMessage != nil) {
            NSMutableAttributedString *newComposedTruncationString = [[NSMutableAttributedString alloc] initWithAttributedString:self.truncationAttributedToken];
            [newComposedTruncationString appendAttributedString:self.additionalTruncationAttributedMessage];
            _truncationAttributedText = newComposedTruncationString;
        } else if (self.truncationAttributedToken != nil) {
            _truncationAttributedText = self.truncationAttributedToken;
        } else if (self.additionalTruncationAttributedMessage != nil) {
            _truncationAttributedText = self.additionalTruncationAttributedMessage;
        } else {
            _truncationAttributedText = MPITextDefaultTruncationAttributedToken();
        }
        _truncationAttributedText = [self prepareTruncationTextForDrawing:_truncationAttributedText];
    }
    return _truncationAttributedText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (MPITextObjectIsEqual(_attributedText, attributedText)) {
        return;
    }
    
    _attributedText = attributedText.copy;
    
    [self invalidate];
}

- (void)setTextRenderer:(CCTextRenderer *)textRenderer {
    if (_textRenderer == textRenderer) {
        return;
    }
    
    _textRenderer = textRenderer;
    
    [self invalidate];
}

- (NSString *)text {
    return self.attributedText.string;
}

- (void)setText:(NSString *)text {
    if (text) {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:[self attributesByProperties]];
        [attributedText mpi_setAlignment:self.textAlignment range:attributedText.mpi_rangeOfAll];
        self.attributedText = attributedText;
    } else {
        self.attributedText = nil;
    }
}

- (void)setFont:(UIFont *)font {
    if (MPITextObjectIsEqual(_font, font)) {
        return;
    }
    
    _font = font ? : [self defalutFont];
    
    [self updateAttributedTextAttribute:NSFontAttributeName
                                  value:_font];
}

- (void)setTextColor:(UIColor *)textColor {
    if (MPITextObjectIsEqual(_textColor, textColor)) {
        return;
    }
    
    _textColor = textColor ? : [self defalutTextColor];
    
    [self updateAttributedTextAttribute:NSForegroundColorAttributeName
                                  value:_textColor];
}

- (void)setShadowColor:(UIColor *)shadowColor {
    if (MPITextObjectIsEqual(_shadowColor, shadowColor)) {
        return;
    }
    
    _shadowColor = shadowColor;
    
    [self updateAttributedTextAttribute:NSShadowAttributeName
                                  value:[self shadowByProperties]];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    if (CGSizeEqualToSize(_shadowOffset, shadowOffset)) {
        return;
    }
    
    _shadowOffset = shadowOffset;
    
    [self updateAttributedTextAttribute:NSShadowAttributeName
                                  value:[self shadowByProperties]];
}

- (void)setShadowBlurRadius:(CGFloat)shadowBlurRadius {
    if (ABS(_shadowBlurRadius - shadowBlurRadius) < FLT_EPSILON) {
        return;
    }
    
    _shadowBlurRadius = shadowBlurRadius;
    
    [self updateAttributedTextAttribute:NSShadowAttributeName
                                  value:[self shadowByProperties]];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) {
        return;
    }
    
    _textAlignment = textAlignment;
    
    NSMutableAttributedString *attributedText = self.attributedText.mutableCopy;
    [attributedText mpi_setAlignment:_textAlignment range:attributedText.mpi_rangeOfAll];
    self.attributedText = attributedText;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    if (_numberOfLines == numberOfLines) {
        return;
    }
    
    _numberOfLines = numberOfLines;
    
    [self invalidate];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    if (_lineBreakMode == lineBreakMode) {
        return;
    }
    
    _lineBreakMode = lineBreakMode;
    
    [self invalidate];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    if (UIEdgeInsetsEqualToEdgeInsets(_textContainerInset, textContainerInset)) {
        return;
    }
    
    _textContainerInset = textContainerInset;
    
    [self invalidate];
}

- (void)setExclusionPath:(UIBezierPath *)exclusionPath {
    if (MPITextObjectIsEqual(_exclusionPath, exclusionPath)) {
        return;
    }
    
    _exclusionPath = exclusionPath.copy;
    
    [_exclusionPath applyTransform:CGAffineTransformMakeTranslation(self.textContainerInset.left,
                                                                    self.textContainerInset.top)];
    
    [self invalidate];
}

- (void)setPreferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    if (ABS(_preferredMaxLayoutWidth - preferredMaxLayoutWidth) < FLT_EPSILON) {
        return;
    }
    
    _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    
    [self invalidate];
}

- (void)setDisplaysAsynchronously:(BOOL)displaysAsynchronously {
    if (_displaysAsynchronously != displaysAsynchronously) {
        _displaysAsynchronously = displaysAsynchronously;
        [self setNeedsUpdateContents];
    }
}

#pragma mark - Defalut Values

- (UIFont *)defalutFont {
    return [UIFont systemFontOfSize:17];
}

- (UIColor *)defalutTextColor {
    return [UIColor blackColor];
}

#pragma mark - Attributes

- (NSDictionary *)attributesByProperties {
    UIFont *font = self.font ? : [self defalutFont];
    UIColor *textColor = self.textColor ? : [self defalutTextColor];
    NSShadow *shadow = [self shadowByProperties];
    NSMutableDictionary *attributes = [@{NSForegroundColorAttributeName: textColor,
                                         NSFontAttributeName: font} mutableCopy];
    attributes[NSShadowAttributeName] = shadow;
    return [attributes copy];
}

- (NSShadow *)shadowByProperties {
    NSShadow *shadow = nil;
    if (self.shadowColor &&
        self.shadowBlurRadius > FLT_EPSILON) {
        shadow = [NSShadow new];
        shadow.shadowColor = self.shadowColor;
        shadow.shadowOffset = self.shadowOffset;
        shadow.shadowBlurRadius = self.shadowBlurRadius;
    }
    return shadow;
}

#pragma mark - Public

- (BOOL)isTruncated {
    return [[self currentRenderer] isTruncated];
}

#pragma mark - Private

- (void)clearContentsIfNeeded {
    if (!self.layer.contents) {
        return;
    }
    CGImageRef image = (__bridge_retained CGImageRef)(self.layer.contents);
    self.layer.contents = nil;
    if (image) {
        dispatch_async(MPITextLabelGetReleaseQueue(), ^{
            CFRelease(image);
        });
    }
}

- (void)clearAttachmentViewsAndLayers {
    for (UIView *view in self.attachmentViews) {
        if (view.superview == self) {
            [view removeFromSuperview];
        }
    }
    for (CALayer *layer in self.attachmentLayers) {
        if (layer.superlayer == self.layer) {
            [layer removeFromSuperlayer];
        }
    }
    [self.attachmentViews removeAllObjects];
    [self.attachmentLayers removeAllObjects];
}

- (void)clearAttachmentViewsAndLayersWithAttachmetsInfo:(CCTextAttachmentsInfo *)attachmentsInfo {
    for (UIView *view in self.attachmentViews) {
        if (view.superview == self &&
            ![self containsContent:view forAttachmetsInfo:attachmentsInfo]) {
            [view removeFromSuperview];
        }
    }
    for (CALayer *layer in self.attachmentLayers) {
        if (layer.superlayer == self.layer &&
            ![self containsContent:layer forAttachmetsInfo:attachmentsInfo]) {
            [layer removeFromSuperlayer];
        }
    }
    [self.attachmentViews removeAllObjects];
    [self.attachmentLayers removeAllObjects];
}

- (BOOL)containsContent:(id)content forAttachmetsInfo:(CCTextAttachmentsInfo *)attachmentsInfo {
    BOOL contains = NO;
    for (MPITextAttachment *attachment in attachmentsInfo.attachments) {
        if (attachment.content == content) {
            contains = YES;
            break;
        }
    }
    return contains;
}

- (void)setNeedsUpdateContents {
    if (self.displaysAsynchronously && self.clearContentsBeforeAsynchronouslyDisplay) {
        [self clearContentsIfNeeded];
    }
    
    [self setNeedsUpdateContentsWithoutClearContents];
}

- (void)setNeedsUpdateContentsWithoutClearContents {
    _state.contentsUpdated = NO;
    [self.layer setNeedsDisplay];
}

- (void)invalidateTruncationAttributedText {
    _truncationAttributedText = nil;
}

- (void)invalidateAttachments {
    _state.attachmentsNeedsUpdate = YES;
}

- (void)invalidate {
    [self invalidateAttachments];
    [self invalidateIntrinsicContentSize];
    [self invalidateTruncationAttributedText];
    [self setNeedsUpdateContents];
}

- (void)updateAttributedTextAttribute:(NSAttributedStringKey)name
                                value:(id)value {
    NSMutableAttributedString *attributedText = self.attributedText.mutableCopy;
    if (name) {
        [attributedText mpi_setAttribute:name value:value range:attributedText.mpi_rangeOfAll];
    }
    _attributedText = attributedText.copy;
    
    [self setNeedsUpdateContents];
    
    if ([name isEqualToString:NSFontAttributeName]) {
        [self invalidateAttachments];
        [self invalidateTruncationAttributedText];
        [self invalidateIntrinsicContentSize];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds textSize:(CGSize)textSize {
    CGRect textRect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    
    if (textSize.height < textRect.size.height) {
        CGFloat yOffset = 0.0f;
        switch (self.textVerticalAlignment) {
            case MPITextVerticalAlignmentCenter:
                yOffset = (textRect.size.height - textSize.height) / 2.0f;
                break;
            case MPITextVerticalAlignmentBottom:
                yOffset = textRect.size.height - textSize.height;
                break;
            case MPITextVerticalAlignmentTop:
            default:
                break;
        }
        textRect.origin.y += yOffset;
    }
    
    return textRect;
}

- (CGSize)calculateTextContainerSize {
    CGRect frame = UIEdgeInsetsInsetRect(self.frame, self.textContainerInset);
    CGSize constrainedSize = frame.size;
    return constrainedSize;
}

- (CGPoint)convertPointToTextKit:(CGPoint)point forBounds:(CGRect)bounds {
    CCTextRenderer *renderer = [self currentRenderer];
    return [self convertPointToTextKit:point forBounds:bounds textSize:renderer.size];
}

- (CGPoint)convertPointFromTextKit:(CGPoint)point forBounds:(CGRect)bounds {
    CCTextRenderer *renderer = [self currentRenderer];
    return [self convertPointFromTextKit:point forBounds:bounds textSize:renderer.size];
}

- (CGPoint)convertPointToTextKit:(CGPoint)point forBounds:(CGRect)bounds textSize:(CGSize)textSize {
    CGRect textRect = [self textRectForBounds:bounds textSize:textSize];
    point.x -= textRect.origin.x;
    point.y -= textRect.origin.y;
    return point;
}

- (CGPoint)convertPointFromTextKit:(CGPoint)point forBounds:(CGRect)bounds textSize:(CGSize)textSize {
    CGRect textRect = [self textRectForBounds:bounds textSize:textSize];
    point.x += textRect.origin.x;
    point.y += textRect.origin.y;
    return point;
}

- (NSAttributedString *)prepareTruncationTextForDrawing:(NSAttributedString *)truncationText {
    NSMutableAttributedString *truncationMutableString = truncationText.mutableCopy;
    // Grab the attributes from the full string
    if (self.attributedText.length > 0) {
        NSAttributedString *originalString = self.attributedText;
        NSInteger originalStringLength = originalString.length;
        // Add any of the original string's attributes to the truncation string,
        // but don't overwrite any of the truncation string's attributes
        NSDictionary *originalStringAttributes = [originalString attributesAtIndex:originalStringLength - 1 effectiveRange:NULL];
        [truncationText enumerateAttributesInRange:NSMakeRange(0, truncationText.length) options:0 usingBlock:
         ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
             NSMutableDictionary *futureTruncationAttributes = [originalStringAttributes mutableCopy];
             [futureTruncationAttributes addEntriesFromDictionary:attributes];
             [truncationMutableString setAttributes:futureTruncationAttributes range:range];
         }];
    }
    return truncationMutableString;
}

- (MPITextRenderAttributes *)renderAttributes {
    MPITextRenderAttributes *attributes = [MPITextRenderAttributes new];
    if (self.viewModel.hasActiveLink && !self.viewModel.activeInTruncation) {
        attributes.attributedText = self.viewModel.activeAttributedText;
    } else {
        attributes.attributedText = self.attributedText;
    }
    attributes.lineBreakMode = self.lineBreakMode;
    attributes.maximumNumberOfLines = self.numberOfLines;
    attributes.exclusionPath = self.exclusionPath;
    if (self.viewModel.hasActiveLink && self.viewModel.activeInTruncation) {
        attributes.truncationAttributedText = self.viewModel.activeAttributedText;
    } else {
        attributes.truncationAttributedText = self.truncationAttributedText;
    }
    return attributes;
}

- (CCTextRenderer *)currentRenderer {
    CCTextRenderer *renderer = nil;
    BOOL hasActiveLink = self.viewModel.hasActiveLink;
    if (self.textRenderer && !hasActiveLink) {
        renderer = self.textRenderer;
    } else {
        MPITextRenderAttributes *renderAttributes = [self renderAttributes];
        CGSize textContainerSize = [self calculateTextContainerSize];
        if (hasActiveLink) {
            renderer = [[CCTextRenderer alloc] initWithTextKitAttributes:renderAttributes constrainedSize:textContainerSize];
        } else {
            renderer = rendererForAttributes(renderAttributes, textContainerSize);
        }
    }
    return renderer;
}

#pragma mark - MPITextAsyncLayerDelegate

- (MPITextAsyncLayerDisplayTask *)newAsyncDisplayTask {
    CGRect bounds = self.bounds;
    BOOL displaysAsync = self.displaysAsynchronously;
    BOOL fadeForAsync = displaysAsync && self.fadeOnAsynchronouslyDisplay;
    BOOL contentsUptodate = _state.contentsUpdated;
    MPITextDebugOption *debugOption = self.debugOption;
    BOOL attachmentsNeedsUpdate = _state.attachmentsNeedsUpdate;
    NSMutableArray *attachmentViews = self.attachmentViews;
    NSMutableArray *attachmentLayers = self.attachmentLayers;
    
    CCTextRenderer *renderer = [self currentRenderer];

    MPITextAsyncLayerDisplayTask *task = [MPITextAsyncLayerDisplayTask new];
    task.displaysAsynchronously = displaysAsync;
    
    task.willDisplay = ^(CALayer * _Nonnull layer) {
        MPIAttributedLabel *textView = self;
        if (!textView) {
            return;
        }
        
        [layer removeAnimationForKey:kAsyncFadeAnimationKey];
        
        if (attachmentsNeedsUpdate) {
            [textView clearAttachmentViewsAndLayersWithAttachmetsInfo:renderer.attachmentsInfo];
        }
    };
    
    task.display = ^(CGContextRef  _Nonnull context, CGSize size, BOOL (^ _Nonnull isCancelled)(void)) {
        MPIAttributedLabel *textView = self;
        if (!textView) {
            return;
        }
        
        if (isCancelled()) {
            return;
        }
        
        CGPoint point = [self convertPointFromTextKit:CGPointZero forBounds:bounds textSize:renderer.size];
        [renderer drawAtPoint:point debugOption:debugOption];
    };
    
    task.didDisplay = ^(CALayer * _Nonnull layer, BOOL finished) {
        MPIAttributedLabel *textView = self;
        if (!textView) {
            return;
        }
        
        if (!finished) {
            [textView clearAttachmentViewsAndLayers];
            return;
        }
        
        if (attachmentsNeedsUpdate) {
            textView->_state.attachmentsNeedsUpdate = NO;
            
            CGPoint point = [self convertPointFromTextKit:CGPointZero forBounds:bounds textSize:renderer.size];
            [renderer drawViewAndLayerAtPoint:point referenceTextView:textView];
            
            for (MPITextAttachment *attachment in renderer.attachmentsInfo.attachments) {
                id content = attachment.content;
                if ([content isKindOfClass:UIView.class]) {
                    [attachmentViews addObject:content];
                } else if ([content isKindOfClass:CALayer.class]) {
                    [attachmentLayers addObject:content];
                }
            }
        }
        
        if (!contentsUptodate) {
            textView->_state.contentsUpdated = YES;
        }
        
        if (fadeForAsync) {
            CATransition *transition = [CATransition animation];
            transition.duration = kAsyncFadeDuration;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            transition.type = kCATransitionFade;
            [layer addAnimation:transition forKey:kAsyncFadeAnimationKey];
        }
    };
    
    return task;
}

#pragma mark - MPITextDebugTarget

- (void)setDebugOption:(MPITextDebugOption *)debugOption {
    BOOL needsDraw = _debugOption.needsDrawDebug;
    _debugOption = debugOption.copy;
    if (_debugOption.needsDrawDebug != needsDraw) {
        [self setNeedsUpdateContents];
    }
}

#pragma mark - MPITextViewModelDelegate

- (NSRange)textViewModel:(MPITextViewModel *)viewModel linkRangeAtPoint:(CGPoint)point inTruncation:(BOOL *)inTruncation {
    if (!_state.contentsUpdated) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    CCTextRenderer *renderer = [self currentRenderer];
    
    point = [self convertPointToTextKit:point forBounds:self.bounds textSize:renderer.size];
    
    NSRange linkRange;
    [renderer attribute:MPITextLinkAttributeName atPoint:point effectiveRange:&linkRange inTruncation:inTruncation];
    return linkRange;
}

- (void)textViewModel:(MPITextViewModel *)viewModel didUpdateActiveAttributedText:(NSAttributedString *)activeAttributedText {
    [self invalidateAttachments];
    [self setNeedsUpdateContentsWithoutClearContents];
}

@end

