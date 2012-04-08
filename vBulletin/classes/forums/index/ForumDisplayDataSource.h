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

// The Data Model
@class ForumDisplayDataModel;

/**
 * @class       ForumDisplayDataSource
 * @abstract    This class is responsible for displaying the forums & threads interface.
 */
@interface ForumDisplayDataSource : TTSectionedDataSource {
    /**
     * The forumsdisplay's data model
     */
    ForumDisplayDataModel * _dataModel;
}

/**
 * The class initializer
 *
 * @param NSString
 *  The forum's id we're requesting
 *
 * @return void
 */
- (id)initWithForumId:(NSString *)forumId;

@end
