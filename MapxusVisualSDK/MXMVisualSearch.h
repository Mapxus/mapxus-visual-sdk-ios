//
//  MXMVisualSearch.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/11.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXMVisualSearchOption.h"
#import "MXMNodeGroup.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MXMVisualSearchDelegate;

/**
 Visual data search service
 */
@interface MXMVisualSearch : NSObject

/// The object that acts as the delegate of the visual search
@property (nonatomic, weak) id<MXMVisualSearchDelegate> delegate;

/**
 Search visual data in building
 @param option Search parameter
 @return Network request task id
 */
- (NSInteger)searchVisualDataInBuilding:(MXMVisualBuildingSearchOption *)option;

@end



#pragma mark - MXMVisualSearchDelegate

/**
 Visual data search delegate
 */
@protocol MXMVisualSearchDelegate <NSObject>

/**
 The callback method that visual data search in building
 @param searcher The object who send the request
 @param list Visual data list
 @param error Request error
 */
- (void)onGetVisualDataInBuilding:(MXMVisualSearch *)searcher result:(nullable NSArray<MXMNodeGroup *> *)list error:(nullable NSError *)error;

@end


NS_ASSUME_NONNULL_END
