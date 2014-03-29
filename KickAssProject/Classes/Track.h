//
//  Track.h
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-24.
//  Copyright (c) 2014 Comp4768. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property NSString* filename;


- (id) initTrack:(NSString *)filename;
- (void) getTracks;
- (UIColor *)colorAtPixel:(CGPoint)point;

@end
