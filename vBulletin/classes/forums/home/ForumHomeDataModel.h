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
 * @class       ForumHomeDataModel
 * @abstract    This class is responsible for fetching the forum data from the remote server.
 */
@interface ForumHomeDataModel : TTURLRequestModel {
    /**
     * A mutable array of all avaliable forums and their information.
     */
    NSMutableArray * _forums;

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

@property (nonatomic, readonly) NSMutableArray * forums;
@property (nonatomic, assign)   NSUInteger       resultsPerPage;
@property (nonatomic, readonly) BOOL             finished;

/**
 * The class initializer
 * 
 * @return id
 */
- (id)init;


@end
