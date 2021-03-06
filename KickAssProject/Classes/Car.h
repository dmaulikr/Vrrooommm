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

#define MAX_SPEED 150

@interface Car : CCNode

@property float mass;
@property float x_Pos;
@property float y_Pos;
@property float x_Correction;
@property float y_Correction;
@property float x_Vel;
@property float y_Vel;
@property float car_Width;
@property float car_Height;
@property NSString* direction;
@property float angle;
@property float radian;
@property float lastMessage;

- (id) initCarWithMass:(float)mass withXPos:(float)x_Pos withYPos:(float)y_Pos withScaleX:(float)scalex withScaleY:(float)scaley file:(NSString *) filename;
- (void) setSpeedLimit:(float)limit;
- (void) resetSpeedLimit;
- (void) update:(CCTime) delta;
- (void) turnRight:(float) ang;
- (void) turnLeft:(float) ang;
- (void) straight;
- (void) checkCol:(float) width andHeight:(float) height;
- (void) updateWithXPos:(float)x andYPos:(float)y andXVel:(float)xVel andYVel:(float)yVel andAngle:(float)a;


@end
