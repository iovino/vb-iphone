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

#import "vBulletinStyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation vBulletinStyleSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Common Styles

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIFont*)font {
    return [UIFont systemFontOfSize:14];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)textColor {
    return [UIColor blackColor];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)highlightedTextColor {
    return [UIColor whiteColor];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)backgroundColor {
    return [UIColor colorWithPatternImage:
            TTIMAGE(@"bundle://vBulletin.bundle/images/bgs/body.png")];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)fieldPlaceholderTextColor {
    return RGBCOLOR(206, 210, 215);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Login / Signup Screen

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)logoImage {
    return vBStyleImage(@"/misc/login_logo.png");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)logoFrame {
    return CGRectMake(42, 20, 237, 83);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewAutoresizing)logoAutoMask {
    return UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}

#pragma mark -

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)loginTableFrame {
    return CGRectMake(0, [self logoFrame].size.height + 20, 320, 110);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewStyle)loginTableStyle {
    return UITableViewStyleGrouped;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor *)loginTableBackgroundColor {
    return [UIColor redColor];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)loginTableScrollEnabled {
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)loginTableSeparatorColor {
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewAutoresizing)loginTableAutoMask {
    return UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}



@end