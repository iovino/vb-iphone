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

// Text Field Additions
#import "UITextField+Extended.h"

// The time is takes for the keyboard to scroll up when a login field is selected.
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;

// The minimum scroll fraction the keyboard should adhear to.
static const CGFloat MIN_SCROLL_FRAC = 0.1;

// The maximum scroll fraction the keyboard should adhear to.
static const CGFloat MAX_SCROLL_FRAC = 0.8;

// The height of the keyboard while in portrait mode.
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

// The height of the keyboard while in landscape mode.
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AccountLoginController

@synthesize logoView             = _logoView;
@synthesize loginTable           = _loginTable;
@synthesize loginTableDataSource = _loginTableDataSource;

@synthesize userField            = _userField;
@synthesize passField            = _passField;
@synthesize emailField           = _emailField;

@synthesize loginButton          = _loginButton;
@synthesize signupButton         = _signupButton;
@synthesize lostpwButton         = _lostpwButton;
@synthesize privacyButton        = _privacyButton;
@synthesize tosButton            = _tosButton;

@synthesize animatedDistance     = _animatedDistance;
@synthesize isLoggingIn          = _isLoggingIn;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Memory Managment

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // make the application delegate avaliable
        appDelegate = (vBulletinAppDelegate *) [[UIApplication sharedApplication] delegate];
        
        // set some defaults for the view
        self.view.backgroundColor = TTSTYLEVAR(backgroundColor);
        self.isLoggingIn = YES;
        
        // notifications

        
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self findAndResignFirstResonder: self.view];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // logo view
    self.logoView                   = [[UIImageView alloc] initWithImage:TTSTYLEVAR(logoImage)];
    self.logoView.frame             = TTSTYLEVAR(logoFrame);
    self.logoView.autoresizingMask  = TTSTYLEVAR(logoAutoMask);
    
    // login table
    self.loginTable = [[TTTableView alloc] initWithFrame:TTSTYLEVAR(loginTableFrame) 
                                                   style:TTSTYLEVAR(loginTableStyle)];
    self.loginTable.backgroundColor  = TTSTYLEVAR(loginTableBackgroundColor);
    self.loginTable.scrollEnabled    = TTSTYLEVAR(loginTableScrollEnabled);
    self.loginTable.separatorColor   = TTSTYLEVAR(loginTableSeparatorColor);
    self.loginTable.autoresizingMask = TTSTYLEVAR(loginTableAutoMask);
    
    // login table - datasourse
    self.loginTableDataSource = [[TTListDataSource alloc] init];    
    self.loginTable.dataSource = self.loginTableDataSource;
    
    // table fields
    self.userField  = [[UITextField alloc] init];
    self.passField  = [[UITextField alloc] init];
    self.emailField = [[UITextField alloc] init];
    
    self.userField.placeholder      = @"Username";
    self.userField.delegate         = self;
    self.userField.keyboardType     = UIKeyboardTypeDefault;
    self.userField.returnKeyType    = UIReturnKeyNext;
    self.userField.clearButtonMode  = UITextFieldViewModeWhileEditing;
    self.userField.nextField        = self.passField;
    
    self.passField.placeholder      = @"Password";
    self.passField.secureTextEntry  = YES;
    self.passField.delegate         = self;
    self.userField.keyboardType     = UIKeyboardTypeDefault;
    self.passField.returnKeyType    = UIReturnKeyGo;
    self.passField.clearButtonMode  = UITextFieldViewModeWhileEditing;
    self.passField.nextField        = self.emailField;
    
    self.emailField.placeholder     = @"Email";
    self.emailField.delegate        = self;
    self.emailField.keyboardType    = UIKeyboardTypeEmailAddress;
    self.emailField.returnKeyType   = UIReturnKeyGo;
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailField.nextField       = self.userField;
    
    // Since there is no way to actually change the placeholder text color, we have
    // to use apple's private ivar, which may not make it through the appstore review. 
    // If it gets rejected, try the following: http://stackoverflow.com/a/7002922/539529
    // There may also be a way to do this in iOS 5+ now, we'll need to research that.
    [self.userField setValue:TTSTYLEVAR(fieldPlaceholderTextColor) 
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.passField setValue:TTSTYLEVAR(fieldPlaceholderTextColor) 
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.emailField setValue:TTSTYLEVAR(fieldPlaceholderTextColor) 
                   forKeyPath:@"_placeholderLabel.textColor"];
    
    // add default text fields
    [self.loginTableDataSource.items addObject:self.userField];
    [self.loginTableDataSource.items addObject:self.passField];
    
    //
    // Buttons
    //
    
    // signup button    
    CGFloat sbYAxis = floorf(self.loginTable.size.height + self.loginTable.origin.y);
    
    self.signupButton = [[UIButton alloc] initWithFrame:CGRectMake(20, sbYAxis , 134, 40)];
    [self.signupButton setImage:TTSTYLEVAR(signupButtonImage) forState:UIControlStateNormal];
    [self.signupButton setImage:TTSTYLEVAR(signupButtonImage) forState:UIControlStateDisabled];
    [self.signupButton setEnabled:YES];
    [self.signupButton setAlpha:1.0];
    [self.signupButton addTarget:self 
                          action:@selector(signupButtonPressed) 
                forControlEvents:UIControlEventTouchUpInside];
    
    // login button
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(165, sbYAxis , 134, 40)];
    [self.loginButton setImage:TTSTYLEVAR(loginButtonImage) forState:UIControlStateNormal];
    [self.loginButton setImage:TTSTYLEVAR(loginButtonImage) forState:UIControlStateDisabled];
    [self.loginButton setEnabled:YES];
    [self.loginButton setAlpha:1.0];
    [self.loginButton addTarget:self 
                         action:@selector(loginButtonPressed) 
               forControlEvents:UIControlEventTouchUpInside];
    
    // lost pw button
    CGFloat pwWth = 113.0;
    CGFloat pwHht = 15.0;
    CGFloat pwXAx = floorf(320 / 2 - pwWth / 2);
    CGFloat pwYAx = floorf(self.loginButton.origin.y + TTSTYLEVAR(loginVertSpacing) * 3);
    
    self.lostpwButton = [[UIButton alloc] initWithFrame:CGRectMake(pwXAx, pwYAx, pwWth, pwHht)];
    [self.lostpwButton setTitle:@"Password Recovery" forState:UIControlStateNormal];
    [self.lostpwButton.titleLabel setShadowOffset:TTSTYLEVAR(loginLinksShadowOffset)];
    [self.lostpwButton.titleLabel setFont:TTSTYLEVAR(loginLinksFont)];
    [self.lostpwButton setTitleColor:TTSTYLEVAR(loginLinksColor) 
                            forState:UIControlStateNormal];
    [self.lostpwButton setTitleColor:TTSTYLEVAR(loginLinksColorHighlighted) 
                            forState:UIControlStateHighlighted];
    [self.lostpwButton setTitleShadowColor:TTSTYLEVAR(loginLinksColorShadow) 
                                  forState:UIControlStateNormal];
    [self.lostpwButton setTitleShadowColor:TTSTYLEVAR(loginLinksColorShadow) 
                                  forState:UIControlStateHighlighted];
    [self.lostpwButton addTarget:self 
                          action:@selector(lostpwButtonPressed) 
                forControlEvents:UIControlEventTouchUpInside];
    
    // privacy policy button
    CGFloat ppWth = 113.0;
    CGFloat ppHht = 15.0;
    CGFloat ppXAx = floorf((320 / 2 - (ppWth / 2)) - (ppWth / 2));
    CGFloat ppYAx = floorf(self.view.size.height - TTSTYLEVAR(loginVertSpacing));
    
    self.privacyButton = [[UIButton alloc] initWithFrame:CGRectMake(ppXAx, ppYAx, ppWth, ppHht)];
    [self.privacyButton setTitle:@"Privacy Policy" forState:UIControlStateNormal];
    [self.privacyButton.titleLabel setShadowOffset:TTSTYLEVAR(loginLinksShadowOffset)];
    [self.privacyButton.titleLabel setFont:TTSTYLEVAR(loginLinksFont)];
    [self.privacyButton setTitleColor:TTSTYLEVAR(loginLinksColor) 
                             forState:UIControlStateNormal];
    [self.privacyButton setTitleColor:TTSTYLEVAR(loginLinksColorHighlighted) 
                             forState:UIControlStateHighlighted];
    [self.privacyButton setTitleShadowColor:TTSTYLEVAR(loginLinksColorShadow) 
                                   forState:UIControlStateNormal];
    [self.privacyButton setTitleShadowColor:TTSTYLEVAR(loginLinksColorShadow) 
                                   forState:UIControlStateHighlighted];
    [self.privacyButton addTarget:self 
                           action:@selector(lostpwButtonPressed) 
                 forControlEvents:UIControlEventTouchUpInside];
    
    // tos button
    CGFloat tosWth = 113.0;
    CGFloat tosHht = 15.0;
    CGFloat tosXAx = floorf((320 / 2 - (tosWth / 2)) + (tosWth / 2));
    CGFloat tosYAx = floorf(self.view.size.height - TTSTYLEVAR(loginVertSpacing));
    
    self.tosButton = [[UIButton alloc] initWithFrame:CGRectMake(tosXAx, tosYAx, tosWth, tosHht)];
    [self.tosButton setTitle:@"Terms of Service" forState:UIControlStateNormal];
    [self.tosButton.titleLabel setShadowOffset:TTSTYLEVAR(loginLinksShadowOffset)];
    [self.tosButton.titleLabel setFont:TTSTYLEVAR(loginLinksFont)];
    [self.tosButton setTitleColor:TTSTYLEVAR(loginLinksColor) 
                         forState:UIControlStateNormal];
    [self.tosButton setTitleColor:TTSTYLEVAR(loginLinksColorHighlighted) 
                         forState:UIControlStateHighlighted];
    [self.tosButton setTitleShadowColor:TTSTYLEVAR(loginLinksColorShadow) 
                               forState:UIControlStateNormal];
    [self.tosButton setTitleShadowColor:TTSTYLEVAR(loginLinksColorShadow) 
                               forState:UIControlStateHighlighted];
    [self.tosButton addTarget:self 
                       action:@selector(lostpwButtonPressed) 
             forControlEvents:UIControlEventTouchUpInside];
    
    // add all the sub-views
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.loginTable];
    
    [self.view addSubview:self.signupButton];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.lostpwButton];
    [self.view addSubview:self.privacyButton];
    [self.view addSubview:self.tosButton];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"didRotateFromInterfaceOrientation");
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)findAndResignFirstResonder:(UIView *)view {
    if (view.isFirstResponder) {
        [view resignFirstResponder];
        return YES;     
    }
    for (UIView * subView in view.subviews) {
        if ([self findAndResignFirstResonder:subView])
            return YES;
    }
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextFieldDelagate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline        = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator      = midline - viewRect.origin.y - MIN_SCROLL_FRAC * viewRect.size.height;
    CGFloat denominator    = (MAX_SCROLL_FRAC - MIN_SCROLL_FRAC) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    } else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else {
        self.animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame    = self.view.frame;
    viewFrame.origin.y -= self.animatedDistance;
    
    [UIView animateWithDuration:KEYBOARD_ANIMATION_DURATION 
                          delay:0.0 
                        options:(UIViewAnimationOptionBeginFromCurrentState )
                     animations:^{
                         [self.view setFrame:viewFrame];
                     } 
                     completion:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGRect viewFrame    = self.view.frame;
    viewFrame.origin.y += self.animatedDistance;
    
    [UIView animateWithDuration:KEYBOARD_ANIMATION_DURATION 
                          delay:0.0 
                        options:(UIViewAnimationOptionBeginFromCurrentState )
                     animations:^{
                         [self.view setFrame:viewFrame];
                     } 
                     completion:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    UITextField * nextField = textField.nextField;
    
    if (self.isLoggingIn) {
        if ([self.userField.text length] > 0 && [self.passField.text length] > 0) {
            NSLog(@"submit login details");
        } else {
            [nextField becomeFirstResponder];
        }
    }
    
    return NO;
}

@end

