//
//  ARNode.m
//  Renaissance
//
//  Created by Fincher Justin on 15/12/22.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//


#import "ARNode.h"

@implementation ARNode
@synthesize ARView,planeGeometry;
@synthesize nodeLocation,playerLocation;


- (void)setNodeWithARView:(UIView *)view
             nodeLocation:(CLLocation *)nodeCLLocation
           playerLocation:(CLLocation *)playerCLLocation
{
    NSLog(@"setNodeWithARView");
    self.ARView = view;
    //ARView.transform = CGAffineTransformMakeScale(-1, -1);
    ARView.layer.geometryFlipped = YES;
    self.nodeLocation = nodeCLLocation;
    self.playerLocation = playerCLLocation;
    //SCNBox * boxGeometry = [SCNBox boxWithWidth:100 height:100 length:100 chamferRadius:10];
    planeGeometry = [SCNPlane planeWithWidth:view.bounds.size.width/4 height:view.bounds.size.height/4];
    planeGeometry.cornerRadius = 5;
    self.geometry = planeGeometry;
    SCNMaterial *planeMaterial = [SCNMaterial material];
    planeMaterial.diffuse.contents = ARView.layer;
    //planeMaterial.diffuse.contents = [self imageWithView:ARView];
    planeGeometry.materials = @[planeMaterial];
    planeMaterial.doubleSided = YES;
    
    
    //self.scale = SCNVector3Make(-1, 1, 1);
    
    CLLocationDistance lineMeters = [nodeLocation distanceFromLocation:playerLocation];
    
    // ^ latitude
    // |
    // * ---- +
    // | l1   | node
    // |      |
    // |      |
    // + ---- * ---> longitudes
    // player  l2
    CLLocation * locationOne = [[CLLocation alloc] initWithLatitude:nodeLocation.coordinate.latitude longitude:playerLocation.coordinate.longitude];
    CLLocation * locationTwo = [[CLLocation alloc] initWithLatitude:playerLocation.coordinate.latitude longitude:nodeLocation.coordinate.longitude];
    
    CLLocationDistance longitudeDistance = [playerLocation distanceFromLocation:locationTwo];
    CLLocationDistance latitudeDistance = [playerLocation distanceFromLocation:locationOne];
    
    double longitudePosition,latitudePosition;
    if ((nodeLocation.coordinate.longitude - playerLocation.coordinate.longitude)>0 || (nodeLocation.coordinate.longitude - playerLocation.coordinate.longitude)<180)
    {
        longitudePosition = longitudeDistance;
    }else
    {
        longitudePosition = -longitudeDistance;
    }
    
    if ((nodeLocation.coordinate.latitude - playerLocation.coordinate.latitude)>0)
    {
        latitudePosition = latitudeDistance;
    }else
    {
        latitudePosition = -latitudeDistance;
    }
    
    
    NSLog(@"longitudeDistance : %f latitudeDistance : %f",longitudePosition,latitudePosition);
    
    //self.position = SCNVector3Make(longitudePosition, lineMeters / 6, latitudePosition);

    self.position = SCNVector3Make(latitudePosition, lineMeters / 6, longitudePosition);

    SCNNode *virtualCameraNode = [SCNNode node];
    virtualCameraNode.position = SCNVector3Make(0, 0, 0);
    self.constraints = @[[SCNLookAtConstraint lookAtConstraintWithTarget:virtualCameraNode]];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return img;
}


@end
