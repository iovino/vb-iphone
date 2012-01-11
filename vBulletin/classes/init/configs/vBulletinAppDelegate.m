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

// Application Delegate
#import "vBulletinAppDelegate.h"

// Application Style Settings
#import "vBulletinStyleSheet.h"

// Login Controller
#import "AccountLoginController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation vBulletinAppDelegate

@synthesize window = _window;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Main Application

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];

    // load default stylesheet
    [TTStyleSheet setGlobalStyleSheet:[[vBulletinStyleSheet alloc] init]]; 
    
    // setup navigation with persistence enabled
    TTNavigator * navigator         = [TTNavigator navigator];
    navigator.persistenceMode       = TTNavigatorPersistenceModeAll;
    navigator.window                = self.window;
    
    // customize the look of the UINavBar for iOS5 devices
    if ([[UINavigationBar class]respondsToSelector:@selector(appearance)]) {
        [[UINavigationBar appearance] setBackgroundImage:vBStyleImage(@"/bgs/navbar.png") 
                                           forBarMetrics:UIBarMetricsDefault];
    }
    
    // begin mapping objects to the navigator
    TTURLMap * map = navigator.URLMap;
    
    // open unknown URLs in the app's web browser
    [map from:@"*" toViewController:[TTWebController class]];
    
    //
    // begin url mapping
    //

    [map                from: @"vb://account/login"
       toModalViewController: [AccountLoginController class]
                    selector: nil ];

    //
    // end url mapping
    //

    // check if the user is logged in or not. If so, load the last screen
    // from their previous session. Otherwise, load the login screen.
    if ([self isUserLoggedIn]) {
        if (![navigator restoreViewControllers]) {
            [navigator openURLAction:[TTURLAction actionWithURLPath:@"vb://launcher"]];
        }        
    } 
    
    else {
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"vb://account/login"]];    
    }
    
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for 
     certain types of temporary interruptions (such as an incoming phone call or SMS message) or 
     when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame 
     rates. Games should use this method to pause the game.
     */
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store 
     enough application state information to restore your application to its current state in case 
     it is terminated later. If your application supports background execution, this method is 
     called instead of applicationWillTerminate: when the user quits.
     */
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo 
     many of the changes made on entering the background.
     */
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. 
     If the application was previously in the background, optionally refresh the user interface.
     */
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)logUserIn:(NSDictionary *)info {
    NSMutableDictionary * userinfo     = [[NSMutableDictionary alloc] init];
    NSUserDefaults      * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userinfo setValue:[info valueForKey:@"userid"] forKey:@"userid"];
    [userinfo setValue:[info valueForKey:@"username"] forKey:@"username"];
    [userinfo setValue:[info valueForKey:@"email"] forKey:@"email"];
    [userinfo setValue:[info valueForKey:@"securitytoken"] forKey:@"securitytoken"];
    [userinfo setValue:[info valueForKey:@"securitytoken_raw"] forKey:@"securitytoken_raw"];
    [userinfo setValue:[info valueForKey:@"logouthash"] forKey:@"logouthash"];
    [userinfo setValue:[info valueForKey:@"lastvisit"] forKey:@"lastvisit"];
    [userinfo setValue:[info valueForKey:@"pmunread"] forKey:@"pmunread"];
    [userinfo setValue:[info valueForKey:@"usergroupid"] forKey:@"usergroupid"];
    [userinfo setValue:[info valueForKey:@"ipaddress"] forKey:@"ipaddress"];
    
    [userDefaults setObject:userinfo forKey:@"vBUser"];
    [userDefaults synchronize];
    [[TTURLCache sharedCache] removeAll:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)logUserOut {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults setObject:nil forKey:@"vBUser"];
    
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
    
    [standardUserDefaults synchronize];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isUserLoggedIn {
    NSDictionary * userinfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"vBUser"];
    
    if ([[userinfo valueForKey:@"userid"] length] == 0) {
        return false;
    }
    
    if ([[userinfo valueForKey:@"usergroupid"] intValue] == 8) {
        [self logUserOut];
        [self showAlertWithMessage:@"You have been banned from the site." andTitle:@""];
        return false;
    }
    
    return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)returnFirstIntFromString:(NSString *)string {
    NSError *error = NULL;	
    NSRegularExpression *regex = 
    [NSRegularExpression regularExpressionWithPattern:@"[\\w]+(\\d+)" 
                                              options:NSRegularExpressionCaseInsensitive 
                                                error:&error];
    
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:string 
                                                         options:0 
                                                           range:NSMakeRange(0, [string length])];
    
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSString *substringForFirstMatch = [string substringWithRange:rangeOfFirstMatch];
        return [NSString stringWithFormat:@"%@", substringForFirstMatch];
    }
    
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showAlertWithMessage:(NSString *)message andTitle:(NSString *)title {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title 
                                                     message:message 
                                                    delegate:self 
                                           cancelButtonTitle:@"OK" 
                                           otherButtonTitles:nil ];
    [alert show];
}

@end
