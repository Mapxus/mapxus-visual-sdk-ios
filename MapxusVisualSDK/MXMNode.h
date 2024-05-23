//
//  MXMNode.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/12/19.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// `MXMNode` represents a node in the navigation graph.
@interface MXMNode : NSObject


/// The unique key of the node.
@property (nonatomic, strong) NSString *key;


/// The ID of the floor where the node is located.
@property (nonatomic, strong) NSString *floorId;


/// The ID of the building where the node is located.
@property (nonatomic, strong) NSString *buildingId;


/// The latitude of the node in WGS84 datum, measured in degrees.
@property (nonatomic, assign) double latitude;


/// The longitude of the node in WGS84 datum, measured in degrees.
@property (nonatomic, assign) double longitude;


/// The compass angle of the node, measured in degrees clockwise with respect to north.
@property (nonatomic, assign) double bearing;


/// This class method creates an `MXMNode` object from a dictionary.
///
/// @param nodeDic The dictionary containing the node data.
/// @return An `MXMNode` object.
+ (MXMNode *)creatNodeFrom:(NSDictionary<NSString*, id> *)nodeDic;


/// This instance method converts the `MXMNode` object to a dictionary. The keys in the dictionary are the names of the parameters.
///
/// @return A dictionary containing the parameters of the `MXMNode` object.
- (NSDictionary<NSString*, id> *)toJson;

@end

NS_ASSUME_NONNULL_END
