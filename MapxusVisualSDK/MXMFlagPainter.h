//
//  MXMFlagPainter.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/30.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>
#import "MXMNode.h"

NS_ASSUME_NONNULL_BEGIN


/**
 The code that executes after clicking the node.

 @param node The node which you click on the map.
 */
typedef void(^CircleOnClickBlock)(MXMNode *node);


/**
 The painter class of the collected line.
 */
@interface MXMFlagPainter : NSObject


/**
 The code that executes after clicking the node.
 */
@property (nonatomic, copy) CircleOnClickBlock circleOnClickBlock;


/**
 The initializer method of the painter.

 @param mapView The mapView which you want to paint on.
 @return The painter object.
 */
- (instancetype)initWithMapView:(MGLMapView *)mapView;


/**
 Clears the path drawn on the mapView.
 */
- (void)cleanLayer;


/**
 Switch corresponding to the line of building and floor. You can call this switching method in ` MapxusMapDelegate ` - mapView: didChangeFloor: atBuilding:.
 
 @param buildingId The id of the building which transmit to.
 @param floor The name of floor which transmit to.
 */
- (void)changeOnBuilding:(NSString *)buildingId floor:(NSString *)floor;


/**
 Gets the result and draws the line.

 @param result The result that MXMVisualSearchAPI request.
 */
- (void)renderFlagUsingResult:(NSArray *)result;

@end

NS_ASSUME_NONNULL_END
