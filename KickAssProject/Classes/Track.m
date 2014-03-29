//
//  Track.m
//  KickAssProject
//
//  Created by Gannon lawlor on 2014-03-24.
//  Copyright (c) 2014 Comp4768. All rights reserved.
//

#import "Track.h"

@implementation Track

-(id)initTrack:(NSString *) filename
{
    self = [super init];
    
    if (self) {
        [self setFilename:filename];
    }
    
    return self;
}


@end
