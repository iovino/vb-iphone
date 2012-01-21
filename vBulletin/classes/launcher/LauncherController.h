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
 * @class       LauncherController
 * @abstract    The user's homepage after they've logged in or signed up.
 * 
 * @discussion
 * This is the users home screen once they've logged in or signed up. From here they can navigate 
 * to different parts of the application, e.g. the forums, private message, settings, etc. All main
 * parts of the site should be accessible from this screen.
 */
@interface LauncherController : TTViewController <
    TTLauncherViewDelegate, 
    TTImageViewDelegate, 
    UIActionSheetDelegate, 
    UIImagePickerControllerDelegate, 
    UINavigationControllerDelegate
> {
    /**
     * The applications delegate.
     */
    vBulletinAppDelegate * appDelegate;
    
    /**
     * The main view for the top navigation bar.
     */
    UIView * _navView;

    /**
     * The profile button used in the navigation bar.
     */
    UIButton * _profileButton;
    
    /**
     * The search button used in the navigation bar.
     */
    UIButton * _searchButton;

    /**
     * The options button used in the navigation bar.
     */
    UIButton * _optionsButton;

    /**
     * The logout button used in the navigation bar.
     */
    UIButton * _logoutButton;


}

@property (nonatomic, retain) UIView   * navView;
@property (nonatomic, retain) UIButton * profileButton;
@property (nonatomic, retain) UIButton * searchButton;
@property (nonatomic, retain) UIButton * optionsButton;
@property (nonatomic, retain) UIButton * logoutButton;

/**
 * This method builds the top navigation bar. It's used in viewDidLoad as a way to keep the code
 * separated and more easily readable.
 *
 * @return void
 */
- (void)buildNavigationBar;

/**
 * When a user touchs one of the top navigation buttons, this method is executed and runs the 
 * appropriate code or task.
 *
 * @param id
 *  The object of the button that was pressed.
 *
 * @return void
 */
- (void)didSelectSubNavButton:(id)sender;

@end
