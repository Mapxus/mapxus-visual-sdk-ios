//
//  MXMNode.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/12/19.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Represents a node in the navigation graph.
 */
@interface MXMNode : NSObject
/// Unique key of the node.
@property (nonatomic, strong) NSString *key;
/// The building where the node is located.
@property (nonatomic, strong) NSString *buildingId;
/// The floor where the node is located.
@property (nonatomic, strong) NSString *floor;
/// Latitude in WGS84 datum, measured in degrees.
@property (nonatomic, assign) double latitude;
/// Longitude in WGS84 datum, measured in degrees.
@property (nonatomic, assign) double longitude;
/// Compass angle, measured in degrees clockwise with respect to north.
@property (nonatomic, assign) double bearing;

/// Convert from dictionary to MXMNode object
/// @param nodeDic node dictionary
+ (MXMNode *)creatNodeFrom:(NSDictionary<NSString*, id> *)nodeDic;

/**
 Change the MXMNode object to NSDictionary, the key is the string of paramer's name
 @return The dictionary contain paramers
 */
- (NSDictionary<NSString*, id> *)toJson;

@end

NS_ASSUME_NONNULL_END
