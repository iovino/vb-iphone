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

// vBulletin Table Cell
#import "vBulletinTableSubtitleItemCell.h"

// The Forums Display Thread Item
#import "ForumDisplayThreadItem.h"

/**
 * @class       ForumDisplayThreadItemCell
 * @abstract    
 */
@interface ForumDisplayThreadItemCell : vBulletinTableSubtitleItemCell <UIActionSheetDelegate> {
    /**
     * The forums display thread item
     */
    ForumDisplayThreadItem * _threadItem;
    
    /**
     * The label for the number of views the thread has.
     */
    UILabel     * _viewsLabel;

    /**
     * The label for the number of replies the thread has.
     */
    UILabel     * _repliesLabel;

    /**
     * The icon that sits next to the views label.
     */
    UIImageView * _viewsIcon;

    /**
     * The icon that sits next to the replies label.
     */
    UIImageView * _repliesIcon;

    /**
     * The checkmark icon when a thread has been selected.
     */
    UIImageView * _checkMarkImage;

    /**
     * The main thread icon (used as a button to show additional options)
     */
    UIButton    * _iconButton;
    
    /**
     * Boolean value to tell if the thread is in edit mode or not
     */
    BOOL _inEditMode;

    /**
     * Boolean value to tell the thread has been selected or not.
     */
    BOOL _isCellSelected;

}

@property (nonatomic, retain) ForumDisplayThreadItem * threadItem;
@property (nonatomic, retain) UILabel     * viewsLabel;
@property (nonatomic, retain) UILabel     * repliesLabel;
@property (nonatomic, retain) UIImageView * viewsIcon;
@property (nonatomic, retain) UIImageView * repliesIcon;
@property (nonatomic, retain) UIImageView * checkMarkImage;
@property (nonatomic, retain) UIButton    * iconButton;
@property (nonatomic, readwrite) BOOL inEditMode;
@property (nonatomic, readwrite) BOOL isCellSelected;


/**
 * Shows an actionsheet of options when a thread icon is touched.
 *
 * @return void
 */
- (void)didSelectIcon;

/**
 * Return the int value (threadid, forumid, etc) from a vBulletin URL.
 *
 * @param NSString
 *  The url to inspect.
 *
 * @return NSString
 *  The id extracted from the url.
 */
- (NSString *)returnIntFromUrl:(NSString *)url;

    
@end
