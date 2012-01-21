/**
 * @file
 *
 * vBulletin iOS
 * Copyright (c) 2011-2012 Ken Iovino. All Rights Reserved. 
 *
 * This application and it's source code is owned and operated by Ken Iovino. Use of this 
 * application and it's source code is strictly prohibited unless otherwise specified in a written 
 * agreement.
 *
 * This file may not be redistributed in whole or significant part.
 */

#import "UINavigationBar+CustomBackground.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UINavigationBar (CustomBackground)

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Public

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRectCustomBackground:(CGRect)rect {

    // If the style of the bar is the default style, apply our custom visuals
    if (self.barStyle == UIBarStyleDefault) {
        
        // Create the drawing context
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // Set the background color of the navbar
        [[UIColor blackColor] set];
        CGRect fillRect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
        CGContextFillRect(ctx, fillRect);
        
        // Create an instance of the image we want to draw
        UIImage * logo = [UIImage imageWithContentsOfFile:
                          [[NSBundle mainBundle] 
                           pathForResource:@"bundle://vBulletin.bundle/images/bgs/navbar.png" // this needs to be pulled from the stylesheet or config file somewhere
                                    ofType:@"png"]];
        
        // Get the absolute center points relative to the image and the screen
        NSNumber * centerX = [NSNumber numberWithFloat:(self.frame.size.width/2 - logo.size.width/2)];
        NSNumber * centerY = [NSNumber numberWithFloat:(self.frame.size.height/2 - logo.size.height/2)];
        
        // Draw the image
        [logo drawInRect:CGRectMake(centerX.floatValue, centerY.floatValue, logo.size.width, logo.size.height)];
        
        return;
    }
    
    [self drawRectCustomBackground:rect];
}

@end