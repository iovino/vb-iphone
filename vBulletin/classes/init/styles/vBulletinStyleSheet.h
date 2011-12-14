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

// Three20's Framework
#import <Three20/Three20.h>

// Application Settings
#import "vBulletinConstants.h"

/**
 * @class       vBulletinStyleSheet
 * @abstract    A CSS-like stylesheet for the application.
 * 
 * @discussion
 * This class houses ALL style settings for the entire application. All font settings, background 
 * colors, ect. can be found here.
 */
@interface vBulletinStyleSheet : TTDefaultStyleSheet {}

//
// Common Style Overides
//

/**
 * The default font that all non-styled text should be.
 * 
 * @return UIFont
 */
- (UIFont*)font;

/**
 * The default color that all non-styled text should be.
 * 
 * @return UIColor
 */
- (UIColor*)textColor;

/**
 * The default text color that all non-styled text should be when
 * the user has highlighted something.
 * 
 * @return UIColor
 */
- (UIColor*)highlightedTextColor;

/**
 * The background color that the applications should default to.
 * 
 * @return UIColor
 */
- (UIColor*)backgroundColor;

@end

























