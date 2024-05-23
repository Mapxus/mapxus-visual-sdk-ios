//
//  MXMNodeGroup.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/16.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapxusVisualSDK/MXMNode.h>

NS_ASSUME_NONNULL_BEGIN

/// `MXMNodeGroup` is a class that represents a list of nodes.
@interface MXMNodeGroup : NSObject


/// The ID of the floor where the nodes are printed.
@property (nonatomic, strong) NSString *floorId;


/// The nodes that are being printed.
@property (nonatomic, strong) NSArray<MXMNode *> *nodes;

@end

NS_ASSUME_NONNULL_END
