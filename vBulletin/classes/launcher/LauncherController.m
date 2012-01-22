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

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation LauncherController

@synthesize userinfo          = _userinfo;

@synthesize navView           = _navView;
@synthesize profileButton     = _profileButton;
@synthesize searchButton      = _searchButton;
@synthesize optionsButton     = _optionsButton;
@synthesize logoutButton      = _logoutButton;

@synthesize welcomeView       = _welcomeView;
@synthesize avatarView        = _avatarView;
@synthesize avatarImageView   = _avatarImageView;
@synthesize avatarImageButton = _avatarImageButton;
@synthesize avatarPicker      = _avatarPicker;
@synthesize avatarActivity    = _avatarActivity;

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
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {    
    [super viewDidLoad];
    
    // build the naviation bar
    [self buildNavigationBar];

    // build the welcome view
    [self buildWelcomeBox];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
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

    // add the sub-views
    [self.avatarView addSubview:self.avatarActivity];
    [self.avatarView addSubview:self.avatarImageButton];
    [self.welcomeView addSubview:self.avatarView];

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
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TTLauncherViewDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherButtonSelected:(id)sender {

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {

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

