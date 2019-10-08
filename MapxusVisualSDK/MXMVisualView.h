//
//  MXMVisualView.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/19.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMNode.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MXMVisualDelegate;


/**
 Basic image coordinates
 
 Basic image coordinates represents points in the original image adjusted for orientation.
 They range from 0 to 1 on both axes. The origin is in the top left corner of the image and
 the axes are directed according to the following for all image types.
 
 (0,0)                          (1, 0)
 +------------------------>
 |
 |
 |
 v                        +
 (0, 1)                         (1, 1)
 */
struct MXMVisualCoordinate2D {
    double x;
    double y;
};
typedef struct MXMVisualCoordinate2D MXMVisualCoordinate2D;



/**
 The Visual Viewer
 */
@interface MXMVisualView : UIView


/// The call back object pointer
@property (nonatomic, weak) id<MXMVisualDelegate> delegate;

/**
Load visual.
@param imgId The first image that visual view load with.
*/
- (void)loadVisualViewWithFristImg:(nullable NSString *)imgId;

/**
 Unload visual
 */
- (void)unloadVisualView;

/**
 Navigate to a given photo key.
 @param key A valid Beeview photo key.
 */
- (void)moveToKey:(NSString *)key;

/**
 Move close to given latitude and longitude.
 @param buildingId Image belong building id.
 @param floor Image belong floor code.
 @param latitude Latitude, in degrees.
 @param longitude Longitude, in degrees.
 */
- (void)moveCloseToBuilding:(NSString *)buildingId
                      floor:(NSString *)floor
                   latitude:(double)latitude
                  longitude:(double)longitude;

/**
 Detect the viewer's new width and height and resize it.
 The components will also detect the viewer's new size
 and resize their rendered elements if needed.
 */
- (void)resize;

/**
 Get the bearing of the current viewer camera.
 @return The bearing depends on how the camera is currently rotated and does not
 correspond to the compass angle of the current node if the view has been
 panned. Bearing is measured in degrees clockwise with respect to north.
 */
- (double)getBearing;

/**
 Set the photo's pan to bearing.
 Provide the angle (0 - 360), to pan rotation photo's bearing.
 @param bearing The photo's pan to bearing.
 */
- (void)setBearing:(double)bearing;

/**
 Get the basic coordinates of the current photo that is
 at the center of the viewport.
 Basic coordinates are 2D coordinates on the [0, 1] interval and have
 the origin point, (0, 0), at the top left corner and the maximum value, (1, 1),
 at the bottom right corner of the original image.
 @param block result block
 */
- (void)getVisualCenter:(void (^)(MXMVisualCoordinate2D center))block;

/**
 Get the basic coordinates of the current photo that is at the center of the viewport.
 Basic coordinates are 2D coordinates on the [0, 1] interval
 and have the origin point, (0, 0), at the top left corner and the
 maximum value, (1, 1), at the bottom right corner of the original
 photo.
 @param center Promise to the basic coordinates of the current photo at the center for the viewport.
 */
- (void)setVisualCenter:(MXMVisualCoordinate2D)center;

/**
 Get the image's current zoom level.
 @param block result
 */
- (void)getZoom:(void (^)(double zoom))block;

/**
 Set the photo's current zoom level.
 Possible zoom level values are on the [0, 3] interval.
 Zero means zooming out to fit the photo to the view whereas three
 shows the highest level of detail.
 @param zoom The level which you want to zoom.
 */
- (void)setZoom:(double)zoom;

/**
 Activate the compass
 */
- (void)activateBearing;

/**
 Deactivate the compass
 */
- (void)deactivateBearing;

@end



/**
 Visual Delegate
 */
@protocol MXMVisualDelegate <NSObject>

@optional
/**
 Fired when the viewer load fail.
 @param view The view which send event.
 @param error The description why load fail.
 */
- (void)visualView:(MXMVisualView *)view didFailWithError:(NSError *)error;

/**
 Fired when the view render complete.
 @param view The view which send event.
 */
- (void)visualViewRenderComplete:(MXMVisualView *)view;

/**
 Fired when the viewer is loading more data.
 @param view The view which send event.
 @param isLoading Boolean indicating whether the viewer is loading.
 */
- (void)visualView:(MXMVisualView *)view didLoadingChanged:(BOOL)isLoading;

/**
 Fired when the viewing direction of the camera changes.
 @param view The view which send event.
 @param bearing Value indicating the current bearing measured in degrees clockwise with respect to north.
 */
- (void)visualView:(MXMVisualView *)view didBearingChanged:(double)bearing;

/**
 Fired every time the viewer navigates to a new node.
 @param view The view which send event.
 @param node Current node.
 */
- (void)visualView:(MXMVisualView *)view didNodeChanged:(MXMNode *)node;

@end

NS_ASSUME_NONNULL_END
