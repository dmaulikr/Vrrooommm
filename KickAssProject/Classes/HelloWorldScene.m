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
    Car *blueCar;
    BOOL isAcclBeingTouched;
    BOOL isBrakeBeingTouched;
    BOOL isRightSideBeingTouched;
    float touch_y_Pos;
    
    BOOL isLeftSideBeingTouched;
    float touch_x_Pos;
    BOOL isTurningLeft;
    BOOL isTurningRight;
    UIImage *bimage;
    CGPoint *location;
    
    float diff_from_touch_pos_accl;
    float diff_x_pos;
    
    float scale_x;
    float scale_y;
    float angle;
    float accl_x;
    float accl_y;
    NSArray *trackDirections;
    CGSize winSize;
    int index;
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
    [self setUserInteractionEnabled:YES];
    [self setMultipleTouchEnabled:YES];
    
    NSLog(@"Is being enabled: %i ",[self isMultipleTouchEnabled]);
    
    
    accl_x = 15;
    accl_y = 15;
    
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    //bimage = [[UIImage alloc] initWithContentsOfFile:@"track1.png"];
    
    // Create a colored background
    CCSprite *background = [CCSprite spriteWithImageNamed:@"track2.png"];
    background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    
    //Track directions
    //"Right", "LeftTurn", "Up", "LeftTurn", "Left", "LeftTurn", "Down", "LeftTurn"};
    //trackDirections = @[@"Right", @"LeftTurn", @"Up", @"LeftTurn", @"Left", @"LeftTurn", @"Down", @"LeftTurn"];
    //index = 0;
    
    //scale fo the ipod screen
    winSize = [[CCDirector sharedDirector] viewSizeInPixels];
    scale_x = self.contentSize.width/1024;
    scale_y = self.contentSize.height/768;
    
    background.scaleX = scale_x;
    background.scaleY = scale_y;
    
    [self addChild:background];
    
    //GameKit Network
    mPicker = [[GKPeerPickerController alloc] init];
	mPicker.delegate = self;
	mPeers = [[NSMutableArray alloc] init];
    networkButton = [CCButton buttonWithTitle:@"Waiting for connection..." fontName:@"Verdana-Bold" fontSize:18.0f];
    networkButton.positionType = CCPositionTypeNormalized;
    networkButton.position = ccp(0.35f, 0.95f); // Top Right of screen
    CCColor*black = [CCColor colorWithRed:0 green:0 blue:0];
    networkButton.color = black;
    [self addChild:networkButton];
    
    //Create a line (Eventually a track)
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.color = black;
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    backButton.exclusiveTouch = NO;
    
    
    blueCar = [[Car alloc] initCarWithMass:50 withXPos:250*scale_x withYPos:38*scale_y withScaleX:scale_x withScaleY:scale_y file:@"blueCar.png"];

    redCar = [[Car alloc] initCarWithMass:50 withXPos:300*scale_x withYPos:38*scale_y withScaleX:scale_x withScaleY:scale_y file:@"car.png"];
    
    [self addChild:redCar];
    [self addChild:blueCar];
    
    // done
	return self;
}

// -----------------------------------------------------------------------

