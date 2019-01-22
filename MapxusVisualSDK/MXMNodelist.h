//
//  MXMNodelist.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/1/7.
//  Copyright © 2019年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXMNode.h"

NS_ASSUME_NONNULL_BEGIN


/**
 <#Description#>
 */
@interface MXMNodelist : NSObject


/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *floor;


/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray<MXMNode *> *nodes;

@end

NS_ASSUME_NONNULL_END
