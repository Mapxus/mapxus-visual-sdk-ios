//
//  MXMNodeGroup.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/16.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXMNode.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Node list class
 */
@interface MXMNodeGroup : NSObject

/// The floor where the nodes print on
@property (nonatomic, strong) NSString *floor;
/// Printting nodes
@property (nonatomic, strong) NSArray<MXMNode *> *nodes;

@end

NS_ASSUME_NONNULL_END
