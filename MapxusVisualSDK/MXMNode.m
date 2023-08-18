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
    return @{@"buildingId" : @[@"buildingId", @"building.id"],
             @"floorId" : @[@"floorId", @"floor.id"],
             @"latitude" : @[@"latitude", @"lat", @"l.lat"],
             @"longitude" : @[@"longitude", @"lon", @"l.lon"],
             @"bearing" : @[@"bearing", @"ca"],
             };
}

+ (MXMNode *)creatNodeFrom:(NSDictionary<NSString*, id> *)nodeDic
{
    return [MXMNode yy_modelWithJSON:nodeDic];
}

- (NSDictionary<NSString*, id> *)toJson
{
    NSMutableDictionary *dic = [self yy_modelToJSONObject];
  
//    dic[@"key"] = self.key;
//    dic[@"buildingId"] = self.buildingId;
//    dic[@"latitude"] = @(self.latitude);
//    dic[@"longitude"] = @(self.longitude);
//    dic[@"bearing"] = @(self.bearing);

    return dic;
}

- (NSString *)description
{
    return [self yy_modelDescription];
}

@end
