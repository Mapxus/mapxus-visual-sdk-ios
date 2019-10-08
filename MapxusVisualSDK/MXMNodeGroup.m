//
//  MXMNodeGroup.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/16.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMNodeGroup.h"
#import <YYModel/YYModel.h>

@implementation MXMNodeGroup

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
