//
//  IntroScene.m
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-24.
//  Copyright Comp4768 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Slot Car Racer" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Helloworld scene button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"MultiPlayer" fontName:@"Verdana-Bold" fontSize:18.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.35f);
    [helloWorldButton setTarget:self selector:@selector(onMultiPlayerClicked:)];
    [self addChild:helloWorldButton];
    
    //SinglePlayer Scene Button
    CCButton *singlePlayerButton = [CCButton buttonWithTitle:@"SinglePlayer" fontName:@"Verdana-Bold" fontSize:18.0f];
    singlePlayerButton.positionType = CCPositionTypeNormalized;
    singlePlayerButton.position = ccp(0.5f, 0.30);
    [singlePlayerButton setTarget:self selector:@selector(onSinglePlayerClicked:)];
    [self addChild:singlePlayerButton];

    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onMultiPlayerClicked:(id)sender
{
    HelloWorldScene *scene = [[HelloWorldScene alloc] initWith:YES];
    [[CCDirector sharedDirector] replaceScene:scene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
    //[scene setMultiPlayer:YES ];
}

- (void)onSinglePlayerClicked:(id)sender
{
    HelloWorldScene *scene = [[HelloWorldScene alloc] initWith:NO];
    [[CCDirector sharedDirector] replaceScene:scene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
    //[scene setMultiPlayer:NO];
}


// -----------------------------------------------------------------------
@end
