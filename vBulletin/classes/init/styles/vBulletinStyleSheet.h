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

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Common Styles

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

/**
 * The placeholder text for text fields.
 * 
 * @return UIColor
 */
- (UIColor*)fieldPlaceholderTextColor;

/**
 * The default image used when a user doesn't have an avatar.
 * 
 * @return UIImage
 */
- (UIImage *)noAvatarImage;

/**
 * This is the image that gets used in place of the title on all navigation bars.
 * 
 * @return UIImageView
 */
- (UIImageView *)titleImage;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Login / Signup Screen

/**
 * The logo of the application.
 * 
 * @return UIImage
 */
- (UIImage*)logoImage;

/**
 * The frame of the logo.
 * 
 * @return CGRect
 */
- (CGRect)logoFrame;

/**
 * The auto resizing mask when the device changes it's orientation.
 * 
 * @return UIViewAutoresizing
 */
- (UIViewAutoresizing)logoAutoMask;

/**
 * The vertical spacing used for login tables and buttons.
 * 
 * @return CGFloat
 */
- (CGFloat)loginVertSpacing;

#pragma mark -

/**
 * The frame of the login table
 * 
 * @return CGRect
 */
- (CGRect)loginTableFrame;

/**
 * The table style we should use.
 * 
 * @return CGRect
 */
- (UITableViewStyle)loginTableStyle;

/**
 * The background color of the login table.
 * 
 * @return CGRect
 */
- (UIColor *)loginTableBackgroundColor;

/**
 * Whether or not scrolling should be enabled for the login table.
 * 
 * @return CGRect
 */
- (BOOL)loginTableScrollEnabled;

/**
 * The separator color that separates the input fields.
 * 
 * @return CGRect
 */
- (UIColor*)loginTableSeparatorColor;

/**
 * The auto resizing mask for when the device changes it's orientation.
 * 
 * @return CGRect
 */
- (UIViewAutoresizing)loginTableAutoMask;

#pragma mark -

/**
 * The image used for the signup button.
 * 
 * @return UIImage
 */
- (UIImage*)signupButtonImage;

/**
 * The image used for the login button.
 * 
 * @return UIImage
 */
- (UIImage*)loginButtonImage;

#pragma mark -

/**
 * The font and sized used for text-based links on the login screen.
 * 
 * @return UIFont
 */
- (UIFont*)loginLinksFont;

/**
 * The color used for text-based links on the login screen.
 * 
 * @return UIColor
 */
- (UIColor*)loginLinksColor;

/**
 * The color used for text-based links on the login screen when touched.
 * 
 * @return UIColor
 */
- (UIColor*)loginLinksColorHighlighted;

/**
 * The shadow color used for text-based links on the login screen.
 * 
 * @return UIColor
 */
- (UIColor*)loginLinksColorShadow;

/**
 * The shadow color offset used for text-based links on the login screen.
 * 
 * @return CGSize
 */
- (CGSize)loginLinksShadowOffset;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark launcher Screen

/**
 * The background color or image used for the launcher's top navigation bar.
 * 
 * @return UIColor
 */
- (UIColor *)launcherNavBackground;

/**
 * The font used for all text in the launcher's top navigation bar.
 * 
 * @return UIFont
 */
- (UIFont *)launcherNavFont;

/**
 * The default text color that's used for all text in the launcher's top navigation bar.
 * 
 * @return UIColor
 */
- (UIColor *)launcherNavNormalTextColor;

/**
 * The highlighted text color used when a user touches any text links in the top navigation bar.
 * 
 * @return UIColor
 */
- (UIColor *)launcherNavActiveTextColor;

/**
 * The default shawdow color that's used for all text in the launcher's top navigation bar.
 * 
 * @return UIColor
 */
- (UIColor *)launcherNavNormalTextShadowColor;

/**
 * The highlighted shawdow color used when a user touches any text links in the top navigation bar.
 * 
 * @return UIColor
 */
- (UIColor *)launcherNavActiveTextShadowColor;

/**
 * The default background image for any text links in the top navigation bar. 
 * 
 * @return UIImage
 */
- (UIImage *)launcherNavNormalBgImage;

/**
 * The highlighted background image for any text links in the top navigation bar. 
 * 
 * @return UIImage
 */
- (UIImage *)launcherNavActiveBgImage;


#pragma mark -


/**
 * The background color or image used for the welcome panel.
 * 
 * @return UIColor
 */
- (UIColor *)launcherWelcomeBackground;

/**
 * The font used for the username in the welcome box.
 * 
 * @return UIFont
 */
- (UIFont *)launcherUsernameFont;

/**
 * The background color for the username label.
 * 
 * @return UIColor
 */
- (UIColor *)launcherUsernameBgColor;

/**
 * The text color for the username label.
 * 
 * @return UIColor
 */
- (UIColor *)launcherUsernameTextColor;

/**
 * The shadow color for the username label.
 * 
 * @return UIColor
 */
- (UIColor *)launcherUsernameShadowColor;

/**
 * The shadow offset for the username label.
 * 
 * @return CGSize
 */
- (CGSize)launcherUsernameShadowOffset;

/**
 * The font used for the activity in the welcome box.
 * 
 * @return UIFont
 */
- (UIFont *)launcherActivityFont;

/**
 * The background color for the activity label.
 * 
 * @return UIColor
 */
- (UIColor *)launcherActivityBgColor;

/**
 * The text color for the activity label.
 * 
 * @return UIColor
 */
- (UIColor *)launcherActivityTextColor;

