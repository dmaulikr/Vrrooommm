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

- (void) update:(CCTime) delta
{
    
    self.radian = self.angle*(M_PI/180);
    
    self.x_Pos = self.x_Pos + self.x_Vel*delta;
    self.y_Pos = self.y_Pos + self.y_Vel*delta;
    
    carSprite.position = ccp(self.x_Pos, self.y_Pos);
}

- (void) turnRight
{
    self.angle += 10;
    carSprite.rotation -= 10;
}

- (void) turnLeft
{
    self.angle += 5*(self.x_Vel*self.y_Vel)/1000;
    carSprite.rotation -= 5*(self.x_Vel*self.y_Vel)/1000;
}

- (void) straight
{
    self.angle = 0;
    carSprite.rotation = 0;
}


@end
