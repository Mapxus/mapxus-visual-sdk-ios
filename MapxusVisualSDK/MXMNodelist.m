//
//  MXMNodelist.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/1/7.
//  Copyright © 2019年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMNodelist.h"
#import <YYModel/YYModel.h>

@implementation MXMNodelist

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"floor" : @"floor.code",
             @"nodes" : @"images",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"nodes" : [MXMNode class],
             };
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
