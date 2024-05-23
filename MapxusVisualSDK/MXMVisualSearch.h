//
//  MXMVisualSearch.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/11.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapxusVisualSDK/MXMVisualSearchOption.h>
#import <MapxusVisualSDK/MXMNodeGroup.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MXMVisualSearchDelegate;

/// `MXMVisualSearch` is a class that provides a service for searching visual data.
@interface MXMVisualSearch : NSObject


/// The delegate object that will receive the search results.
@property (nonatomic, weak) id<MXMVisualSearchDelegate> delegate;


/// This method initiates a search for visual data in a building.
/// 
/// @param option The parameters for the search.
/// @return The ID of the network request task.
- (NSInteger)searchVisualDataInBuilding:(MXMVisualBuildingSearchOption *)option;

@end



#pragma mark - MXMVisualSearchDelegate

/// The delegate protocol for receiving search results from `MXMVisualSearch`.
@protocol MXMVisualSearchDelegate <NSObject>


/// This method is called when the search for visual data in a building is complete.
///
/// @param searcher The `MXMVisualSearch` object that performed the search.
/// @param list The list of visual data results.
/// @param error Any error that occurred during the search.
- (void)onGetVisualDataInBuilding:(MXMVisualSearch *)searcher result:(nullable NSArray<MXMNodeGroup *> *)list error:(nullable NSError *)error;

@end


NS_ASSUME_NONNULL_END
