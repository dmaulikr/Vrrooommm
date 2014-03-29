//
//  HelloWorldScene.m
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-24.
//  Copyright Comp4768 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *_sprite;
    Car *redCar;
    BOOL isMoving;
    Track *track;
    UIImage *bimage;
    CGPoint *location;
    float scale_x;
    float scale_y;
    float accl;
    CGSize winSize;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    
    self = [super init];
    if (!self) return(nil);
    
    accl = 0.1;
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    bimage = [[UIImage alloc] initWithContentsOfFile:@"track1.png"];
    
    // Create a colored background
    CCSprite *background = [CCSprite spriteWithImageNamed:@"track1.png"];
    background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    
    //scale fo the ipod screen
    winSize = [[CCDirector sharedDirector] viewSizeInPixels];
    scale_x = self.contentSize.width/1024;
    scale_y = self.contentSize.height/768;
    
    background.scaleX = scale_x;
    background.scaleY = scale_y;
    
    [self addChild:background];
    
    //Create a line (Eventually a track)
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    CCColor*black = [CCColor colorWithRed:0 green:0 blue:0];
    backButton.color = black;
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

    redCar = [[Car alloc] initCarWithMass:50 withXPos:300*scale_x withYPos:25*scale_y withScaleX:scale_x withScaleY:scale_y file:@"car.png"];
    
    [self addChild:redCar];
    
    // done
	return self;
}

// -----------------------------------------------------------------------

- (void) update:(CCTime)delta
{
    ccColor4B *buffer = malloc(sizeof(ccColor4B));
    if(winSize.width == 2048){
        glReadPixels(redCar.x_Pos/scale_x*2, winSize.height - redCar.y_Pos/scale_y*2, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    } else {
        glReadPixels(redCar.x_Pos/scale_x, winSize.height - redCar.y_Pos/scale_y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    }
    
    ccColor4B color = buffer[0];
    NSLog(@"Color at (%f, %f) with height %f unscaled (%f, %f) is R: %i , G: %i, B: %i", redCar.x_Pos, redCar.y_Pos, self.contentSize.height, redCar.x_Pos/scale_x, redCar.y_Pos/scale_y, color.r, color.g, color.b);
    
    
    if (isMoving) {
        [redCar setX_Vel:[redCar x_Vel]-accl];
        [redCar update];
    }
    
    /*
    else if (color.g > 0) {
        [redCar setY_Vel:[redCar y_Vel]-accl];
        [redCar setX_Vel:0];
    }
    */
    else
    {
        if ([redCar x_Vel] < 0) {
            //NSLog(@"Slowing Down");
            [redCar setX_Vel:[redCar x_Vel]+accl];
            [redCar update];
        }
    }
}

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    isMoving = YES;
    CGPoint touchLoc = [touch locationInNode:self];
    //NSLog(@"RedCar Position (%f , %f) Velocity X: %f , Y: %f ", [redCar x_Pos], [redCar y_Pos], [redCar x_Vel], [redCar y_Vel]);
    // Log touch location
    //CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    [_sprite runAction:actionMove];
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    isMoving = NO;
}


// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
