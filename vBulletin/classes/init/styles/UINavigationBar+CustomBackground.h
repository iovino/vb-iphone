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

// Apple's Foundation
#import <Foundation/Foundation.h>

/**
 * @interface   UINavigationBar (CustomBackground)
 * @abstract    Used to overide default navigation bar.
 * 
 * @discussion
 * We use this to override the default navigation bar and draw our own.
 */
@interface UINavigationBar (CustomBackground)

/**
 * Draws our custom naviagtion background
 *
 * @param CGRect
 *  The rect dimensions that we want to override
 *
 * @return void
 */
- (void)drawRectCustomBackground:(CGRect)rect;

@end
