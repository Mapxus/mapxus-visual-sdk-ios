//
//  MXMVisualView.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/19.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMVisualView.h"
#import <WebKit/WebKit.h>
#import "JXJsonFunctionDefine.h"
#import "MXMMapServices+Private.h"

@interface MXMVisualView () <WKNavigationDelegate, WKScriptMessageHandler> {
    WKWebView* _webview;
    BOOL _isWebviewLoaded;
    NSMutableArray* _jsQueue;
    
    double _bearing;
    void (^ _centerBlock)(MXMVisualCoordinate2D center);
    void (^ _zoomBlock)(double zoom);

}

@end

@implementation MXMVisualView

- (void)loadVisualViewWithFristImg:(nullable NSString *)imgId
{
    _isWebviewLoaded = NO;
    _jsQueue = [[NSMutableArray alloc] init];

    /*
     * Loads the webview
     */
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"MXMVisualEvent"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    [configuration setUserContentController:userContentController];
    configuration.allowsPictureInPictureMediaPlayback = YES;
    
    _webview = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    _webview.navigationDelegate = self;
    [self addSubview:_webview];

    _webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSBundle *bundle = [NSBundle bundleForClass:[MXMVisualView class]];
    NSString *path = [bundle pathForResource:@"MXMVisualBrowse" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webview loadRequest:request];
    _webview.scrollView.bounces = NO;

    // initialize visual and add visualView Listen
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    
    NSMutableString* js = [[NSMutableString alloc] init];
    if (imgId) {
        [js appendString:[NSString stringWithFormat:@"initializeVisualViewWithAppId('%@', '%@', '%@', '%@');", [MXMMapServices sharedServices].apiKey, [MXMMapServices sharedServices].secret, bundleId, imgId]];
    } else {
        [js appendString:[NSString stringWithFormat:@"initializeVisualViewWithAppId('%@', '%@', '%@');", [MXMMapServices sharedServices].apiKey, [MXMMapServices sharedServices].secret, bundleId]];
    }
    [js appendString:@"visualView.on('loadingchanged', function(e){ window.webkit.messageHandlers.MXMVisualEvent.postMessage({type:'loadingchanged', loadingchanged:e}); });"];
    [js appendString:@"visualView.on('bearingchanged', function(e){ window.webkit.messageHandlers.MXMVisualEvent.postMessage({type:'bearingchanged', bearing:e}); });"];
    [js appendString:@"visualView.on('nodechanged', function(e){ window.webkit.messageHandlers.MXMVisualEvent.postMessage({type:'nodechanged', buildingId:e.building.id, floorId:e.floor.id, latitude:e.latLon.lat, longitude:e.latLon.lon, bearing:e.ca, key:e.key }); });"];
    [js appendString:@"visualView.renderComplete(function(){ window.webkit.messageHandlers.MXMVisualEvent.postMessage({type:'renderComplete'}); });"];
    [self executeJS:js];
}

- (void)unloadVisualView
{
    [_webview.configuration.userContentController removeScriptMessageHandlerForName:@"MXMVisualEvent"];
}

- (void)moveToKey:(NSString *)key
{
    [self executeJS:[NSString stringWithFormat:@"visualView.moveToKey('%@')", key]];
}

- (void)moveCloseToFloorId:(NSString *)floorId latitude:(double)latitude longitude:(double)longitude
{
    [self executeJS:[NSString stringWithFormat:@"visualView.moveCloseTo(%@, %@, '%@', '%@', 20)", @(latitude), @(longitude), floorId, @""]];
}

- (void)resize
{
    [self executeJS:@"setTimeout(function(){visualView.resize()}, 50)"];
}

- (double)getBearing
{
    return _bearing;
}

- (void)setBearing:(double)bearing
{
    [self executeJS:[NSString stringWithFormat:@"visualView.setBearing(%@)", @(bearing)]];
}

- (void)getVisualCenter:(void (^)(MXMVisualCoordinate2D center))block
{
    _centerBlock = block;
    [self executeJS:@"visualView.getCenter().then((e) => {window.webkit.messageHandlers.MXMVisualEvent.postMessage({type:'getCenter', center:e});})"];
}

- (void)setVisualCenter:(MXMVisualCoordinate2D)center
{
    [self executeJS:[NSString stringWithFormat:@"visualView.setCenter([%@, %@])", @(center.x), @(center.y)]];
}

- (void)getZoom:(void (^)(double zoom))block
{
    _zoomBlock = block;
    [self executeJS:@"visualView.getZoom().then((e) => {window.webkit.messageHandlers.MXMVisualEvent.postMessage({type:'getZoom', zoom:e});})"];
}