/**
 * The shadow color for the activity label.
 * 
 * @return UIColor
 */
- (UIColor *)launcherActivityShadowColor;

/**
 * The shadow offset for the activity label.
 * 
 * @return CGSize
 */
- (CGSize)launcherActivityShadowOffset;

#pragma mark -

/**
 * The launcher buttons font.
 * 
 * @return CGSize
 */
- (UIFont *)launcherButtonFont;

/**
 * The launcher buttons text color.
 * 
 * @return CGSize
 */
- (UIColor *)launcherButtonTitleColor;

/**
 * The launcher buttons text color when touched.
 * 
 * @return CGSize
 */
- (UIColor *)launcherButtonTitleColorHighlighted;

/**
 * The launcher buttons shadow text color.
 * 
 * @return CGSize
 */
- (UIColor *)launcherButtonTitleShadowColor;

/**
 * The shadow offset for launcher butons.
 * 
 * @return CGSize
 */
- (CGSize)launcherButtonTitleShadowOffset;

/**
 * The forums launcher icon.
 * 
 * @return UIImage
 */
- (UIImage *)launcherButtonForumsImage;

/**
 * The private messages launcher icon.
 * 
 * @return UIImage
 */
- (UIImage *)launcherButtonMessagesImage;

/**
 * The notifications launcher icon.
 * 
 * @return UIImage
 */
- (UIImage *)launcherButtonNotificationImage;

/**
 * The current launcher icon.
 * 
 * @return UIImage
 */
- (UIImage *)launcherButtonCurrentImage;

/**
 * The subscriptions launcher icon.
 * 
 * @return UIImage
 */
- (UIImage *)launcherButtonSubscriptionImage;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Forum Table Cells

/**
 * The font and size of the table cells title.
 * 
 * @return UIFont
 */
- (UIFont *)forumTableCellTitleFont;

/**
 * The text color of the table cells title.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellTitleTextColor;

/**
 * The text color of the table cells title when selected.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellTitleTextColorSelected;

/**
 * The text color of the table cells shadow title.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellTitleShadowColor;

/**
 * The text color of the table cells shadow title when selected.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellTitleShadowColorSelected;

/**
 * The shadow offset of the table cells title text.
 * 
 * @return CGSize
 */
- (CGSize)forumTableCellTitleShadowOffset;

/**
 * The background color of the tables cells title text.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellTitleBackgroundColor;

/**
 * The font and size of the table cells description text.
 * 
 * @return UIFont
 */
- (UIFont *)forumTableCellDetailFont;

/**
 * The background color of the tables cells description text.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellDetailBackgroundColor;

/**
 * The text color of the table cells description text.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellDetailTextColor;

/**
 * The text color of the table cells description when selected.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellDetailTextColorSelected;

/**
 * The text color of the table cells shadow description.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellDetailShadowColor;

/**
 * The text color of the table cells shadow description when selected.
 * 
 * @return UIColor
 */
- (UIColor *)forumTableCellDetailShadowColorSelected;

/**
 * The shadow offset of the table cells description text.
 * 
 * @return CGSize
 */
- (CGSize)forumTableCellDetailShadowOffset;



- (NSInteger)forumTableGroupHeaderPadding;

- (NSInteger)forumTableHeaderPadding;

- (NSInteger)forumTableHeaderTextLineSpacing;

- (UIImage *)forumTableHeaderBackgroundImage;

- (UIColor*)forumTableHeaderBottomBorderColor;

- (UIColor*)forumTableHeaderTitleBackgroundColor;

- (UIColor*)forumTableHeaderTitleTextColor;

- (UIFont*)forumTableHeaderTitleFont;

- (NSInteger)forumTableHeaderTitleMaxLines;

- (UIColor*)forumTableHeaderDescBackgroundColor;

- (UIColor*)forumTableHeaderDescTextColor;

- (UIFont*)forumTableHeaderDescFont;

- (NSInteger)forumTableHeaderDescMaxLines;

#pragma mark Forum - Table Cell

- (UIImage *)forumTableCellBackground;

- (UIColor *)forumTableCellBackgroundSelected;

- (UIColor *)forumTableCellSeparatorColor;

- (NSInteger)forumTableCellPadding;

#pragma mark Forum - Table Cell - Icon

- (NSInteger)forumTableCellImageMargin;

- (NSInteger)forumTableCellImageWidth;

#pragma mark Forum - Table Cell - Views & Replies Icons

- (NSInteger)forumTableCellStatsSpacing;

- (CGSize)forumTableCellStatsImageSize;

- (UIImage *)forumTableCellStatsViewsImage;

- (UIImage *)forumTableCellStatsRepliesImage;

#pragma mark Forum - Table Cell - Announcement Cell

- (UIImage *)forumTableCellAnnounceBackground;

- (UIImage *)forumTableCellAnnounceBackgroundSelected;

- (UIColor *)forumTableCellAnnounceTextColor;

- (UIColor *)forumTableCellAnnounceTextShadowColor;

- (CGSize)forumTableCellAnnounceTextShadowOffset;

- (UIView *)forumTableCellAnnounceAccessoryView;

#pragma mark Forum - Table Cell - Misc

- (NSInteger)forumTableCellTextLineSpacing;

- (NSInteger)forumTableCellDefaultTextHeight;

- (NSString *)forumTableCellForumLightbulbPath;

- (NSString *)forumTableCellForumLightbulbPathActive;

- (NSString *)forumTableCellThreadStickyIconPath;

- (NSString *)forumTableCellThreadDotIconPath:(NSString *)statusicon;

@end









