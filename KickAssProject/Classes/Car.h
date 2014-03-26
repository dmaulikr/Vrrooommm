//
//  Car.h
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-25.
//  Copyright (c) 2014 Comp4768. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Car : CCNode

@property float mass;
@property float x_Pos;
@property float y_Pos;
@property float x_Vel;
@property float y_Vel;
@property float car_Width;
@property float car_Height;

- (id) initCarWithMass:(float)mass withXPos:(float)x_Pos withYPos:(float)y_Pos file:(NSString *) filename;
- (void) update;
- (void) draw;

@end