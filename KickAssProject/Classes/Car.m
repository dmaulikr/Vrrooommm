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
    
}

- (id) initCarWithMass:(float)mass withXPos:(float)x_Pos withYPos:(float)y_Pos file:(NSString *)filename
{
    self = [super init];
    
    if (self) {
        NSLog(@"I created a Car at (%f, %f)", self.x_Pos, self.y_Pos);
        //[self initWithImageNamed:@"redCar.png"];
        [self setX_Pos:x_Pos];
        [self setY_Pos:y_Pos];
        [self setMass:mass];
        [self setCar_Width:self.contentSize.width];
        [self setCar_Height:self.contentSize.height];
        //[self initWithImageNamed:filename];
        
    }
    return self;
}

- (void) update
{
    [self setX_Vel:[self x_Pos]-[self x_Vel]/5];
    [self setY_Vel:[self y_Pos]-[self y_Vel]/5];
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
