//
//  Car.m
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-25.
//  Copyright (c) 2014 Comp4768. All rights reserved.
//

#import "Car.h"

@implementation Car
{
    CCSprite *carSprite;
    float rot;
    float MAX_SPEED;
}

- (id) initCarWithMass:(float)mass withXPos:(float)x_Pos withYPos:(float)y_Pos withScaleX:(float)scalex withScaleY:(float)scaley file:(NSString *)filename
{
    self = [super init];
    
    if (self) {
        MAX_SPEED = 150;
        [self setX_Pos:x_Pos];
        [self setY_Pos:y_Pos];
        rot = 0;
        carSprite = [CCSprite spriteWithImageNamed:filename];
        carSprite.position = ccp(self.x_Pos, self.y_Pos);
        carSprite.scaleX = scalex;
        carSprite.scaleY = scaley;
        [self addChild:carSprite];
        
        [self setMass:mass];
        [self setCar_Width:[carSprite boundingBox].size.width*scalex];
        [self setCar_Height:[carSprite boundingBox].size.height*scaley];
        NSLog(@"I created a Car at (%f, %f) width: %f height: %f", self.x_Pos, self.y_Pos, self.car_Width, self.car_Height);
        
    }
    return self;
}

- (void) update:(CCTime) delta
{
    
    self.radian = self.angle*(M_PI/180);
    
    if (self.x_Vel > MAX_SPEED) {
        self.x_Vel = MAX_SPEED;
    }
    
    if (self.y_Vel > MAX_SPEED) {
        self.y_Vel = MAX_SPEED;
    }
    
    self.x_Pos = self.x_Pos + self.x_Vel*delta*cos(self.radian);
    self.y_Pos = self.y_Pos + self.y_Vel*delta*sin(self.radian);
    
    carSprite.position = ccp(self.x_Pos, self.y_Pos);
}

- (void) checkCol:(float) width andHeight:(float) height
{
    //NSLog(@"Height: %f, Width: %f , X_Pos: %f , Y_Pos: %f", height, width, self.x_Pos, self.y_Pos);
    //To Far Right
    if (self.x_Pos + self.car_Width/2 > width) {
        self.x_Pos = width - self.car_Width/2;
    }
    
    //To Far Left
    if (self.x_Pos - self.car_Width/2 < 0) {
        self.x_Pos = self.car_Width/2;
    }
    
    //To Far Up
    if (self.y_Pos + self.car_Height/2 > height) {
        self.y_Pos = height - self.car_Height/2;
    }
    
    //To Far down
    if (self.y_Pos - self.car_Height/2 < 0) {
        self.y_Pos = self.car_Height/2;
    }

}

- (void) turnRight:(float) ang
{
    self.angle -= ang;
    carSprite.rotation += ang;
}

- (void) turnLeft:(float) ang
{
    self.angle += ang*-1.0;
    carSprite.rotation -= ang*-1.0;
}

- (void) straight
{
    self.angle = 0;
    carSprite.rotation = 0;
}


@end
