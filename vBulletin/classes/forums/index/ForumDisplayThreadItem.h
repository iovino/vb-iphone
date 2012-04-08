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
#import "vBulletinTableSubtitleItem.h"

/**
 * @class       ForumDisplayThreadItem
 * @abstract    
 */
@interface ForumDisplayThreadItem : vBulletinTableSubtitleItem {
    /**
     * The number of views the thread has.
     */
    NSString * _views;

    /**
     * The number of replies the thread has.
     */
    NSString * _repies;

    /**
     * Whether or not the thread has been selected
     */
    NSString * _selected;
}

@property (nonatomic, copy) NSString * views;
@property (nonatomic, copy) NSString * replies;
@property (nonatomic, copy) NSString * selected;

/**
 * Return a cell object with a title, author, views, replies, icon and a url when touched. Used for
 * threads in the forum display controller.
 *
 * @param NSString
 *  The title of the thread.
 *
 * @param NSString
 *  The thread starters username
 *
 * @param NSString
 *  The number of views the thread has
 *
 * @param NSString
 *  The number of replies the thread has
 *
 * @param UIImage
 *  The icon image that appears to the left of the title that should be displayed.
 *
 * @param NSString
 *  The url the user should be taken to when the table is touched.
 *
 * @return id
 *  The table object.
 */
+ (id)itemWithTitle:(NSString*)title
             author:(NSString*)author
              views:(NSString*)views 
            replies:(NSString*)replies 
               icon:(UIImage*)icon
                url:(NSString*)url;

@end
