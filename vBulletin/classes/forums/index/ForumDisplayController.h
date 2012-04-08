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

// Forum Display's Data Source
#import "ForumDisplayDataSource.h"

/**
 * @class       ForumDisplayController
 * @abstract    The main class that renders a list of threads in a giving forum.
 */
@interface ForumDisplayController : TTTableViewController <UIActionSheetDelegate> {
    /**
     * The applications delegate.
     */
    vBulletinAppDelegate * appDelegate;    

    /**
     * The forums data source
     */
    ForumDisplayDataSource * _dataSource2;

    /**
     * The current forum id
     */
    NSString * _forumid;
}

@property (nonatomic, copy)   NSString               * forumid;
@property (nonatomic, retain) ForumDisplayDataSource * dataSource2;

/**
 * The action sheet that is used to show you any avaliable options.
 * 
 * @return void
 */
- (void)actionSheet;

@end
