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

#import "PrivateFoldersController.h"
#import "vBulletinStyleSheet.h"
#import "PullToRefreshView.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PrivateFoldersController

@synthesize webView    = _webView;
@synthesize scrollView = _scrollView;
@synthesize pull       = _pull;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Memory Management

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // title logo
        self.navigationItem.titleView = TTSTYLEVAR(titleImage);
        _pull = [[PullToRefreshView alloc] initWithScrollView:self.scrollView];

    }
    
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - View lifecycle

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];  
    self.webView.tag = 999;
    self.webView.delegate = self;
    
    for (UIView* subView in self.webView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *)subView;
            self.scrollView.delegate = (id) self;
        }
    }
    
    
    // Set up Pull to Refresh code
    [self.pull setDelegate:self];
    self.pull.tag = 998;
    [self.scrollView addSubview:self.pull];
        
    NSString *urlAddress = @"http://192.168.0.197/sencha/examples/";
//    NSString *urlAddress = @"http://jquerymobile.com/demos/1.0.1/";

    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];    
    [self.webView setDelegate:self];

    [self.view addSubview:self.webView];  
    

}



////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Private

- (void)goHome {
    // create a screenshot
    UIGraphicsBeginImageContext(self.view.layer.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * ss = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * ssImageView = [[UIImageView alloc] initWithImage:ss];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"comingHome"
                                                        object:ssImageView];
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view {
    [(UIWebView *)[self.view viewWithTag:999] reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [(PullToRefreshView *)[self.view viewWithTag:998] finishedLoading];
}

@end