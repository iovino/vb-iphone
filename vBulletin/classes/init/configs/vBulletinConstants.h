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

/**
 * Base URL
 *
 * Enter the base url of the server that HTTP request should be sent
 * to. Be sure to include a trailing slash.
 *
 * Example:
 * http://www.vbulletin.com/
 */
#define BASE_URL  @"http://192.168.0.196/iforums/"

/**
 * Forums URL
 *
 * Enter the url of the forum. No not include a trailing slash. If the 
 * forum url is the same as your base URL, you can use the BASE_URL 
 * constant in its place.
 *
 * Example:
 * http://www.vbulletin.com/forums
 */
#define FORUM_URL BASE_URL

/**
 * API Path
 *
 * Enter the path where the vBulletin IOS web script resides. It's 
 * doubtful that you'll need to change the default value of this.
 * 
 * Example:
 * http://www.vbulletin.com/forums/iphoneapp/request.php?file=
 */
#define API_URL FORUM_URL "vbiphoneweb/request.php?file="

/**
 * Style Bundle
 *
 * Enter the name of the style bundle that this application should
 * use.
 * 
 * Example:
 * vBulletin.bundle
 */
#define STYLE_BUNDLE @"vBulletin.bundle"

/**
 * Cache Lifetime
 *
 * Enter how long (in seconds) that the cache should live before 
 * it gets destroyed.
 * 
 * Examples:
 *  60*60*24    = 1 day
 *  60*60*24*7  = 1 week
 *  1.0 / 0.0   = inf
 */
#define DEFAULT_CACHE_EXPIRATION_AGE 1

/**
 * CMlog
 * 
 * Use this in place of NSLog to get more details about what and 
 * where it's logging.
 *
 * Credit: http://blog.coriolis.ch/2009/01/05/macros-for-xcode/
 */
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);

/**
 * MARK
 * 
 * Use this macro to  output the name of class and method it was 
 * called from. Useful to know if a method was called.
 *
 * Credit: http://blog.coriolis.ch/2009/01/05/macros-for-xcode/
 */
#define MARK CMLog(@"%s", __PRETTY_FUNCTION__);

/**
 * START_TIMER / END_TIMER
 * 
 * Useful when you need to time blocks or events for benchmarking.
 * purposes.
 *
 * Credit: http://blog.coriolis.ch/2009/01/05/macros-for-xcode/
 */
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);

/**
 * Application URL Contants
 * 
 * The following are the URL paths used for communicating with 
 * the remote server through out the application. Use pascal 
 * style constants if you're going to create more.
 */
#define kAccountLoginUrl         API_URL     "login"
#define kAccountLogoutUrl        API_URL     "logout"
#define kAccountSignupUrl        API_URL     "register"
#define kAccountSettingsUrl      API_URL     "settings&do=editoptions"
//
#define kAvatarUrl               API_URL     "avatar"
#define kAvatarFetchUrl          kAvatarUrl  "&do=fetchavatar&userid=%@"
//
#define kPrivateUrl              API_URL     "private"
#define kPrivateFolderListUrl    kPrivateUrl "&do=folders"
#define kPrivateUpdateFoldersUrl kPrivateUrl "&do=updatefolders"
#define kPrivateMessageListUrl   kPrivateUrl "&do=messagelist&perpage=%i&pagenumber=%i&folderid=%@"
#define kPrivateViewMessageUrl   kPrivateUrl "&do=showpm&pmid=%@"
//
#define kForumUrl                API_URL     "forums"
#define kForumHomeUrl            kForumUrl   "&do=index"
#define kForumDisplayUrl         kForumUrl   "&do=view&forumid=%@&page=%i"
//
#define kSubscriptionsUrl        API_URL     "subscription&do=viewsubscription"
//
#define kModeratorUrl            API_URL     "moderator"
//
#define kShowThreadUrl           API_URL         "threads"
#define kShowThreadIndex         kShowThreadUrl  "&do=view&threadid=%@"
//
#define kMiscUrl                 API_URL     "misc"
#define kWhoPostedUrl            kMiscUrl    "&do=whoposted&threadid=%@"
#define kNotificationsUrl        kMiscUrl    "&do=notifications"

/**
 * Used to fetch images located in the current style bundle.
 * 
 * @param NSString
 *  The path to the image file located in the images directory.
 *
 * @return NSString
 *  The full path to the image in the current style bundle.
 */
static UIImage * vBStyleImage(NSString * path) {
    NSString * fullPath = [NSString stringWithFormat:@"bundle://%@/images%@", STYLE_BUNDLE, path];
    return TTIMAGE(fullPath);
}

