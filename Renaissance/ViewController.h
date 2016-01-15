//
//  ViewController.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/20.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SceneKit;

@interface ViewController : UIViewController

@property (nonatomic,strong) SCNScene * mapScene;
@property (nonatomic,strong) SCNNode *mapBackgroundNode;
@property (nonatomic,strong) SCNView *sceneView;

@end

