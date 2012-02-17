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

// Application's Delegate
#import "vBulletinAppDelegate.h"

@interface vBulletinTableHeaderView : UIView {
    TTStyledTextLabel * _titleLabel;
    UILabel * _descpLabel;
    UIView  * _bottomBorder;
}

@property (nonatomic, retain) TTStyledTextLabel * titleLabel;
@property (nonatomic, retain) UILabel * descpLabel;
@property (nonatomic, retain) UIView  * bottomBorder;

- (id)initWithTitle:(NSString *)title description:(NSString *)description;

@end
