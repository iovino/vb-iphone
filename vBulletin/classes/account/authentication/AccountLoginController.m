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

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AccountLoginController

@synthesize logoView             = _logoView;
@synthesize loginTable           = _loginTable;
@synthesize loginTableDataSource = _loginTableDataSource;

@synthesize userField            = _userField;
@synthesize passField            = _passField;
@synthesize emailField           = _emailField;

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
    self.userField = [[UITextField alloc] init];
    self.userField.placeholder      = @"Username";
    self.userField.delegate         = self;
    self.userField.keyboardType     = UIKeyboardTypeDefault;
    self.userField.returnKeyType    = UIReturnKeyNext;
    self.userField.clearButtonMode  = UITextFieldViewModeWhileEditing;
    
    self.passField = [[UITextField alloc] init];
    self.passField.placeholder      = @"Password";
    self.passField.secureTextEntry  = YES;
    self.passField.delegate         = self;
    self.userField.keyboardType     = UIKeyboardTypeDefault;
    self.passField.returnKeyType    = UIReturnKeyGo;
    self.passField.clearButtonMode  = UITextFieldViewModeWhileEditing;
    
    self.emailField = [[UITextField alloc] init];
    self.emailField.placeholder     = @"Email";
    self.emailField.delegate        = self;
    self.emailField.keyboardType    = UIKeyboardTypeEmailAddress;
    self.emailField.returnKeyType   = UIReturnKeyGo;
    self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // Since there is no way to actually change the placeholder text color, we have
    // to use apple's private ivar, which may not make it through the appstore review. 
    // If it gets rejected, try the following: http://stackoverflow.com/a/7002922/539529

    [self.userField setValue:TTSTYLEVAR(fieldPlaceholderTextColor) 
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.passField setValue:TTSTYLEVAR(fieldPlaceholderTextColor) 
                  forKeyPath:@"_placeholderLabel.textColor"];
    [self.emailField setValue:TTSTYLEVAR(fieldPlaceholderTextColor) 
                   forKeyPath:@"_placeholderLabel.textColor"];
    
    // add default text fields
    [self.loginTableDataSource.items addObject:self.userField];
    [self.loginTableDataSource.items addObject:self.passField];
    
    // add all sub-views
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.loginTable];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"didRotateFromInterfaceOrientation");
}


@end