- (void) update:(CCTime)delta
{
    
    ccColor4B* centerBuffer = malloc(sizeof(ccColor4B));
    
    int dpi = winSize.width == 2048 ? 2 : 1; // Is Retina?
    float x = redCar.x_Pos / scale_x * dpi;
    float y = winSize.height - redCar.y_Pos / scale_y * dpi;
    
    //NSLog(@"OUTSIDE: Velocity (%f , %f) and Direction: %@" , [redCar x_Vel], [redCar y_Vel], [redCar direction]);
    //NSLog(@"Positon of the Car (%f , %f) ", [redCar x_Pos] , [redCar y_Pos]);
    //NSLog(@"Angle: %f", [redCar angle]);
    
    
    glReadPixels(x, y , 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, centerBuffer);
    
    //ccColor4B centerColour = centerBuffer[0];
    
    if (isAcclBeingTouched) {
        //NSLog(@"Speeding up");
        [redCar setX_Vel:[redCar x_Vel] + delta*diff_from_touch_pos_accl];
        [redCar setY_Vel:[redCar y_Vel] + delta*diff_from_touch_pos_accl];
    }
    
    if (isBrakeBeingTouched) {
        //NSLog(@"slowing down");
        [redCar setX_Vel:[redCar x_Vel] + delta*diff_from_touch_pos_accl];
        [redCar setY_Vel:[redCar y_Vel] + delta*diff_from_touch_pos_accl];
    }
    
    if ( isTurningRight){
        [redCar turnRight];
    }
    
    else if (isTurningLeft) {
        [redCar turnLeft];
    }
    
    [redCar checkCol:self.contentSize.width andHeight:self.contentSize.height];
    [redCar update:delta];
    [blueCar checkCol:self.contentSize.width andHeight:self.contentSize.height];
    [blueCar update:delta];
    
    NSMutableData* message = [NSMutableData alloc];
    float msg_X_Pos = [redCar x_Pos];
    float msg_Y_Pos = [redCar y_Pos];
    float msg_Angle = [redCar angle];
    float msg_X_Vel = [redCar x_Vel];
    float msg_Y_Vel = [redCar y_Vel];
    [message appendBytes:&msg_X_Pos length:sizeof(msg_X_Pos)];
    [message appendBytes:&msg_Y_Pos length:sizeof(msg_Y_Pos)];
    [message appendBytes:&msg_Angle length:sizeof(msg_Angle)];
    [message appendBytes:&msg_X_Vel length:sizeof(msg_X_Vel)];
    [message appendBytes:&msg_Y_Vel length:sizeof(msg_Y_Vel)];
    
    [mSession sendData:message toPeers:mPeers withDataMode:GKSendDataUnreliable error:nil];
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
    
    NSSet *allTouches = [event allTouches];
    
    for (UITouch *touch in allTouches) {
        
        CGPoint touchLoc = [touch locationInNode:self];
        
        if (touchLoc.x > self.contentSize.width/2) {
            isRightSideBeingTouched = YES;
            touch_y_Pos = touchLoc.y;
        }
        
        if (touchLoc.x < self.contentSize.width/2) {
            isLeftSideBeingTouched = YES;
            touch_x_Pos = touchLoc.x;
        }
        
        /*
        if (touchLoc.x > self.contentSize.width/2 && touchLoc.y < self.contentSize.height/2) {
            isAcclBeingTouched = YES;
        }
        
        if (touchLoc.x > self.contentSize.width/2 && touchLoc.y > self.contentSize.height/2) {
            isBrakeBeingTouched = YES;
        }*/
        
        
        //Left Side of screen
        /*
        if (touchLoc.x < self.contentSize.width/2) {
            if (touchLoc.x < self.contentSize.width/4) {
                isTurningLeft = YES;
            }
            else {
                isTurningRight = YES;
            }
            
        }*/
        //NSLog(@"RedCar Position (%f , %f) Velocity X: %f , Y: %f ", [redCar x_Pos], [redCar y_Pos], [redCar x_Vel], [redCar y_Vel]);
    }
    
    
    // Log touch location
    //CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
}

- (void) touchEnded:(UITouch *) touch withEvent:(UIEvent *)event{
    
    //NSSet *allTouches = [event allTouches];
   
    CGPoint touchLoc = [touch locationInNode:self];
        
    //right Side of screen
    if (touchLoc.x > self.contentSize.width/2) {
        isBrakeBeingTouched = NO;
        isAcclBeingTouched = NO;
        isRightSideBeingTouched = NO;
    }
    
    else {
        isTurningLeft = NO;
        isTurningRight = NO;
        isLeftSideBeingTouched = NO;
    }

    //NSLog(@"RedCar Position (%f , %f) Velocity X: %f , Y: %f ", [redCar x_Pos], [redCar y_Pos], [redCar x_Vel], [redCar y_Vel]);
    
}

