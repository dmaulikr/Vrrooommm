//
//  HelloWorldScene.h
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-24.
//  Copyright Comp4768 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Car.h"
#import <GameKit/GameKit.h>

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface HelloWorldScene : CCScene <GKPeerPickerControllerDelegate, GKSessionDelegate> {
    GKPeerPickerController *mPicker;
    NSMutableArray *mPeers;
    GKSession *mSession;
    
}

@property BOOL multiPlayer;

// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene;
//- (id)init;

- (id)initWith:(BOOL)multiPlayer;


// -----------------------------------------------------------------------
@end