- (void)setZoom:(double)zoom
{
    [self executeJS:[NSString stringWithFormat:@"visualView.setZoom(%@)", @(zoom)]];
}

- (void)activateComponent:(NSString *)component
{
    [self executeJS:[NSString stringWithFormat:@"visualView.activateComponent('%@')", component]];
}

- (void)deactivateComponent:(NSString *)component
{
    [self executeJS:[NSString stringWithFormat:@"visualView.deactivateComponent('%@')", component]];
}

- (void)activateBearing
{
    [self activateComponent:@"bearing"];
}

- (void)deactivateBearing
{
    [self deactivateComponent:@"bearing"];
}

- (void)executeJS:(NSString*) js {
    
    if (_isWebviewLoaded) {
        [_webview evaluateJavaScript:js completionHandler:^(id result, NSError *error) {
            if (error != nil) {
                if (error.code != 5 && [self.delegate respondsToSelector:@selector(visualView:didFailWithError:)]) {
                    NSError* err = [[NSError alloc] initWithDomain:@"MXMErrorDomain" code:1936 userInfo:nil];
                    [self.delegate visualView:self didFailWithError:err];
                }
            }
        }];
    } else {
        [_jsQueue addObject:js];
    }
}

/*
 * Handle the full load of the webview. Any command that was queued so far is executed.
 */
- (void)webView:(WKWebView *)_webView didFinishNavigation:(WKNavigation *)navigation {
    while ([_jsQueue count] > 0) {
        NSString* js = [_jsQueue objectAtIndex:0];
        [_jsQueue removeObjectAtIndex:0];
        [_webview evaluateJavaScript:js completionHandler:^(id result, NSError *error) {
            if (error != nil) {
                if (error.code != 5 && [self.delegate respondsToSelector:@selector(visualView:didFailWithError:)]) {
                    NSError* err = [[NSError alloc] initWithDomain:@"MXMErrorDomain" code:1936 userInfo:nil];
                    [self.delegate visualView:self didFailWithError:err];
                }
            }
        }];
    }
    _isWebviewLoaded = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(visualView:didFailWithError:)]) {
        [self.delegate visualView:self didFailWithError:error];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(visualView:didFailWithError:)]) {
        [self.delegate visualView:self didFailWithError:error];
    }
}

/*
 * Handle the events sent by the js sdk
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSDictionary* body = message.body;
    
    if ([body[@"type"] isEqualToString:@"loadingchanged"]) {
        
        if ([self.delegate respondsToSelector:@selector(visualView:didLoadingChanged:)]) {
            BOOL isLoadingChanged = [DecodeNumberFromDic(body, @"loadingchanged") boolValue];
            [self.delegate visualView:self didLoadingChanged:isLoadingChanged];
        }
    }
    else if ([body[@"type"] isEqualToString:@"bearingchanged"]) {
        
        _bearing = [DecodeNumberFromDic(body, @"bearing") doubleValue];
        if ([self.delegate respondsToSelector:@selector(visualView:didBearingChanged:)]) {
            [self.delegate visualView:self didBearingChanged:_bearing];
        }
    }
    else if ([body[@"type"] isEqualToString:@"nodechanged"]) {
        
        if ([self.delegate respondsToSelector:@selector(visualView:didNodeChanged:)]) {
            MXMNode *node = [MXMNode creatNodeFrom:body];
//            node.key = DecodeStringFromDic(body, @"key");
//            node.buildingId = DecodeStringFromDic(body, @"buildingId");
//            node.latitude = [DecodeNumberFromDic(body, @"lat") doubleValue];
//            node.longitude = [DecodeNumberFromDic(body, @"lon") doubleValue];
//            node.bearing = [DecodeNumberFromDic(body, @"ca") doubleValue];
            [self.delegate visualView:self didNodeChanged:node];
        }
    }
    else if ([body[@"type"] isEqualToString:@"getCenter"]) {
        
        NSArray *e = DecodeArrayFromDic(body, @"center");
        MXMVisualCoordinate2D center;
        center.x = [e.firstObject doubleValue];
        center.y = [e.lastObject doubleValue];
        _centerBlock(center);
    }
    else if ([body[@"type"] isEqualToString:@"getZoom"]) {
        
        double zoom = [DecodeNumberFromDic(body, @"zoom") doubleValue];
        _zoomBlock(zoom);
    }
    else if ([body[@"type"] isEqualToString:@"renderComplete"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(visualViewRenderComplete:)]) {
            [self.delegate visualViewRenderComplete:self];
        }
    }
}

@end
