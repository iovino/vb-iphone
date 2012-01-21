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
 * Enumeration to clarify which form is being submitted.
 */
typedef enum  {
    FormValuesForLogin, /* The user submission is from the login form */
    FormValuesForSignup /* The user submission is from the signup form */
} FormValuesFor;

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
    
    /**
     * This table is used to contain the login and signup fields.
     */
    TTTableView * _loginTable;

    /**
     * The login tables datasource for adding and removing input fields.
     */
    TTListDataSource * _loginTableDataSource;

    /**
     * The textfield used for the entering in a username.
     */
    UITextField * _userField;

    /**
     * The textfield used for the entering in a password.
     */
    UITextField * _passField;

    /**
     * The textfield used for the entering in an email.
     */
    UITextField * _emailField;
    
    /**
     * The login button.
     */
    UIButton * _loginButton;

    /**
     * The signup button.
     */
    UIButton * _signupButton;

    /**
     * The lost password button.
     */
    UIButton * _lostpwButton;

    /**
     * The privacy button.
     */
    UIButton * _privacyButton;

    /**
     * The terms of service button.
     */
    UIButton * _tosButton;

    /**
     * We keep track of the animated distance between the keyboard and the active field.
     */
    CGFloat _animatedDistance;
    
    /**
     * Tells us whether or not the keyboard is on the screen.
     */
    BOOL _isKeyboardPresent;
    
    /**
     * The activity label used when the form submission is being sent to the remote server.
     */
    TTActivityLabel  * _activityLabelForFrame;

    /**
     * The activity label used while transitioning the user on a successful login or signup.
     */
    TTActivityLabel  * _activityLabelForTable;
}

@property (nonatomic, retain) UIImageView      * logoView;
@property (nonatomic, retain) TTTableView      * loginTable;
@property (nonatomic, retain) TTListDataSource * loginTableDataSource;

@property (nonatomic, retain) UITextField      * userField;
@property (nonatomic, retain) UITextField      * passField;
@property (nonatomic, retain) UITextField      * emailField;

@property (nonatomic, retain) UIButton         * loginButton;
@property (nonatomic, retain) UIButton         * signupButton;
@property (nonatomic, retain) UIButton         * lostpwButton;
@property (nonatomic, retain) UIButton         * privacyButton;
@property (nonatomic, retain) UIButton         * tosButton;

@property (nonatomic, readwrite) CGFloat         animatedDistance;
@property (nonatomic, readwrite) BOOL            isKeyboardPresent;

@property (nonatomic, retain) TTActivityLabel  * activityLabelForFrame;
@property (nonatomic, retain) TTActivityLabel  * activityLabelForTable;


/**
 * This method finds the active UIField and dismisses the keyboard from the screen.
 * 
 * @return BOOL
 */
- (BOOL)findAndResignFirstResonder:(UIView *)view;

/**
 * This method is executed when the KeyboardWillShow notification is fired.
 * 
 * @param NSNotification
 *  The UIKeyboardWillShowNotification obect.
 *
 * @return void
 */
- (void)keyboardWillShow:(NSNotification*)notification;

/**
 * This method is executed when the KeyboardWillHide notification is fired.
 * 
 * @param NSNotification
 *  The UIKeyboardWillHideNotification obect.
 *
 * @return void
 */
- (void)keyboardWillHide:(NSNotification*)notification;

/**
 * This method is executed when the signup button is pressed. We check if we're submitting the
 * data, and if not, we transition to the signup form using some animation.
 *
 * @return void
 */
- (void)signupButtonPressed;

/**
 * Same as the signup method, but for login. When pressed, we check if we're submitting the data, 
 * and if not, we transition to the login form using some animation.
 *
 * @return void
 */
- (void)loginButtonPressed;

/**
 * This method is executed when we're ready to send the sign or login data to the remote server.
 * 
 * @param enum
 *  The 'FormValuesFor' enumeration to determine which form the submission came from. 
 *
 * @return void
 */
- (void)submit:(FormValuesFor)form;


@end
