//
//  MXMNode.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/12/19.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMNode.h"
#import <YYModel/YYModel.h>

@implementation MXMNode

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"buildingId" : @"building.id",
             @"floor" : @"floor.code",
             @"latitude" : @"l.lat",
             @"longitude" : @"l.lon",
             @"bearing" : @"ca",
             };
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
