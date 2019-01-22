//
//  MXMVisualSearchAPI.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/30.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 查询回调
 */
@protocol MXMVisualSearchAPIDelegate <NSObject>


/**
 查询成功返回

 @param result 返回的结果
 */
- (void)visualNodesSearchSuccess:(NSArray *)result;


/**
 失败回调

 @param error 错误解释
 */
- (void)visualSearchFailure:(NSError *)error;

@end


/**
 Visual SDK query interface.
 */
@interface MXMVisualSearchAPI : NSObject


/**
 Handle to a callback
 */
@property (nonatomic, weak) id<MXMVisualSearchAPIDelegate> delegate;


/**
 Query all nodes that in the building

 @param buildingId The identifier of building which you want to query.
 */
- (void)searchNodesOnBuilding:(NSString *)buildingId;

@end

NS_ASSUME_NONNULL_END
