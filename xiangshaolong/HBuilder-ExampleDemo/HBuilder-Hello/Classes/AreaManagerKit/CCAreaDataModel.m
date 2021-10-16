//
//  MTAreaDataModel.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/18.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "CCAreaDataModel.h"

@implementation CCAreaDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            
            self.continent        = [[dic objectForKey:@"continent_code"] unsignedIntegerValue];
            self.continentCn      = [dic objectForKey:@"continent"];
            self.continentEn      = [dic objectForKey:@"continent_en"];
            self.countryCn        = [dic objectForKey:@"country"];
            self.countryEn        = [dic objectForKey:@"country_en"];
            self.countryCode      = [dic objectForKey:@"country_code"];
            self.detailedArea     = [dic objectForKey:@"area"];
            self.detailedAreaCode = [dic objectForKey:@"area_code"];
        }
    }
    return self;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.continent        = [[aDecoder decodeObjectForKey:@"continent"] unsignedIntegerValue];
        self.continentCn      = [aDecoder decodeObjectForKey:@"continent"];
        self.continentEn      = [aDecoder decodeObjectForKey:@"continentEn"];
        self.countryCn        = [aDecoder decodeObjectForKey:@"countryCn"];
        self.countryEn        = [aDecoder decodeObjectForKey:@"countryEn"];
        self.countryCode      = [aDecoder decodeObjectForKey:@"countryCode"];
        self.detailedArea     = [aDecoder decodeObjectForKey:@"detailedArea"];
        self.detailedAreaCode = [aDecoder decodeObjectForKey:@"detailedAreaCode"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:@(_continent) forKey:@"continent"];
    [aCoder encodeObject:_continentCn forKey:@"continentCn"];
    [aCoder encodeObject:_continentEn forKey:@"continentEn"];
    [aCoder encodeObject:_countryCn forKey:@"countryCn"];
    [aCoder encodeObject:_countryEn forKey:@"countryEn"];
    [aCoder encodeObject:_countryCode forKey:@"countryCode"];
    [aCoder encodeObject:_detailedArea forKey:@"detailedArea"];
    [aCoder encodeObject:_detailedAreaCode forKey:@"detailedAreaCode"];
}

@end
