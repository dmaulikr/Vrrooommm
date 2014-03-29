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
}

- (id) initCarWithMass:(float)mass withXPos:(float)x_Pos withYPos:(float)y_Pos withScaleX:(float)scalex withScaleY:(float)scaley file:(NSString *)filename
{
    self = [super init];
    
    if (self) {
        
        
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

- (void) update
{
    float radian;
    self.angle += 1.0;
    self.x_Pos = self.x_Pos + self.x_Vel + (float)cos(radian);
    self.y_Pos = self.y_Pos + self.y_Vel + (float)sin(radian);
    //[self setX_Pos:[self x_Pos]-[self x_Vel]];
    //[self setY_Pos:[self y_Pos]-[self y_Vel]];
    carSprite.position = ccp(self.x_Pos, self.y_Pos);
}

- (void) rotateCar
{
    //carSprite.rotation = -10;
}

- (void) draw
{
    CCDrawNode* node = [[CCDrawNode alloc] init];
    CGPoint vertices[] = { ccp([self x_Pos] + [self car_Width]/2, [self y_Pos] + [self car_Height]/2) ,
                           ccp([self x_Pos] + [self car_Width]/2, [self y_Pos] - [self car_Height]/2) ,
                           ccp([self x_Pos] - [self car_Width]/2, [self y_Pos] + [self car_Height]/2) ,
                           ccp([self x_Pos] - [self car_Width]/2, [self y_Pos] - [self car_Height]/2)};
    CCColor* red = [CCColor colorWithRed:1 green:0 blue:0];
    CCColor* white = [CCColor colorWithRed:1 green:1 blue:1];
    [node drawPolyWithVerts:vertices count:4 fillColor:red borderWidth:1 borderColor:white];

}




@end
