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
#import "LauncherController.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// Three20's JSON Library
#import <extThree20JSON/extThree20JSON.h>

// Apple's Quartz Core
#import <QuartzCore/QuartzCore.h>

// Three20's Date Additions
#import <Three20Core/NSDateAdditions.h>

// Launchers Constants for Transitions
#define TIME_FOR_SHRINKING 0.31f // Has to be different from SPEED_OF_EXPANDING
#define TIME_FOR_EXPANDING 0.30f // Has to be different from SPEED_OF_SHRINKING
#define SCALED_DOWN_AMOUNT 0.01  // For example, 0.01 is one hundredth of the normal size

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation LauncherController

@synthesize userinfo            = _userinfo;

@synthesize navView             = _navView;
@synthesize profileButton       = _profileButton;
@synthesize searchButton        = _searchButton;
@synthesize optionsButton       = _optionsButton;
@synthesize logoutButton        = _logoutButton;

@synthesize welcomeView         = _welcomeView;
@synthesize avatarView          = _avatarView;
@synthesize avatarImageView     = _avatarImageView;
@synthesize avatarImageButton   = _avatarImageButton;
@synthesize avatarPicker        = _avatarPicker;
@synthesize avatarActivity      = _avatarActivity;
@synthesize usernameLabel       = _usernameLabel;
@synthesize lastVisitedLabel    = _lastVisitedLabel;

@synthesize launcherView        = _launcherView;
@synthesize forumsButton        = _forumsButton;
@synthesize messagesButton      = _messagesButton;
@synthesize notifyButton        = _notifyButton;
@synthesize currentButton       = _currentButton;
@synthesize subscriptionButton  = _subscriptionButton;

@synthesize transController     = _transController;
@synthesize transShadowView     = _transShadowView;
@synthesize transToUrlPath      = _transToUrlPath;