- (void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    
    //NSLog(@"Initail Y touch: %f and touch Pos y: %f " , touch_y_Pos, touchLoc.y);
    
    NSSet *allTouches = [event allTouches];
    
    for (UITouch *touch in allTouches) {
        
        CGPoint touchLoc = [touch locationInNode:self];
    
    if (touchLoc.x > self.contentSize.width/2) {
        if (touchLoc.y > touch_y_Pos) {
            diff_from_touch_pos_accl = (touchLoc.y - touch_y_Pos)/5;
            //NSLog(@"SLide up");
            isBrakeBeingTouched = NO;
            isAcclBeingTouched = YES;
        }
        else
        {
            //NSLog(@"Slide Down");
            diff_from_touch_pos_accl = (touchLoc.y - touch_y_Pos)/5;
            isAcclBeingTouched = NO;
            isBrakeBeingTouched = YES;
        }
    }
    
    else if (touchLoc.x < self.contentSize.width/2) {
        if (touchLoc.x > touch_x_Pos) {
            //NSLog(@"Slide Right");
            isTurningRight = YES;
            isTurningLeft = NO;
        }
        else
        {
            //NSLog(@"Slide Left");
            isTurningRight = NO;
            isTurningLeft = YES;
        }
    }
        
    }
    
    //NSLog(@"RedCar Position (%f , %f) Velocity X: %f , Y: %f ", [redCar x_Pos], [redCar y_Pos], [redCar x_Vel], [redCar y_Vel]);
    
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

/* Notifies delegate that the user cancelled the picker. */
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
}

/*
    Notifies delegate that the connection type is requesting a GKSession object.
    You should return a valid GKSession object for use by the picker.
    If this method is not implemented or returns 'nil',
    a default GKSession is created on the delegate's behalf.
*/
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
	NSString *str = [[UIDevice currentDevice] name];
	NSLog(@"Preparing session for user %@", str);
	GKSession *session = [[GKSession alloc] initWithSessionID:@"GameKitTest session" displayName:str sessionMode:GKSessionModePeer];
	return session;
}

/* Notifies delegate that local app was connected to a remote peer, initiated either side. */
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
	NSLog(@"Connected from %@", peerID);
	
	mSession = session;
	session.delegate = self;
	[session setDataReceiveHandler:self withContext:nil];
	[picker dismiss];
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    float msg_X_Pos, msg_Y_Pos, msg_Angle, msg_X_Vel, msg_Y_Vel;
    unsigned int offset = 0;
    
    [data getBytes:&msg_X_Pos length:sizeof(float)];
    offset += sizeof(float);
    [data getBytes:&msg_Y_Pos range:NSMakeRange(offset, sizeof(float))];
    offset += sizeof(float);
    [data getBytes:&msg_Angle range:NSMakeRange(offset, sizeof(float))];
    offset += sizeof(float);
    [data getBytes:&msg_X_Vel range:NSMakeRange(offset, sizeof(float))];
    offset += sizeof(float);
    [data getBytes:&msg_Y_Vel range:NSMakeRange(offset, sizeof(float))];
    
    
	NSLog(@"Received data: X:%f Y:%f Angle:%f", msg_X_Pos, msg_Y_Pos, msg_Angle);
    NSString *str = [NSString stringWithFormat:@"Received data: X:%f Y:%f Angle:%f", msg_X_Pos, msg_Y_Pos, msg_Angle];
    [networkButton setTitle:str];
    [blueCar updateWithXPos:msg_X_Pos andYPos:msg_Y_Pos andXVel:msg_X_Vel andYVel:msg_Y_Vel andAngle:msg_Angle];
}

/* Indicates a state change for the given peer. */
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
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
