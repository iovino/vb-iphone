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

// Apple's UIKit
#import <UIKit/UIKit.h>

// Three20 Core Library
#import <Three20/Three20.h>

// Application Constants
#import "vBulletinConstants.h"

@interface vBulletinAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * Logs the user into the application
 *
 * This method saves important userinfo data that the application
 * will use later. The data is stored using NSUserDefaults.
 * 
 * @param NSDictionary
 *  An NSDictionary array of the user's information. The following is
 *  expected to be present in the dictionary: The userid, username, email, 
 *  securitytoken, securitytoken_raw, logouthash, lastvisit, pmunread, 
 *  usergroupid, and the ipaddress.
 *
 * @return BOOL
 *  True if user is logged in, false if not.
 */  
- (void)logUserIn:(NSDictionary *)info;

/**
 * Logs the user out of the application
 *
 * This method deletes all the NSUserDefaults records and
 * cookies for the logged in user.
 *
 * @return void
 */  
- (void)logUserOut;

/**
 * Checks if the current user is logged in or not.
 *
 * This method checks the NSUserDefaults to see if we have a
 * userid stored there or not.
 *
 * @return BOOL
 *  True if user is logged in, false if not.
 */  
- (BOOL)isUserLoggedIn;

/**
 * Returns the first integer from a string.
 *
 * This is useful for when you need to quickly grab an integer from a string, say
 * a thread ID or user ID from a URL.
 *
 * @param string
 *  The string that contains an integer you need.
 *     
 * @return NSString
 *  The integer in string format.
 */  
- (NSString *)returnFirstIntFromString:(NSString *)string;

/**
 * Convenience method for displaying quick alert messages.
 *
 * This method is bad practice and will be deprecated soon, 
 * try not to use.
 *
 * @param NSString
 *  The message you want to display to the user.
 *
 * @param NSString
 *  The title that should be used for the UIAlert box. (optional)
 *     
 * @return void
 */  
- (void)showAlertWithMessage:(NSString *)message andTitle:(NSString *)title;

@end
