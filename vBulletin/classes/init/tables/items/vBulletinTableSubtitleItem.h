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
 * @class       vBulletinTableSubtitleItem
 * @abstract    This class is used throughout the application to setup basic table rows.
 * 
 * @discussion
 * This class should be used or expanded apon when you need to display table rows. It's used to
 * display tables rows for things like messages, threads and forums.
 */
@interface vBulletinTableSubtitleItem : TTTableSubtitleItem

/**
 * Returns an object with a title, icon and a url when touched.
 * 
 * @param NSString
 *  The title that should be shown.
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
               icon:(UIImage*)icon
                url:(NSString*)url;

/**
 * Returns an object with a title, subtitle, icon and a url when touched.
 * 
 * @param NSString
 *  The title that should be shown.
 *
 * @param NSString
 *  The sub-title that should be shown underneath the main title.
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
           subtitle:(NSString*)subtitle 
               icon:(UIImage*)icon
                url:(NSString*)url;

@end
