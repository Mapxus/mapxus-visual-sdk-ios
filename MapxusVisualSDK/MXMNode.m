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
    return @{@"buildingId" : @[@"building.id", @"buildingId"],
             @"floor" : @[@"floor.code", @"floor"],
             @"latitude" : @[@"l.lat", @"latitude"],
             @"longitude" : @[@"l.lon", @"longitude"],
             @"bearing" : @[@"ca", @"bearing"],
             };
}

+ (MXMNode *)creatNodeFrom:(NSDictionary<NSString*, id> *)nodeDic
{
    return [MXMNode yy_modelWithJSON:nodeDic];
}

- (NSDictionary<NSString*, id> *)toJson
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"key"] = self.key;
    dic[@"buildingId"] = self.buildingId;
    dic[@"floor"] = self.floor;
    dic[@"latitude"] = @(self.latitude);
    dic[@"longitude"] = @(self.longitude);
    dic[@"bearing"] = @(self.bearing);

    return [dic copy];
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
