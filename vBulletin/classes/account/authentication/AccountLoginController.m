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

// Header File
#import "AccountLoginController.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// Three20 Additions
#import "Three20/Three20+Additions.h"

// Three20's JSON Library
#import <extThree20JSON/extThree20JSON.h>


#define kVerticalSpacing 20.0
#define kCellHeight 44.5

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MIN_SCROLL_FRAC = 0.1;
static const CGFloat MAX_SCROLL_FRAC = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AccountLoginController

@synthesize logoView = _logoView;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark - Memory Managment

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark - NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        appDelegate = (vBulletinAppDelegate *) [[UIApplication sharedApplication] delegate];
        
        self.view.backgroundColor = TTSTYLEVAR(backgroundColor);
        
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - View lifecycle

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGRect  appFrame     = [UIScreen mainScreen].applicationFrame;
    CGFloat appFrameHalf = appFrame.size.width / 2;
    
    // logo
    self.logoView = [[UIImageView alloc] initWithImage:vBStyleImage(@"/misc/login_logo.png")];
    self.logoView.frame = CGRectMake(42, 20, 237, 83);
    
    [self.view addSubview:self.logoView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

