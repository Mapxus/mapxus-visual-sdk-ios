//
//  MXMVisualView.h
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/19.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapxusVisualSDK/MXMNode.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MXMVisualDelegate;



/// Basic image coordinates
///
/// Basic image coordinates represent points in the original image adjusted for orientation.
/// They range from 0 to 1 on both axes. The origin is in the top left corner of the image and
/// the axes are directed according to the following for all image types.
///
/// (0,0)                          (1, 0)
/// +------------------------>
/// |
/// |
/// |
/// v                        +
/// (0, 1)                         (1, 1)
struct MXMVisualCoordinate2D {
  double x;
  double y;
};
typedef struct MXMVisualCoordinate2D MXMVisualCoordinate2D;



/// The Visual Viewer
@interface MXMVisualView : UIView


/// The delegate object for the visual view
@property (nonatomic, weak) id<MXMVisualDelegate> delegate;


/// Load the visual view with the first image.
///
/// @param imgId The ID of the first image that the visual view loads with.
- (void)loadVisualViewWithFristImg:(nullable NSString *)imgId;


/// Unload the visual view.
- (void)unloadVisualView;


/// Navigate to a given photo key.
///
/// @param key A valid visual view photo key.
- (void)moveToKey:(NSString *)key;


/// Move close to a given latitude and longitude.
///
/// @param floorId The ID of the floor that the image belongs to.
/// @param latitude The latitude in degrees.
/// @param longitude The longitude in degrees.
- (void)moveCloseToFloorId:(NSString *)floorId
                  latitude:(double)latitude
                 longitude:(double)longitude;


/// Detect the viewer's new width and height and resize it.
/// The components will also detect the viewer's new size and resize their rendered elements if needed.
- (void)resize;


/// Get the bearing of the current viewer camera.
///
/// @return The bearing depends on how the camera is currently rotated and does not correspond to the compass angle of the current node if the view has been
/// panned. Bearing is measured in degrees clockwise with respect to north.
- (double)getBearing;


/// Set the photo's pan to a given bearing.
///
/// @param bearing The bearing to which the photo's pan is set.
///
/// @discussion
/// Provide the angle (0 - 360), to pan rotation photo's bearing.
- (void)setBearing:(double)bearing;


/// Get the basic coordinates of the current photo that is at the center of the viewport.
///
/// @param block The block to return the result.
///
/// @discussion
/// Basic coordinates are 2D coordinates on the [0, 1] interval and have the origin point, (0, 0), at the top left corner and the maximum value, (1, 1), at the bottom
/// right corner of the original image.
- (void)getVisualCenter:(void (^)(MXMVisualCoordinate2D center))block;


/// Set the basic coordinates of the current photo that is at the center of the viewport.
///
/// @param center The basic coordinates of the current photo at the center of the viewport.
///
/// @discussion
/// Basic coordinates are 2D coordinates on the [0, 1] interval and have the origin point, (0, 0), at the top left corner and the maximum value, (1, 1), at the bottom
/// right corner of the original photo.
- (void)setVisualCenter:(MXMVisualCoordinate2D)center;


/// Get the image's current zoom level.
///
/// @param block The block to return the result.
- (void)getZoom:(void (^)(double zoom))block;


/// Set the photo's current zoom level.
///
/// @param zoom The level to which you want to zoom.
///
/// @discussion
/// Possible zoom level values are on the [0, 3] interval.
/// Zero means zooming out to fit the photo to the view whereas three shows the highest level of detail.
- (void)setZoom:(double)zoom;


/// Activate the compass.
- (void)activateBearing;


/// Deactivate the compass.
- (void)deactivateBearing;

@end



/// This protocol defines the delegate methods for the MXMVisualView.
@protocol MXMVisualDelegate <NSObject>


@optional
/// This method is called when the viewer fails to load.
///
/// @param view The MXMVisualView instance that is sending the event.
/// @param error An NSError object that describes why the load failed.
- (void)visualView:(MXMVisualView *)view didFailWithError:(NSError *)error;


/// This method is called when the view has completed rendering.
///
/// @param view The MXMVisualView instance that is sending the event.
- (void)visualViewRenderComplete:(MXMVisualView *)view;


/// This method is called when the viewer's loading state changes.
///
/// @param view The MXMVisualView instance that is sending the event.
/// @param isLoading A Boolean value indicating whether the viewer is currently loading data.
- (void)visualView:(MXMVisualView *)view didLoadingChanged:(BOOL)isLoading;


/// This method is called when the viewing direction of the camera changes.
///
/// @param view The MXMVisualView instance that is sending the event.
/// @param bearing A double-precision value that represents the current orientation of the camera, measured in degrees in a clockwise direction from the north.
- (void)visualView:(MXMVisualView *)view didBearingChanged:(double)bearing;


/// This method is called every time the viewer navigates to a new node.
///
/// @param view The MXMVisualView instance that is sending the event.
/// @param node The new node that the viewer has navigated to.
- (void)visualView:(MXMVisualView *)view didNodeChanged:(MXMNode *)node;

@end

NS_ASSUME_NONNULL_END
