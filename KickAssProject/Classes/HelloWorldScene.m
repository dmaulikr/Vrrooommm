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
    CCButton* networkButton;
    Car *redCar;
    BOOL isMoving;
    float accl;
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
    
    //[CCLabelTTF create("Hello World", "Helvetica", 12,CCSizeMake(245, 32), kCCTextAlignmentCenter)];
    
    accl = 0.1;
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    //GameKit Network
    mPicker = [[GKPeerPickerController alloc] init];
	mPicker.delegate = self;
	mPeers = [[NSMutableArray alloc] init];
    networkButton = [CCButton buttonWithTitle:@"Waiting for connection..." fontName:@"Verdana-Bold" fontSize:18.0f];
    networkButton.positionType = CCPositionTypeNormalized;
    networkButton.position = ccp(0.35f, 0.95f); // Top Right of screen
    [self addChild:networkButton];
    
    //Create a line (Eventually a track)
    CCDrawNode* node = [[CCDrawNode alloc] init];
    CCColor* red = [CCColor colorWithRed:0 green:0 blue:1];
    [node drawSegmentFrom:ccp(100, 200) to:ccp(900, 200) radius:5 color: red];
    [self addChild:node];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    //Create a Car
    /*_sprite = [CCSprite spriteWithImageNamed:@"redCar.png"];
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
     */
    
    redCar = [[Car alloc] initCarWithMass:50 withXPos:100 withYPos:200 file:@"redCar.png"];
    [redCar setDirection:@"Right"];
    [self addChild:redCar];

    //Track *track = [[Track alloc] initTrack:@"track2.png"];
    //[track getTracks];
    
    // done
	return self;
}

// -----------------------------------------------------------------------

- (void) update:(CCTime)delta
{
    if (isMoving) {
        //accelerate the car
        [self moveCarOnLine];
        //[redCar setX_Vel:[redCar x_Vel]-accl];
        //[redCar update];
    }
    else
    {
        if ([redCar x_Vel] < 0) {
            //NSLog(@"Slowing Down");
            [redCar setX_Vel:[redCar x_Vel]+accl];
            [redCar update];
        }
    }
    NSString *positionData = [NSString stringWithFormat:@"Position (%f, %f)", [redCar x_Pos], [redCar y_Pos]];
	[mSession sendData:[positionData dataUsingEncoding:NSASCIIStringEncoding]
			   toPeers:mPeers
		  withDataMode:GKSendDataReliable error:nil];
}

- (void) moveCarOnLine
{
    NSLog(@"Position (%f, %f) Width: %f Height: %f", [redCar x_Pos], [redCar y_Pos], self.contentSize.width, self.contentSize.height);
    
    if ([[redCar direction]  isEqual: @"Left"]) {
        [redCar setX_Vel:[redCar x_Vel]+accl];
        [redCar update];
    }
    if ([[redCar direction]  isEqual: @"Right"]) {
        [redCar setX_Vel:[redCar x_Vel]-accl];
        [redCar update];
    }
}

- (void) draw
{
    
    //[redCar draw];
    //NSLog(@"In Draw");
    //ccDrawLine( ccp(200, 200), ccp(300, 300) );
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
    
    [mPicker show];
    
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

/* Notifies delegate that the user cancelled the picker.
 */
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
}

/* Notifies delegate that the connection type is requesting a GKSession object.
 You should return a valid GKSession object for use by the picker.
 If this method is not implemented or returns 'nil',
 a default GKSession is created on the delegate's behalf.
 */
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker
		   sessionForConnectionType:(GKPeerPickerConnectionType)type
{
	NSString *str = [[UIDevice currentDevice] name];
	NSLog(@"Preparing session for user %@", str);
	GKSession *session = [[GKSession alloc] initWithSessionID:@"GameKitTest session"
                                                  displayName:str
                                                  sessionMode:GKSessionModePeer];
	return session;
}

/* Notifies delegate that local app was connected to a remote peer, initiated either side.
 */
- (void)peerPickerController:(GKPeerPickerController *)picker
			  didConnectPeer:(NSString *)peerID
				   toSession:(GKSession *)session
{
	NSLog(@"Connected from %@", peerID);
	
	mSession = session;
	session.delegate = self;
	[session setDataReceiveHandler:self withContext:nil];
	[picker dismiss];
}

- (void)receiveData:(NSData *)data
		   fromPeer:(NSString *)peer
		  inSession:(GKSession *)session
			context:(void *)context
{
	NSString *str;
	str = [[NSString alloc] initWithData:data
								encoding:NSASCIIStringEncoding];
	NSLog(@"Received data: %@", str);
    [networkButton setTitle:str];
	if ([str hasPrefix:@"\x04\vstreamtype"])
		str = @"call established";
}

/* Indicates a state change for the given peer.
 */
- (void)session:(GKSession *)session
		   peer:(NSString *)peerID
 didChangeState:(GKPeerConnectionState)state
{
	switch (state) {
		case GKPeerStateConnected:
		{
            NSString *str = [NSString stringWithFormat:@"Connected from: \"%@\"",
							 [session displayNameForPeer:peerID]];
			[networkButton setTitle:str];
			NSLog(@"%@", str);

			[mPeers addObject:peerID];
			break;
		}
		case GKPeerStateDisconnected:
		{
			[mPeers removeObject:peerID];
			break;
		}
	}
}

// -----------------------------------------------------------------------
@end
