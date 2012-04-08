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

/**
 * @class       ForumDisplayDataModel
 * @abstract    This class is responsible for fetching the forum & thread data from the server.
 */
@interface ForumDisplayDataModel : TTURLRequestModel {
    /**
     * The current forum id the user is in.
     */
    NSString * _forumid;

    /**
     * A dictionary array of the current forum's information (title, description, etc.)
     */
    NSDictionary * _foruminfo;

    /**
     * A mutable array of all avaliable sub-forums.
     */
    NSMutableArray * _subforums;

    /**
     * A mutable array of all avaliable threads.
     */
    NSMutableArray * _threads;

    /**
     * A mutable array of all avaliable announcements.
     */
    NSMutableArray * _announcements;
    
    /**
     * The current page we're on.
     */
    NSUInteger _page;

    /**
     * The number of results to fetch per page.
     */
    NSUInteger _resultsPerPage;
    
    /**
     * Used to indicate if the data is finished being fetched from the remote sever.
     */
    BOOL _finished;
}

@property (nonatomic, copy)     NSString       * forumid;
@property (nonatomic, retain)   NSDictionary   * foruminfo;
@property (nonatomic, readonly) NSMutableArray * subforums;
@property (nonatomic, readonly) NSMutableArray * threads;
@property (nonatomic, readonly) NSMutableArray * announcements;
@property (nonatomic, assign)   NSUInteger       resultsPerPage;
@property (nonatomic, readonly) BOOL             finished;

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
