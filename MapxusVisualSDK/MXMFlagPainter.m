//
//  MXMFlagPainter.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/30.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMFlagPainter.h"
#import "JXJsonFunctionDefine.h"
#import "MXMNodelist.h"

@interface MXMFlagPainter ()

@property (nonatomic, weak) MGLMapView *mapView;

@end

@implementation MXMFlagPainter

- (instancetype)initWithMapView:(MGLMapView *)mapView
{
    self = [super init];
    if (self) {
        self.mapView = mapView;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMapTap:)];
        [self.mapView addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)handleMapTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [tap locationInView:tap.view];
        CGFloat width = 10;
        CGRect rect = CGRectMake(point.x - width / 2, point.y - width / 2, width, width);
        
        NSArray *clusters = [self.mapView visibleFeaturesInRect:rect inStyleLayersWithIdentifiers:[NSSet setWithObject:@"clusteredPorts"]];
        
        if (clusters.count) {
            MGLPointFeature *cluster = (MGLPointFeature *)clusters.firstObject;
            NSDictionary *ext = cluster.attributes;
            if (self.circleOnClickBlock) {
                MXMNode *node = [[MXMNode alloc] init];
                node.key = DecodeStringFromDic(ext, @"key");
                node.buildingId = DecodeStringFromDic(ext, @"buildingId");
                node.floor = DecodeStringFromDic(ext, @"floor");
                node.latitude = [DecodeNumberFromDic(ext, @"lat") doubleValue];
                node.longitude = [DecodeNumberFromDic(ext, @"lon") doubleValue];
                node.bearing = [DecodeNumberFromDic(ext, @"bearing") doubleValue];
                self.circleOnClickBlock(node);
            }
        }
    }
}

- (void)cleanLayer
{
    MGLStyleLayer *layer1 = [self.mapView.style layerWithIdentifier:@"clusteredPorts"];
    
    layer1 ? [self.mapView.style removeLayer:layer1] : nil;
    
    MGLSource *source1 = [self.mapView.style sourceWithIdentifier:@"lineSource"];
    
    source1 ? [self.mapView.style removeSource:source1] : nil;
}

- (void)renderFlagUsingResult:(NSArray *)result
{
    [self cleanLayer];
    NSMutableArray *featureList = [NSMutableArray array];
    for (MXMNodelist *list in result) {
        for (MXMNode *node in list.nodes) {
            NSMutableDictionary *atts = [NSMutableDictionary dictionary];
            atts[@"buildingId"] = node.buildingId;
            atts[@"floor"] = node.floor;
            atts[@"key"] = node.key;
            atts[@"lat"] = @(node.latitude);
            atts[@"lon"] = @(node.longitude);
            atts[@"bearing"] = @(node.bearing);
            
            MGLPointFeature *PointFeature = [[MGLPointFeature alloc] init];
            PointFeature.coordinate = CLLocationCoordinate2DMake(node.latitude, node.longitude);
            PointFeature.attributes = atts;
            [featureList addObject:PointFeature];
        }
    }
    
    MGLShapeSource *source = [[MGLShapeSource alloc] initWithIdentifier:@"lineSource" features:featureList options:nil];

    MGLCircleStyleLayer *circlesLayer = [[MGLCircleStyleLayer alloc] initWithIdentifier:@"clusteredPorts" source:source];
    circlesLayer.circleOpacity = [NSExpression expressionForConstantValue:@0.75];
    circlesLayer.circleColor = [NSExpression expressionForConstantValue:[UIColor colorWithRed:73.0/255.0 green:177.0/255.0 blue:211.0/255.0 alpha:0.75]];
    NSDictionary *stops = @{
                            @15: @(1),
                            @16: @(3),
                            @17: @(4),
                            @18: @(5),
                            @19: @(7),
                            @20: @(8),
                            @22: @(18),
                            };
    circlesLayer.circleRadius = [NSExpression expressionWithFormat:@"mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', %@, %@)",
                                @0, stops];    
    [self.mapView.style addSource:source];
    [self.mapView.style addLayer:circlesLayer];
}

- (void)changeOnBuilding:(NSString *)buildingId floor:(NSString *)floor
{
    MGLVectorStyleLayer *lineLayer = (MGLVectorStyleLayer *)[self.mapView.style layerWithIdentifier:@"clusteredPorts"];
    lineLayer.predicate = [self createPredicateWith:lineLayer.predicate floor:floor building:buildingId];
}

- (NSPredicate *)createPredicateWith:(id)predicate floor:(NSString *)floorName building:(NSString *)buildingId
{
    NSPredicate *f = [NSPredicate predicateWithFormat:@"floor == %@", floorName];
    return f;
}


@end
