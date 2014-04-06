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
#import "LeaderboardScene.h"

// -----------------------------------------------------------------------
#pragma mark - LeaderboardScene
// -----------------------------------------------------------------------

@implementation LeaderboardScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (LeaderboardScene *)scene
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
    CCSprite *background = [CCSprite spriteWithImageNamed:@"leaderboards.png"];
    background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    background.scaleX = self.contentSize.width / 1024;
    background.scaleY = self.contentSize.height / 768;
    [self addChild:background];
    
    //Back Button
    CCButton *backButton = [CCButton buttonWithTitle:@"Back to Menu" fontName:@"Chalkduster" fontSize:36.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.5f, 0.06);
    [backButton setTarget:self selector:@selector(onBackButtonClicked:)];
    [self addChild:backButton];
    
    CCColor*white = [CCColor colorWithRed:1 green:1 blue:1];
    
    CCLabelTTF *score1Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"5. Player Name - Time: 0.00"] fontName:@"Verdana-Bold" fontSize:30.0f];
    score1Label.positionType = CCPositionTypeNormalized;
    score1Label.position = ccp(0.5f, 0.35f);
    score1Label.color = white;
    [self addChild:score1Label];
    
    CCLabelTTF *score2Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"4. Player Name - Time: 0.00"] fontName:@"Verdana-Bold" fontSize:30.0f];
    score2Label.positionType = CCPositionTypeNormalized;
    score2Label.position = ccp(0.5f, 0.44f);
    score2Label.color = white;
    [self addChild:score2Label];
    
    CCLabelTTF *score3Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"3. Player Name - Time: 0.00"] fontName:@"Verdana-Bold" fontSize:30.0f];
    score3Label.positionType = CCPositionTypeNormalized;
    score3Label.position = ccp(0.5f, 0.53f);
    score3Label.color = white;
    [self addChild:score3Label];
    
    CCLabelTTF *score4Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"2. Player Name - Time: 0.00"] fontName:@"Verdana-Bold" fontSize:30.0f];
    score4Label.positionType = CCPositionTypeNormalized;
    score4Label.position = ccp(0.5f, 0.62f);
    score4Label.color = white;
    [self addChild:score4Label];
    
    CCLabelTTF *score5Label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"1. Player Name - Time: 0.00"] fontName:@"Verdana-Bold" fontSize:30.0f];
    score5Label.positionType = CCPositionTypeNormalized;
    score5Label.position = ccp(0.5f, 0.71f);
    score5Label.color = white;
    [self addChild:score5Label];
    
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackButtonClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
