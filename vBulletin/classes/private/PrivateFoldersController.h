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
#import "PullToRefreshView.h"

@interface PrivateFoldersController : TTViewController <UIWebViewDelegate, PullToRefreshViewDelegate> {
    UIWebView         * _webView;
    UIScrollView      * _scrollView;
    PullToRefreshView * _pull;
}

@property (nonatomic, retain) UIWebView         * webView;
@property (nonatomic, retain) UIScrollView      * scrollView;
@property (nonatomic, retain) PullToRefreshView * pull;

/**
 * This method is used to take you back to the launcher screen. It takes a screenshot of the current
 * view and shrinks it until you're back on the launcger view.
 *
 * @return void
 */
- (void)goHome;

@end
