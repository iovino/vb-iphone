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

    /**
     * The dictionary array of the current user's information.
     */
    NSDictionary * _userinfo;

    /**
     * The view used for the welcome box.
     */
    UIView * _welcomeView;
    
    /**
     * The main view used to construct the avatar box.
     */
    UIView * _avatarView;

    /**
     * The actual image of the user's avatar.
     */
    TTImageView * _avatarImage;

    /**
     * The avatar button used when the users taps the avatar image.
     */
    UIButton * _avatarButton;
    
    /**
     * The picker menu used to select whether or not the user wants to create a new avatar using 
     * the camera or selecting from an existing photo already saved on the phone.
     */
    UIImagePickerController * _avatarPicker;
    
    /**
     * The activity label used to indicate when the avatar is being updated.
     */
    UIActivityIndicatorView * _avatarActivity;
}

@property (nonatomic, copy) NSDictionary * userinfo;

@property (nonatomic, retain) UIView   * navView;
@property (nonatomic, retain) UIButton * profileButton;
@property (nonatomic, retain) UIButton * searchButton;
@property (nonatomic, retain) UIButton * optionsButton;
@property (nonatomic, retain) UIButton * logoutButton;

@property (nonatomic, retain) UIView                  * welcomeView;
@property (nonatomic, retain) UIView                  * avatarView;
@property (nonatomic, retain) TTImageView             * avatarImageView;
@property (nonatomic, retain) UIButton                * avatarImageButton;
@property (nonatomic, retain) UIImagePickerController * avatarPicker;
@property (nonatomic, retain) UIActivityIndicatorView * avatarActivity;

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

/**
 * This method builds the welcome box. It's used much like buildNavigationBar as a way to keep the 
 * code separated and more easily readable.
 *
 * @return void
 */
- (void)buildWelcomeBox;

/**
 * This method is used to show an action sheet of options so the user can delete or upload a new
 * avatar image.
 *
 * @return void
 */
- (void)didSelectAvatarImage;
@end
