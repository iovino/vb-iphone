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
@class ForumHomeDataModel;

/**
 * @class       ForumHomeDataSource
 * @abstract    This class is responsible for setting up and displaying the forumhome interface.
 */
@interface ForumHomeDataSource : TTSectionedDataSource {
    /**
     * The classes data model which contains all the information fetched from the remote server.
     */
    ForumHomeDataModel * _dataModel;
}

/**
 * The class initializer
 * 
 * @return id
 */
- (id)init;

@end
