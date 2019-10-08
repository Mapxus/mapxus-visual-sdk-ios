//
//  MXMVisualSearchOption.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/11.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMVisualSearchOption.h"

@implementation MXMVisualBuildingSearchOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buildingId = @"";
        self.scope = MXMVisualSearchScopeSimple;
    }
    return self;
}

@end
