//
//  ViewController.m
//  NotificationCenterWidget
//
//  Created by YWH on 15/11/19.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "NCWHomeViewController.h"
#import "NCWSpringboardCell.h"
#import "NCWSpringboardLayout.h"
#import "NCWWidgetInfoManager.h"
#import "NCWCollectionHeadView.h"
#import "NCWBaseNavigationController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "NCWAppFunctionViewController.h"
#import "NCWDialog.h"
#import "NCWReallyManager.h"
#import "NCWAdImageView.h"
#import "NYAlertViewController.h"
#import "GCDAsyncSocket.h"
#import "UIScrollView+EmptyDataSet.h"

#define NCWCollectionViewCellIdentifier     @"NCWCollectionViewCellIdentifier"
#define NCWCollectionViewHeadIdentifier    @"NCWCollectionViewHeadIdentifier"
#define kTopMargin  30
#define kPortraitTopMargin 74
#define kHomeHeadViewHeight 90
#define kHomeBottomViewHeight 45

static const NSInteger kActionSheetTag1 = 1000;
static const NSInteger kActionSheetTag2  =1001;


typedef NS_ENUM(NSInteger, ContactState)
{
    ContactStateNormal = 0,
    ContactStateEditing = 1
};

@interface NCWHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, GSSpringboardCellDelegate,GSSpringboardDataSource,ABPeoplePickerNavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray   *starPersonList;
@property (nonatomic,assign) ContactState    contactState;
@property(nonatomic, strong)UIButton         *addContactButton;
@property(nonatomic, strong)UIImageView      *innerButtonImageView;
@property(nonatomic, strong)UIView           *bottomView;
@property(nonatomic, strong)UIButton         *bottomButton;
@property(nonatomic, strong)UIView           *bottomSeparateLine;
@property(nonatomic, strong)NCWWidgetPerson   *meWidgetPerson;
@property(nonatomic, strong)NSMutableArray   *phoneNumberArray;
@property(nonatomic, strong)NSMutableArray   *phoneNumberTypeArray;
@property (nonatomic,assign) NCWType         contactType; //号码用途
@property (nonatomic, strong) NCWAdImageView *adView;

@end


@implementation NCWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"通知中心插件";
    self.view.backgroundColor = colorWithRGB(efeff4);
    [self __addDefaultNotificationItems];
    [self __reloadPersonList];
    [self __buildView];
//    [[NCWWidgetInfoManager sharedInstance] visitAddressBook];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__reloadPersonList) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self __reloadPersonList];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    CGRect f1 = bounds;
    f1.size.height =f1.size.height  - kHomeBottomViewHeight;
    if (![NCWReallyManager sharedInstance].shouleBeReally) {
        f1.size.height = f1.size.height - 50*kScreenWidth/320;
    }
    _collectionView.frame = f1;
    
    
    CGRect f2 = f1;
    f2.origin.x = 12;
    f2.origin.y = kHomeHeadViewHeight;
    f2.size.width = bounds.size.width/5;
    f2.size.height = 42;
    _addContactButton.frame = f2;
    
    CGRect f3 = f2;
    f3.origin.x = (CGRectGetWidth(f2)-41)/2;
    f3.origin.y = (CGRectGetWidth(f2)-41)/2;
    _innerButtonImageView.frame = f3;
    
    
    CGRect f4 = bounds;
    f4.size.height = kHomeBottomViewHeight;
    f4.origin.y = CGRectGetHeight(bounds) - kHomeBottomViewHeight;
    _bottomView.frame = f4;
    
    CGRect f5 = CGRectMake((CGRectGetWidth(f4)-kHomeBottomViewHeight)/2, 0, kHomeBottomViewHeight, kHomeBottomViewHeight);
    _bottomButton.frame = f5;
    
    _bottomSeparateLine.frame = CGRectMake(0, 0, CGRectGetWidth(_bottomView.frame), 0.5);
    
    
    CGRect f6 = f4;
    f6.origin.y -= 50*kScreenWidth/320;
    f6.size.height = 50*kScreenWidth/320;
    _adView.frame = f6;
    
    [self refreshAddButtonFrame];
}


#pragma mark - set/get methods

- (NSMutableArray *)starPersonList
{
    if (!_starPersonList) {
        _starPersonList = [[NSMutableArray alloc] init];
    }
    return _starPersonList;
}


#pragma mark -Private Method