@synthesize forumHomeLauncher   = _forumHomeLauncher;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Memory Management

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // application's delegate
        appDelegate = (vBulletinAppDelegate *) [[UIApplication sharedApplication] delegate];

        // fetch the user's information
        self.userinfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"vBUser"];

        // title logo
        self.navigationItem.titleView = TTSTYLEVAR(titleImage);

        // hide the back button
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        // instantiate the launchers transition controller and view
        self.transController = [[UIViewController alloc] init];
        self.transShadowView = [[UIView alloc] init];

        // all controllers that the user can transision to
        self.forumHomeLauncher = [[ForumHomeController alloc] init];
        
        // notification to end the login animation
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(endLoginAnimation:)
                                                     name:@"endLoginAnimation"
                                                   object:nil ];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
	[self performSelector:@selector(animateTransition:) 
               withObject:[NSNumber numberWithFloat:TIME_FOR_SHRINKING]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {    
    [super viewDidLoad];
    
    // build the naviation bar
    [self buildNavigationBar];

    // build the welcome view
    [self buildWelcomeBox];
    
    // build the launcher view
    [self buildLauncherView];
    
    // set the default alpha to zero for the transition view
    [self.transShadowView setAlpha:0];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"endLoginAnimation"
                                                  object:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)endLoginAnimation:(id)sender {
    UIImageView * loginView = 
        [[UIImageView alloc] initWithImage:(UIImage *)[sender valueForKey:@"object"]];
    [self.view addSubview:loginView];
    
    [UIView animateWithDuration:1.3 animations:^{
        loginView.alpha = 0.0;
        loginView.frame = CGRectMake(-60, -60, 440, 600);
    }];    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildNavigationBar {
    self.navView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 28)];
    self.navView.backgroundColor = TTSTYLEVAR(launcherNavBackground);
    
    // default sizes for all navigation buttons
    CGFloat navButtonWth = 80;
    CGFloat NavButtonHht = 28;
    
    // profile button
    CGFloat proXAx = 0;
    CGFloat proYAx = 0;
    
    self.profileButton = 
    [[UIButton alloc] initWithFrame:CGRectMake(proXAx, proYAx, navButtonWth, NavButtonHht)];
    [self.profileButton setTag:0];
    [self.profileButton setTitle:@"PROFILE" forState:UIControlStateNormal];
    [self.profileButton.titleLabel setShadowOffset:CGSizeMake(-1.0, 1.0)];
    [self.profileButton.titleLabel setFont:TTSTYLEVAR(launcherNavFont)];
    [self.profileButton setTitleColor:TTSTYLEVAR(launcherNavNormalTextColor) 
                             forState:UIControlStateNormal];
    [self.profileButton setTitleColor:TTSTYLEVAR(launcherNavActiveTextColor) 
                             forState:UIControlStateHighlighted];
    [self.profileButton setTitleShadowColor:TTSTYLEVAR(launcherNavNormalTextShadowColor) 
                                   forState:UIControlStateNormal];
    [self.profileButton setTitleShadowColor:TTSTYLEVAR(launcherNavActiveTextShadowColor) 
                                   forState:UIControlStateHighlighted];
    [self.profileButton setBackgroundImage:TTSTYLEVAR(launcherNavNormalBgImage) 
                                  forState:UIControlStateNormal];
    [self.profileButton setBackgroundImage:TTSTYLEVAR(launcherNavActiveBgImage) 
                                  forState:UIControlStateHighlighted];
    [self.profileButton addTarget:self 
                           action:@selector(didSelectSubNavButton:) 
                 forControlEvents:UIControlEventTouchUpInside];
    
    // search button
    CGFloat srchXAx  = proXAx + navButtonWth;
    CGFloat srchYAx  = 0;
    
    self.searchButton = 
    [[UIButton alloc] initWithFrame:CGRectMake(srchXAx, srchYAx, navButtonWth, NavButtonHht)];
    [self.searchButton setTag:1];
    [self.searchButton setTitle:@"SEARCH" forState:UIControlStateNormal];
    [self.searchButton.titleLabel setShadowOffset:CGSizeMake(-1.0, 1.0)];
    [self.searchButton.titleLabel setFont:TTSTYLEVAR(launcherNavFont)];
    [self.searchButton setTitleColor:TTSTYLEVAR(launcherNavNormalTextColor) 
                            forState:UIControlStateNormal];
    [self.searchButton setTitleColor:TTSTYLEVAR(launcherNavActiveTextColor) 
                            forState:UIControlStateHighlighted];
    [self.searchButton setTitleShadowColor:TTSTYLEVAR(launcherNavNormalTextShadowColor) 
                                  forState:UIControlStateNormal];
    [self.searchButton setTitleShadowColor:TTSTYLEVAR(launcherNavActiveTextShadowColor) 
                                  forState:UIControlStateHighlighted];
    [self.searchButton setBackgroundImage:TTSTYLEVAR(launcherNavNormalBgImage) 
                                 forState:UIControlStateNormal];
    [self.searchButton setBackgroundImage:TTSTYLEVAR(launcherNavActiveBgImage) 
                                 forState:UIControlStateHighlighted];
    [self.searchButton addTarget:self 
                          action:@selector(didSelectSubNavButton:) 
                forControlEvents:UIControlEventTouchUpInside];
    
    // options button
    CGFloat optXAx  = srchXAx + navButtonWth;
    CGFloat optYAx  = 0;
    
    self.optionsButton = 
    [[UIButton alloc] initWithFrame:CGRectMake(optXAx, optYAx, navButtonWth, NavButtonHht)];
    [self.optionsButton setTag:2];
    [self.optionsButton setTitle:@"OPTIONS" forState:UIControlStateNormal];
    [self.optionsButton.titleLabel setShadowOffset:CGSizeMake(-1.0, 1.0)];
    [self.optionsButton.titleLabel setFont:TTSTYLEVAR(launcherNavFont)];
    [self.optionsButton setTitleColor:TTSTYLEVAR(launcherNavNormalTextColor) 
                             forState:UIControlStateNormal];
    [self.optionsButton setTitleColor:TTSTYLEVAR(launcherNavActiveTextColor) 
                             forState:UIControlStateHighlighted];
    [self.optionsButton setTitleShadowColor:TTSTYLEVAR(launcherNavNormalTextShadowColor) 
                                   forState:UIControlStateNormal];
    [self.optionsButton setTitleShadowColor:TTSTYLEVAR(launcherNavActiveTextShadowColor) 
                                   forState:UIControlStateHighlighted];
    [self.optionsButton setBackgroundImage:TTSTYLEVAR(launcherNavNormalBgImage) 
                                  forState:UIControlStateNormal];
    [self.optionsButton setBackgroundImage:TTSTYLEVAR(launcherNavActiveBgImage) 
                                  forState:UIControlStateHighlighted];
    [self.optionsButton addTarget:self 
                           action:@selector(didSelectSubNavButton:) 
                 forControlEvents:UIControlEventTouchUpInside];
    
    // logout button
    CGFloat outXAx  = optXAx + navButtonWth;
    CGFloat outYAx  = 0;
    
    self.logoutButton = 
    [[UIButton alloc] initWithFrame:CGRectMake(outXAx, outYAx, navButtonWth, NavButtonHht)];
    [self.logoutButton setTag:3];
    [self.logoutButton setTitle:@"LOGOUT" forState:UIControlStateNormal];
    [self.logoutButton.titleLabel setShadowOffset:CGSizeMake(-1.0, 1.0)];
    [self.logoutButton.titleLabel setFont:TTSTYLEVAR(launcherNavFont)];
    [self.logoutButton setTitleColor:TTSTYLEVAR(launcherNavNormalTextColor) 
                            forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:TTSTYLEVAR(launcherNavActiveTextColor) 
                            forState:UIControlStateHighlighted];
    [self.logoutButton setTitleShadowColor:TTSTYLEVAR(launcherNavNormalTextShadowColor) 
                                  forState:UIControlStateNormal];
    [self.logoutButton setTitleShadowColor:TTSTYLEVAR(launcherNavActiveTextShadowColor) 
                                  forState:UIControlStateHighlighted];
    [self.logoutButton setBackgroundImage:TTSTYLEVAR(launcherNavNormalBgImage) 
                                 forState:UIControlStateNormal];
    [self.logoutButton setBackgroundImage:TTSTYLEVAR(launcherNavActiveBgImage) 
                                 forState:UIControlStateHighlighted];
    [self.logoutButton addTarget:self 
                          action:@selector(didSelectSubNavButton:) 
                forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.navView addSubview:self.profileButton];
    [self.navView addSubview:self.searchButton];
    [self.navView addSubview:self.optionsButton];
    [self.navView addSubview:self.logoutButton];
    
    [self.view addSubview:self.navView];  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectSubNavButton:(id)sender {
    
    if ([[sender valueForKey:@"tag"] intValue] == 0) {
        [[TTNavigator navigator] openURLAction:
         [[TTURLAction actionWithURLPath:@"vb://profile/1"] applyAnimated:YES]];
    }
    
    if ([[sender valueForKey:@"tag"] intValue] == 1) {
        // search
    }
    
    if ([[sender valueForKey:@"tag"] intValue] == 2) {
        [[TTNavigator navigator] openURLAction:
         [[TTURLAction actionWithURLPath:@"vb://settings"] applyAnimated:YES]];
    }
    
    if ([[sender valueForKey:@"tag"] intValue] == 3) {
        UIActionSheet * sheet = [[UIActionSheet alloc] init];
        [sheet setTag:0];
        [sheet setTitle:@"Are you sure?"];
        [sheet addButtonWithTitle:@"Logout"];
        [sheet addButtonWithTitle:@"Cancel"];
        [sheet setDestructiveButtonIndex:0];    
        [sheet setCancelButtonIndex:1];    
        [sheet setDelegate:self];
        [sheet showInView:self.view];
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildWelcomeBox {
    // build welcome frame
    CGFloat welYAx = self.navView.frame.size.height;
    CGFloat welWth = self.view.bounds.size.width;
    CGRect  welFrm = CGRectMake(0, welYAx, welWth, 65);
    
    self.welcomeView                 = [[UIView alloc] initWithFrame:welFrm];
    self.welcomeView.backgroundColor = TTSTYLEVAR(launcherWelcomeBackground);

    // begin building the user's avatar
    NSString * avatarUrl = 
        [NSString stringWithFormat:kAvatarFetchUrl, [self.userinfo valueForKey:@"userid"]];
    // delete old avatar cache (old bug, might not need this anymore)
    [[TTURLCache sharedCache] removeURL:avatarUrl fromDisk:YES];
    
    // avatar view
    self.avatarView = [[UIView alloc] initWithFrame:CGRectMake(13, 5, 54, 54)];
    self.avatarView.backgroundColor   = [UIColor whiteColor];
    self.avatarView.layer.borderColor = RGBCOLOR(201, 205, 209).CGColor;
    self.avatarView.layer.borderWidth = 1.0;

    // avatar image view
    CGRect avatarImgFrame = CGRectMake(2, 2, 50, 50);
    
    self.avatarImageView          = [[TTImageView alloc] initWithFrame:avatarImgFrame];
    self.avatarImageView.delegate = self;
    [self.avatarImageView setUrlPath:avatarUrl];    
    
    self.avatarImageButton = [[UIButton alloc] initWithFrame:avatarImgFrame];
    [self.avatarImageButton setImage:self.avatarImageView.image
                            forState:UIControlStateNormal];
    [self.avatarImageButton addTarget:self 
                               action:@selector(didSelectAvatarImage) 
                     forControlEvents:UIControlEventTouchUpInside];
    
    // initiate the image picker for uploading new avatars
    self.avatarPicker = [[UIImagePickerController alloc] init];
    self.avatarPicker.delegate = self;

    // avatar activty label
    self.avatarActivity       = [[UIActivityIndicatorView alloc] 
                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.avatarActivity.frame = CGRectMake(16, 16, 20, 20);    


    // username & last active labels
    NSString * userName = 
        [NSString stringWithFormat:@"Welcome, %@!", [self.userinfo valueForKey:@"username"]];

    NSDate * lastVisitStamp = 
        [NSDate dateWithTimeIntervalSince1970:[[self.userinfo valueForKey:@"lastvisit"] intValue]];

    NSString * lastVisitString = 
        [NSString stringWithFormat:@"You last visited %@.", lastVisitStamp];

    // username label
    CGFloat userXAx = self.avatarView.frame.origin.x + self.avatarView.frame.size.width +10;
    
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userXAx, 17, 200, 15)];
    [self.usernameLabel setText:userName];
    [self.usernameLabel setFont:TTSTYLEVAR(launcherUsernameFont)];
    [self.usernameLabel setBackgroundColor:TTSTYLEVAR(launcherUsernameBgColor)];
    [self.usernameLabel setTextColor:TTSTYLEVAR(launcherUsernameTextColor)];
    [self.usernameLabel setShadowColor:TTSTYLEVAR(launcherUsernameShadowColor)];
    [self.usernameLabel setShadowOffset:TTSTYLEVAR(launcherUsernameShadowOffset)];

    // last visit label
    CGFloat vistXAx  = self.usernameLabel.frame.origin.x;
    CGFloat vistYAx  = self.usernameLabel.frame.origin.y + 15;

    self.lastVisitedLabel = [[UILabel alloc] initWithFrame:CGRectMake(vistXAx, vistYAx, 200, 15)];
    [self.lastVisitedLabel setText:lastVisitString];
    [self.lastVisitedLabel setFont:TTSTYLEVAR(launcherActivityFont)];
    [self.lastVisitedLabel setBackgroundColor:TTSTYLEVAR(launcherActivityBgColor)];
    [self.lastVisitedLabel setTextColor:TTSTYLEVAR(launcherActivityTextColor)];
    [self.lastVisitedLabel setShadowColor:TTSTYLEVAR(launcherActivityShadowColor)];
    [self.lastVisitedLabel setShadowOffset:TTSTYLEVAR(launcherActivityShadowOffset)];

    // add the sub-views
    [self.avatarView addSubview:self.avatarActivity];
    [self.avatarView addSubview:self.avatarImageButton];
    [self.welcomeView addSubview:self.avatarView];

    [self.welcomeView addSubview:self.usernameLabel];
    [self.welcomeView addSubview:self.lastVisitedLabel];

    [self.view addSubview:self.welcomeView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectAvatarImage {
    UIActionSheet * sheet = [[UIActionSheet alloc] init];
    [sheet setTag:1];
    [sheet addButtonWithTitle:@"Take Photo"];
    [sheet addButtonWithTitle:@"Choose From Library"];
    [sheet addButtonWithTitle:@"Delete Current Avatar"];
    [sheet addButtonWithTitle:@"Cancel"];
    [sheet setDestructiveButtonIndex:2];    
    [sheet setCancelButtonIndex:3];    
    [sheet setDelegate:self];
    [sheet showInView:self.view];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)uploadAvatar:(UIImage *)image {
    
    NSString          * url       = [NSString stringWithString:kAvatarUrl];
    TTURLRequest      * request   = [TTURLRequest requestWithURL:url delegate:self];
    TTURLJSONResponse * response  = [[TTURLJSONResponse alloc] init];
    //    NSData            * imageData = UIImagePNGRepresentation(image); 
    NSData            * imageData = UIImageJPEGRepresentation(image, 90);
    
    request.response  = response;
    request.cacheExpirationAge = 1;
    
    [request.parameters setValue:[self.userinfo valueForKey:@"userid"] forKey:@"userid"];
    [request.parameters setValue:@"0" forKey:@"avatarid"];
    [request.parameters setValue:@"http://www." forKey:@"avatarurl"];    
    [request.parameters setValue:imageData forKey:@"upload"];
    [request.parameters setValue:@"updateavatar" forKey:@"do"];
    
    [request setHttpMethod:@"POST"];
    [request send];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildLauncherView {
    
    // the main launcher view
    self.launcherView = [[UIView alloc] initWithFrame:CGRectMake(10, 103, 300, 300)];
    self.launcherView.backgroundColor   = [UIColor whiteColor];
    self.launcherView.layer.borderColor = RGBCOLOR(206, 210, 215).CGColor;
    self.launcherView.layer.borderWidth = 1.0f;

    // the forums launcher button
    self.forumsButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 24, 54, 75)];
    [self.forumsButton setTag:1];   
    [self.forumsButton setTitle:@"Forums" forState:UIControlStateNormal];
    [self.forumsButton.titleLabel setFont:TTSTYLEVAR(launcherButtonFont)];
    [self.forumsButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                            forState:UIControlStateNormal];
    [self.forumsButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                            forState:UIControlStateHighlighted];
    [self.forumsButton.titleLabel setShadowOffset:TTSTYLEVAR(launcherButtonTitleShadowOffset)];
    [self.forumsButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                  forState:UIControlStateNormal];
    [self.forumsButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                  forState:UIControlStateNormal];
    [self.forumsButton setBackgroundImage:TTSTYLEVAR(launcherButtonForumsImage) 
                                 forState:UIControlStateNormal];
    [self.forumsButton setTitleEdgeInsets:UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0)];
    [self.forumsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.forumsButton setBackgroundColor:[UIColor clearColor]];
    [self.forumsButton addTarget:self action:@selector(launcherButtonSelected:) 
                forControlEvents:UIControlStateHighlighted];
    
    // the private messages button
    self.messagesButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 83, 67)];
    [self.messagesButton setTag:2];
    [self.messagesButton setTitle:@"Messages" forState:UIControlStateNormal];
    [self.messagesButton.titleLabel setFont:TTSTYLEVAR(launcherButtonFont)];
    [self.messagesButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                              forState:UIControlStateNormal];
    [self.messagesButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                              forState:UIControlStateHighlighted];
    [self.messagesButton.titleLabel setShadowOffset:TTSTYLEVAR(launcherButtonTitleShadowOffset)];
    [self.messagesButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                    forState:UIControlStateNormal];
    [self.messagesButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                    forState:UIControlStateNormal];
    [self.messagesButton setBackgroundImage:TTSTYLEVAR(launcherButtonMessagesImage) 
                                   forState:UIControlStateNormal];
    [self.messagesButton setTitleEdgeInsets:UIEdgeInsetsMake(58.0, 0.0, 0.0, 0.0)];
    [self.messagesButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.messagesButton setBackgroundColor:[UIColor clearColor]];
    [self.messagesButton addTarget:self action:@selector(launcherButtonSelected:) 
                  forControlEvents:UIControlStateHighlighted];
    [self.launcherView addSubview:self.forumsButton];

    // the notifications buttons
    self.notifyButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 89, 75)];
    [self.notifyButton setTag:3];
    [self.notifyButton setTitle:@"Notifications" forState:UIControlStateNormal];
    [self.notifyButton.titleLabel setFont:TTSTYLEVAR(launcherButtonFont)];
    [self.notifyButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                            forState:UIControlStateNormal];
    [self.notifyButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                            forState:UIControlStateHighlighted];
    [self.notifyButton.titleLabel setShadowOffset:TTSTYLEVAR(launcherButtonTitleShadowOffset)];
    [self.notifyButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                  forState:UIControlStateNormal];
    [self.notifyButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                  forState:UIControlStateNormal];
    [self.notifyButton setBackgroundImage:TTSTYLEVAR(launcherButtonNotificationImage) 
                                 forState:UIControlStateNormal];
    [self.notifyButton setTitleEdgeInsets:UIEdgeInsetsMake(50.0, 0.0, 0.0, 0.0)];
    [self.notifyButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.notifyButton setBackgroundColor:[UIColor clearColor]];
    [self.notifyButton addTarget:self action:@selector(launcherButtonSelected:) 
                forControlEvents:UIControlStateHighlighted];

    // the current button
    self.currentButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 110, 54, 75)];
    [self.currentButton setTag:4];
    [self.currentButton setTitle:@"Current" forState:UIControlStateNormal];
    [self.currentButton.titleLabel setFont:TTSTYLEVAR(launcherButtonFont)];
    [self.currentButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                             forState:UIControlStateNormal];
    
    [self.currentButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                             forState:UIControlStateHighlighted];
    [self.currentButton.titleLabel setShadowOffset:TTSTYLEVAR(launcherButtonTitleShadowOffset)];
    [self.currentButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                   forState:UIControlStateNormal];
    [self.currentButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                   forState:UIControlStateNormal];
    [self.currentButton setBackgroundImage:TTSTYLEVAR(launcherButtonCurrentImage) 
                                  forState:UIControlStateNormal];
    [self.currentButton setTitleEdgeInsets:UIEdgeInsetsMake(80.0, 0.0, 0.0, 0.0)];
    [self.currentButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.currentButton setBackgroundColor:[UIColor clearColor]];
    [self.currentButton addTarget:self action:@selector(launcherButtonSelected:) 
                 forControlEvents:UIControlStateHighlighted];

    // the subscriptions button
    self.subscriptionButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 110, 85, 75)];
    [self.subscriptionButton setTag:5];
    [self.subscriptionButton setTitle:@"Subscriptions" forState:UIControlStateNormal];
    [self.subscriptionButton.titleLabel setFont:TTSTYLEVAR(launcherButtonFont)];
    [self.subscriptionButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                                  forState:UIControlStateNormal];
    [self.subscriptionButton setTitleColor:TTSTYLEVAR(launcherButtonTitleColor) 
                                  forState:UIControlStateHighlighted];
    [self.subscriptionButton.titleLabel 
     setShadowOffset:TTSTYLEVAR(launcherButtonTitleShadowOffset)];
    [self.subscriptionButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                        forState:UIControlStateNormal];
    [self.subscriptionButton setTitleShadowColor:TTSTYLEVAR(launcherButtonTitleShadowColor) 
                                        forState:UIControlStateNormal];
    [self.subscriptionButton setBackgroundImage:TTSTYLEVAR(launcherButtonSubscriptionImage) 
                                       forState:UIControlStateNormal];
    [self.subscriptionButton setTitleEdgeInsets:UIEdgeInsetsMake(80.0, 0.0, 0.0, 0.0)];
    [self.subscriptionButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.subscriptionButton setBackgroundColor:[UIColor clearColor]];
    [self.subscriptionButton addTarget:self action:@selector(launcherButtonSelected:) 
                      forControlEvents:UIControlStateHighlighted];
    
    // add icons to launcher view
    [self.launcherView addSubview:self.forumsButton];
    [self.launcherView addSubview:self.messagesButton];
    [self.launcherView addSubview:self.notifyButton];
    [self.launcherView addSubview:self.currentButton];
    [self.launcherView addSubview:self.subscriptionButton];
    
    [self.view addSubview:self.launcherView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherButtonSelected:(id)sender {
    UIButton * button = sender;
    
    if (button.tag == 1) {
        self.transToUrlPath  = [NSMutableString stringWithString:@"vb://forums"];;
        self.transController = self.forumHomeLauncher;
    }
        
    [self performSelector:@selector(animateTransition:) 
               withObject:[NSNumber numberWithFloat:TIME_FOR_EXPANDING]];

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)animationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
    
    self.view.userInteractionEnabled = YES;
    
	if ([animationID isEqualToString:@"animationExpand"]) {
        [[TTNavigator navigator] openURLAction:
         [[TTURLAction actionWithURLPath:self.transToUrlPath] applyAnimated:NO]];
	}
	else {
		self.transController.view.hidden=true;
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)animateTransition:(NSNumber *)duration {
    
    self.view.userInteractionEnabled=NO;    
    
    self.transShadowView.backgroundColor = [UIColor blackColor];
    self.transShadowView.frame = [[UIScreen mainScreen] bounds];
    
    [self.view addSubview:self.transShadowView];
    [self.view addSubview:self.transController.view];
    
    if ((self.transController.view.hidden == false) && 
        ([duration floatValue] == TIME_FOR_EXPANDING)) {
		self.transController.view.frame     = [[UIScreen mainScreen] bounds];
		self.transController.view.transform = 
        CGAffineTransformMakeScale(SCALED_DOWN_AMOUNT, SCALED_DOWN_AMOUNT);
	}
	
    self.transController.view.hidden=false;
    
	if ([duration floatValue] == TIME_FOR_SHRINKING) {
		[UIView beginAnimations:@"animationShrink" context:NULL];
		[UIView setAnimationDuration:[duration floatValue]];
        [self.transShadowView setAlpha:0];
		self.transController.view.transform = 
        CGAffineTransformMakeScale(SCALED_DOWN_AMOUNT, SCALED_DOWN_AMOUNT);
	}
    
	else {
		[UIView beginAnimations:@"animationExpand" context:NULL];
		[UIView setAnimationDuration:[duration floatValue]];
        [self.transShadowView setAlpha:1];
		self.transController.view.transform=CGAffineTransformMakeScale(1, 1);
	}
    
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView commitAnimations];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIImagePickerControllerDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self uploadAvatar:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
	[self dismissModalViewControllerAnimated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TTImageViewDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imageViewDidStartLoad:(TTImageView*)imageView {
    [self.avatarActivity startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imageView:(TTImageView*)imageView didLoadImage:(UIImage*)image {
    [self.avatarImageButton setImage:image forState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imageView:(TTImageView*)imageView didFailLoadWithError:(NSError*)error {
    [self.avatarActivity stopAnimating];
    [self.avatarImageButton setImage:TTSTYLEVAR(noAvatarImage) 
                            forState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - UIActionSheetDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // logout request
    if (actionSheet.tag == 0 && buttonIndex == 0) {
        TTURLRequest * request = [TTURLRequest requestWithURL:kAccountLoginUrl delegate:self];
        [request.parameters setValue:[self.userinfo valueForKey:@"logouthash"] 
                              forKey:@"logouthash"];
        [request setHttpMethod:@"GET"];
        [request send];
    }

    // request came from the avatar action sheet
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0 || buttonIndex == 1) {
            // add a new avatar using the camera
            if (buttonIndex == 0) {
                self.avatarPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }   
            // add a new avatar using an existing photo
            if (buttonIndex == 1) {
                self.avatarPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }   
            
            [self presentModalViewController:self.avatarPicker animated:YES];
        }
        
        // send request to delete the user's avatar
        if (buttonIndex == 2) {
            NSString          * url       = [NSString stringWithString:kAvatarUrl];
            TTURLRequest      * request   = [TTURLRequest requestWithURL:url delegate:self];
            TTURLJSONResponse * response  = [[TTURLJSONResponse alloc] init];
            
            request.response  = response;
            request.cacheExpirationAge = 1;
            
            [request.parameters setValue:[self.userinfo valueForKey:@"userid"] forKey:@"userid"];
            [request.parameters setValue:@"-1" forKey:@"avatarid"];
            [request.parameters setValue:@"updateavatar" forKey:@"do"];
            
            [request setHttpMethod:@"POST"];
            [request send];
        }
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TTURLRequestDelagate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse * response = request.response;
    NSDictionary      * results  = response.rootObject;    
    
    // check for remote errors
    if ([[results valueForKey:@"hasErrors"] intValue] == 1) {
        [appDelegate showAlertWithMessage:[results valueForKey:@"errorMsg"] andTitle:@""]; return;
    }
    
    // update avatar request
    if ([[request.parameters valueForKey:@"do"] isEqualToString:@"updateavatar"]) {
        NSString * avatarUrl = 
            [NSString stringWithFormat:kAvatarFetchUrl, [self.userinfo valueForKey:@"userid"]];
        [[TTURLCache sharedCache] removeURL:avatarUrl fromDisk:YES];
        [self.avatarImageView setUrlPath:avatarUrl];    
        [self.avatarImageView reload];
    }
    
    // logout request
    if ([request.parameters valueForKey:@"logouthash"]) {
        [appDelegate logUserOut];
        [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:@"vb://account/login"]];    
    }
}

@end

