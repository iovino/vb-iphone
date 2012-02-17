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

// Header File
#import "vBulletinTableHeaderView.h"

// Application's Stylesheet
#import "vBulletinStyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation vBulletinTableHeaderView

@synthesize titleLabel       = _titleLabel;
@synthesize descpLabel       = _descpLabel;
@synthesize bottomBorder     = _bottomBorder;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString *)title description:(NSString *)description {
	self = [super init];
    if (self) {
        self.bottomBorder = [[UIView alloc] init];
        
        // we're using three20's TTStyledTextLabel so we can use the TTStyledText for html titles
        self.titleLabel = [[TTStyledTextLabel alloc] init];
        self.titleLabel.text           = [TTStyledText textFromXHTML:title lineBreaks:YES URLs:YES];
        self.titleLabel.backgroundColor= TTSTYLEVAR(forumTableHeaderTitleBackgroundColor);
        self.titleLabel.textColor      = TTSTYLEVAR(forumTableHeaderTitleTextColor);
        self.titleLabel.font           = TTSTYLEVAR(forumTableHeaderTitleFont);
        [self.titleLabel sizeToFit];
        
        self.descpLabel = [[UILabel alloc] init];
        self.descpLabel.text            = description;
        self.descpLabel.backgroundColor = TTSTYLEVAR(forumTableHeaderDescBackgroundColor);
        self.descpLabel.textColor       = TTSTYLEVAR(forumTableHeaderDescTextColor);
        self.descpLabel.font            = TTSTYLEVAR(forumTableHeaderDescFont);
        self.descpLabel.numberOfLines   = TTSTYLEVAR(forumTableHeaderDescMaxLines);

        [self addSubview:self.descpLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.bottomBorder];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    
    // get the label's width and max size
    CGFloat labelWidth   = self.frame.size.width - TTSTYLEVAR(forumTableHeaderPadding) * 2;
    CGSize  labelMaxSize = CGSizeMake(labelWidth, CGFLOAT_MAX);
    
    // figure out the current title and descriptions size based on the content, font and font size
    CGSize titleTextSize = [self.titleLabel.html sizeWithFont:self.titleLabel.font 
                                            constrainedToSize:labelMaxSize
                                                lineBreakMode:UILineBreakModeWordWrap]; 
    CGSize descTextSize = [self.descpLabel.text sizeWithFont:self.descpLabel.font 
                                           constrainedToSize:labelMaxSize
                                               lineBreakMode:UILineBreakModeWordWrap]; 
    // position the title and descriptions
    self.titleLabel.frame = 
        CGRectMake(TTSTYLEVAR(forumTableHeaderPadding), 
                   TTSTYLEVAR(forumTableHeaderPadding), 
                   labelWidth, titleTextSize.height);
    self.descpLabel.frame = 
        CGRectMake(TTSTYLEVAR(forumTableHeaderPadding), 
                   self.titleLabel.frame.origin.y + 
                   self.titleLabel.frame.size.height + TTSTYLEVAR(forumTableHeaderTextLineSpacing), 
                   labelWidth, descTextSize.height);
    
    // get the height of the header    
    NSInteger bgHeight = 
        self.titleLabel.frame.size.height + 
        self.descpLabel.frame.size.height + TTSTYLEVAR(forumTableHeaderPadding) * 2;

    // if there's a description present, add its height to the equation
    if (![self.descpLabel.text isEqualToString:@""]) {
        bgHeight = bgHeight + TTSTYLEVAR(forumTableHeaderTextLineSpacing);
    }
    
    // build the frame
    CGRect bgFrame = CGRectMake(0, 0, self.frame.size.width, bgHeight);
    
    // add the custom background image
    UIImageView  * bgView  = [[UIImageView alloc] initWithFrame:bgFrame];    
    UIImage      * bgImage = TTSTYLEVAR(forumTableHeaderBackgroundImage);

    // split the background image and make it stretchable
    bgImage = [bgImage stretchableImageWithLeftCapWidth:floorf(bgImage.size.width / 2) 
                                           topCapHeight:floorf(bgImage.size.height / 2)];    

    // add the background to the view and send it to the back
    [bgView setImage:bgImage];
    [bgView setAlpha:0.95];
    [self addSubview:bgView];
    [self sendSubviewToBack:bgView];
    
    // create a border for the bottom of the frame
    self.bottomBorder.frame = CGRectMake(0, bgFrame.size.height, self.frame.size.width, 1);
    self.bottomBorder.backgroundColor =  TTSTYLEVAR(forumTableHeaderBottomBorderColor);
}


@end
