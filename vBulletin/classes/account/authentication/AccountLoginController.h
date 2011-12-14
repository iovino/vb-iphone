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
 * @class       vBulletinStyleSheet
 * @abstract    The home screen where the user can login or signup.
 * 
 * @discussion
 * This is the first screen the user will see if they're logged out or
 * using the application for the first time. They'll be presented with
 * a form to login since most users will already have an account. Should
 * the user not have one there is a signup button that will change the login
 * form to a signup form.
 *
 * All text be submited to the server is in clear text. Passwords are hashed via
 * MD5 before submission. I'm open to any better ideas for hashing / encrypting
 * passwords in a more secure way since MD5 is pretty easily crackable.
 */
@interface AccountLoginController : TTViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    /**
     * The applications delegate.
     */
    vBulletinAppDelegate * appDelegate;

    /**
     * The image view for the applications logo.
     */
    UIImageView * _logoView;
}

@property (nonatomic, retain) UIImageView * logoView;


@end
