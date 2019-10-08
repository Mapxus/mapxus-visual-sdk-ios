//
//  MXMVisualSearchOption.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/11.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The level of detail of the visual data
 - MXMVisualSearchScopeSimple: Just receive node IDs on the floor
 - MXMVisualSearchScopeDetail: Receive all detail of the node
 */
typedef NS_ENUM(NSUInteger, MXMVisualSearchScopeType) {
    MXMVisualSearchScopeSimple = 0,
    MXMVisualSearchScopeDetail
};


NS_ASSUME_NONNULL_BEGIN

/**
 Search visual data in building infomation class
 */
@interface MXMVisualBuildingSearchOption : NSObject

/// The buildingId which will search in
@property (nonatomic, strong) NSString *buildingId;
/// The level of detail of the visual data
@property (nonatomic, assign) MXMVisualSearchScopeType scope;

@end

NS_ASSUME_NONNULL_END
