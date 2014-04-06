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
#import "LeaderboardScene.h"

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
    CCSprite *background = [CCSprite spriteWithImageNamed:@"menu.png"];
    background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    background.scaleX = self.contentSize.width / 1024;
    background.scaleY = self.contentSize.height / 768;
    [self addChild:background];
    
    // Helloworld scene button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"MultiPlayer" fontName:@"Chalkduster" fontSize:36.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.21f);
    [helloWorldButton setTarget:self selector:@selector(onMultiPlayerClicked:)];
    [self addChild:helloWorldButton];
    
    //SinglePlayer Scene Button
    CCButton *singlePlayerButton = [CCButton buttonWithTitle:@"SinglePlayer" fontName:@"Chalkduster" fontSize:36.0f];
    singlePlayerButton.positionType = CCPositionTypeNormalized;
    singlePlayerButton.position = ccp(0.5f, 0.13);
    [singlePlayerButton setTarget:self selector:@selector(onSinglePlayerClicked:)];
    [self addChild:singlePlayerButton];
    
    //LeaderBoard Scene Button
    CCButton *leaderBoardButton = [CCButton buttonWithTitle:@"LeaderBoard" fontName:@"Chalkduster" fontSize:36.0f];
    leaderBoardButton.positionType = CCPositionTypeNormalized;
    leaderBoardButton.position = ccp(0.5f, 0.05);
    [leaderBoardButton setTarget:self selector:@selector(onLeaderboardClicked:)];
    [self addChild:leaderBoardButton];


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

- (void)onLeaderboardClicked:(id)sender
{
    LeaderboardScene *scene = [[LeaderboardScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:scene
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:1.0f]];
    //[scene setMultiPlayer:YES ];
}


// -----------------------------------------------------------------------
@end
