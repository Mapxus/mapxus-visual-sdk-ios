//
//  MXMVisualSearchOption.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/11.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

/// This enumeration defines the level of detail for the visual data.
typedef NS_ENUM(NSUInteger, MXMVisualSearchScopeType) {
  /// Only the node IDs on the floor are received.
  MXMVisualSearchScopeSimple = 0,
  /// All details of the node are received.
  MXMVisualSearchScopeDetail
};


NS_ASSUME_NONNULL_BEGIN

/// `MXMVisualBuildingSearchOption` is a class that encapsulates the options for a visual data search in a building.
@interface MXMVisualBuildingSearchOption : NSObject


/// The ID of the building to be searched.
@property (nonatomic, strong) NSString *buildingId;


/// The level of detail for the visual data.
@property (nonatomic, assign) MXMVisualSearchScopeType scope;

@end

NS_ASSUME_NONNULL_END
