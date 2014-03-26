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

- (void)getTracks
{
    UIImage *trackImage = [UIImage imageNamed:[self filename]];
    
    NSUInteger width = trackImage.size.width;
    NSUInteger height = trackImage.size.height;
    NSUInteger bytesPerPixel = 4; //Use PNG, other formats have more or less bytes per pixel
    NSUInteger bytesPerRow = width * bytesPerPixel;
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, trackImage.CGImage);
    
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    
    
    struct Color
    {
        UInt8 r;
        UInt8 g;
        UInt8 b;
    };
    
    for (size_t i = 0; i < CGBitmapContextGetWidth(bmContext); i++) {
        
        for (size_t j = 0; j < CGBitmapContextGetHeight(bmContext); j++) {
            
            int pixel = j * CGBitmapContextGetWidth(bmContext) + i;
            
            struct Color thisColor = {data[pixel + 1], data[pixel + 2], data[pixel + 3]};
            NSLog(@" X_Pos: %i , Y_Pos: %i, Red: %i , Green: %i , Blue: %i " , i, j, thisColor.r, thisColor.g, thisColor.b);
            
            //NSLog(@"color : %s " , thisColor);
        }
    }
    
    
}

@end
