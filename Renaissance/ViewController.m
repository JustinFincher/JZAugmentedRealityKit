//
//  ViewController.m
//  Renaissance
//
//  Created by Fincher Justin on 15/12/20.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import "ViewController.h"
#import <MapBox/MapBox.h>

@interface ViewController () <MGLMapViewDelegate>

@property (nonatomic) MGLMapView *mapView;
@property (nonatomic) SCNGeometry *mapPlaneGeometry;
@property (nonatomic) SCNMaterial *mapPlaneMaterial;

@end

@implementation ViewController
@synthesize mapScene,mapBackgroundNode,mapPlaneGeometry,mapPlaneMaterial;
@synthesize sceneView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // initialize the map view
    NSURL *styleURL = [NSURL URLWithString:@"mapbox://styles/justzht/ciiehn6os003h9xkjn22i5gnq"];
    self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds
                                                   styleURL:styleURL];
    
    // Set the delegate property of our map view to self after instantiating it.
    self.mapView.delegate = self;
    
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.mapView setZoomLevel:10 animated:YES];
    //[self.view addSubview:self.mapView];
    
    //先隐藏掉LOGO
    [self.mapView.logoView setHidden:YES];
    //[self.mapView.attributionButton setHidden:YES];
    
    [self.mapView setUserTrackingMode:MGLUserTrackingModeFollowWithHeading];
    
    mapScene = [SCNScene scene];
    mapPlaneGeometry = [SCNPlane planeWithWidth:200 height:200];
    mapBackgroundNode.geometry = mapPlaneGeometry;
    mapPlaneMaterial = [SCNMaterial material];
    mapPlaneMaterial.diffuse.contents = self.mapView.layer;
    mapPlaneGeometry.materials = @[mapPlaneMaterial];
    [mapScene.rootNode addChildNode:mapBackgroundNode];
    
    
    sceneView = [[SCNView alloc] initWithFrame:self.view.bounds];
    sceneView.scene = mapScene;
    
    [self.view addSubview:sceneView];
    sceneView.allowsCameraControl = YES;
    
    
    
    
}

// Always show a callout when an annotation is tapped.
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