-(void)__buildView{
    [((NCWBaseNavigationController *)self.navigationController) addPartingLine];
    
    
    NCWSpringboardLayout * layout = [[NCWSpringboardLayout alloc] initWithType:GS_SBLayoutTypeScroll];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = colorWithRGB(efeff4);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[NCWSpringboardCell class] forCellWithReuseIdentifier:NCWCollectionViewCellIdentifier];
    [self.collectionView registerClass:[NCWCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NCWCollectionViewHeadIdentifier];
    [self.view addSubview:self.collectionView];
    
    _addContactButton = [[UIButton alloc] init];
    _addContactButton.backgroundColor = [UIColor clearColor];
    [_addContactButton addTarget:self action:@selector(addStarPerson) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:_addContactButton];
    
    _innerButtonImageView = [[UIImageView alloc] init];
    _innerButtonImageView.userInteractionEnabled = NO;
    _innerButtonImageView.image = kNCWBundleImage(@"add_common.png");
    _innerButtonImageView.highlightedImage = kNCWBundleImage(@"add_selected.png");
    _innerButtonImageView.contentMode = UIViewContentModeScaleToFill;
    [_addContactButton addSubview:_innerButtonImageView];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    self.bottomSeparateLine = [[UIView alloc] init];
    self.bottomSeparateLine.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:self.bottomSeparateLine];
    
    _bottomButton = [[UIButton alloc] init];
    _bottomButton.layer.cornerRadius = 2.0f;
    _bottomButton.backgroundColor = [UIColor clearColor];
    _bottomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bottomButton setTitleColor:colorWithRGB(2e92ff) forState:UIControlStateNormal];
    [_bottomButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(editStateChange:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomButton];

    if (![NCWReallyManager sharedInstance].shouleBeReally){
        _adView = [[NCWAdImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kHomeBottomViewHeight, kScreenWidth, 50*kScreenWidth/320)];
        [self.view insertSubview:_adView aboveSubview:_collectionView];
    }
    
}

- (void)__addDefaultNotificationItems
{

}

-(void)editStateChange:(id)sender
{
    if (self.contactState == ContactStateEditing) {
        _contactState = ContactStateNormal;
        [_bottomButton setTitle: @"编辑" forState:UIControlStateNormal];
    }else
    {
        _contactState = ContactStateEditing;
        [_bottomButton setTitle: @"完成" forState:UIControlStateNormal];
    }
    self.collectionView.gsEditing = _contactState;
    [self.collectionView reloadData];
}

- (void)__reloadPersonList
{
    [[NCWWidgetInfoManager sharedInstance] clearRequestQueue];
    [self.starPersonList removeAllObjects];
    [self.starPersonList addObjectsFromArray:[[NCWWidgetInfoManager sharedInstance] personListAtWidget]];
    [self.collectionView reloadData];
    _contactState = ContactStateEditing;
    [self editStateChange:nil];
    [self.view setNeedsLayout];
}


-(void)refreshAddButtonFrame{
     CGRect bounds = _collectionView.frame;
    CGRect f3 = bounds;

    NSInteger count = _starPersonList.count;
    float unit = CGRectGetWidth(bounds)/5;
    f3.origin.x = (count%5)*unit;
    f3.origin.y = f3.origin.y + floorf(count/5.0f) * kPortraitTopMargin + kHomeHeadViewHeight;
    f3.size.width = unit;
    f3.size.height =  kPortraitTopMargin;
    _addContactButton.frame = f3;
    
    CGRect f4 = f3;
    f4.origin.x = (f4.size.width-41)/2;
    f4.origin.y = 12;
    f4.size.width = 41;
    f4.size.height = 41;
    _innerButtonImageView.frame = f4;
    
    if (_starPersonList.count >=kNCWLimitCount) {
        _addContactButton.hidden = YES;
        return;
    }
    
    if (_addContactButton.isHidden) {
        _addContactButton.hidden = NO;
    }

}


-(void)pushABPeoplePickerNavigationController
{
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
    //            peoplePicker.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    [self.navigationController presentViewController:peoplePicker animated:YES completion:nil];
}
#pragma mark - Action
-(void)addStarPerson
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"APP和功能", @"联系人电话",@"联系人短信",nil];
    actionSheet.tag = kActionSheetTag1;
    [actionSheet showInView:self.view];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.starPersonList.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
            if (indexPath.section == 0) {
                NCWCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NCWCollectionViewHeadIdentifier forIndexPath:indexPath];
                reusableview = headView;
                
            }
    }
    return reusableview;
}



- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NCWSpringboardCell * cell = (NCWSpringboardCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NCWCollectionViewCellIdentifier forIndexPath:indexPath];
    
    id item = [self.starPersonList objectAtIndex:indexPath.row];
    
    [cell bindPerson:item];
    cell.delegate = self;
    if (self.contactState == ContactStateEditing)
    {
        cell.sbEditing = YES;
    }
    else
    {
        cell.sbEditing = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

#pragma mark - GSSpringboardDataSource
- (void)gssb_collectionView:(UICollectionView *)collectionView editStateDidChanged:(BOOL) editing
{
    if (editing)
    {
        self.contactState = ContactStateNormal;
        [self editStateChange:nil];
    }
}

- (void)gssb_collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    id person = [self.starPersonList objectAtIndex:fromIndexPath.row];
    [self.starPersonList removeObjectAtIndex:fromIndexPath.row];
    [self.starPersonList insertObject:person atIndex:toIndexPath.row];
    [[NCWWidgetInfoManager sharedInstance] sortNCWListWithNewList:self.starPersonList];
}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect collFrame = collectionView.frame;
    CGFloat cellWidth = collFrame.size.width/5.0;
    CGFloat cellHeight = kPortraitTopMargin;
    CGSize sizeOfItem = CGSizeMake(cellWidth , cellHeight);
    return sizeOfItem;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, kHomeHeadViewHeight);
}



- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    return inset;
}


#pragma mark - GSSpringboardDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - GSSpringboardCellDelegate

- (void)gs_sbCellDidDeleted:(NCWSpringboardCell *)cell
{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    id deleteItem = [self.starPersonList objectAtIndex:indexPath.row];
    [self.starPersonList removeObject:deleteItem];
    [[NCWWidgetInfoManager sharedInstance] deleteFromWidget:deleteItem saveWidget:YES];
    [self.collectionView gs_deleteItemAtIndexPath:indexPath];
    [self refreshAddButtonFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    
    _meWidgetPerson = [NCWWidgetPerson emptyPerson];
    _meWidgetPerson = [_meWidgetPerson initWithABRecordRef:person];
    
    
    //获取号码列表
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSInteger phoneCount = ABMultiValueGetCount(phones);
    if (phoneCount == 0) {
        [NCWDialog toast:@"此联系人号码为空"];
    }
    if (phoneCount == 1) {
        NSString * phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, 0));
        NSString * label = CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, 0)));
        _meWidgetPerson.phoneNumber = phoneNumber;
        _meWidgetPerson.phoneNumberType = label;
        _meWidgetPerson.contactType = _contactType;
        [[NCWWidgetInfoManager sharedInstance] addNCWItemToWidget:_meWidgetPerson saveToWidget:YES];
        
    }
    else if(phoneCount > 1)
    {
        
        _phoneNumberArray = [[NSMutableArray alloc] init];
        _phoneNumberTypeArray = [[NSMutableArray alloc] init];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        actionSheet.tag = kActionSheetTag2;
        for (int j = 0; j < phoneCount; j++) {
            NSString * phone = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, j));
            NSString * label = CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, j)));
            if (phone.length > 0 && label.length > 0) {
                [_phoneNumberArray addObject:phone];
                [_phoneNumberTypeArray addObject:label];
                [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@:%@",label,phone]];
            }
        }
        
        [actionSheet showInView:self.view];

    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (kActionSheetTag1 == actionSheet.tag) {
        switch (buttonIndex) {
            case 0:{
                NCWAppFunctionViewController *ncwCtrl = [[NCWAppFunctionViewController alloc] init];
//                ncwCtrl.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ncwCtrl animated:YES];
//                NCWBaseNavigationController *nav = [[NCWBaseNavigationController alloc] initWithRootViewController:ncwCtrl];
//                [self.navigationController presentViewController:nav animated:YES completion:nil];
            }
                break;
            case 1:{
                [self pushABPeoplePickerNavigationController];
                self.contactType = MEPersonContactTypePhone;
                break;
            }

            case 2:{
                [self pushABPeoplePickerNavigationController];
                self.contactType = MEPersonContactTypeMSG;
                break;
            }
            default:
                break;
        }
    }else if (kActionSheetTag2 == actionSheet.tag) {
  
        if (buttonIndex == 0) {  //点击取消按钮
            return;
        }
        NSInteger index = buttonIndex - 1;
        if (index < _phoneNumberTypeArray.count&&index < _phoneNumberArray.count) {
            _meWidgetPerson.phoneNumber = _phoneNumberArray[index];
            _meWidgetPerson.contactType = _contactType;
            _meWidgetPerson.phoneNumberType = _phoneNumberTypeArray[index];
            [[NCWWidgetInfoManager sharedInstance] addNCWItemToWidget:_meWidgetPerson saveToWidget:YES];
            [self __reloadPersonList];
        }
    }
}



@end
