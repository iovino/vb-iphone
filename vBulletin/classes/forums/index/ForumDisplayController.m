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
#import "ForumDisplayController.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// Forumhome's Datasource
#import "ForumDisplayDataSource.h"

// Forumhome's Delegate
#import "ForumDisplayDelegate.h"

// Three20's UI Additition
#import "Three20UI/UIViewAdditions.h"

// QuartzCore Framework
#import <QuartzCore/QuartzCore.h>

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumDisplayController

@synthesize forumid          = _forumid;
@synthesize dataSource2      = _dataSource2;
//@synthesize toolbar          = _toolbar;
//@synthesize toolbarButton    = _toolbarButton;
//@synthesize inPseudoEditMode = _inPseudoEditMode;
//@synthesize selectedItems    = _selectedItems;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Memory Management

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
- (id)initWithForumId:(NSString *)forumId {
    
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        // title logo
        self.navigationItem.titleView = TTSTYLEVAR(titleImage);

        // Application Delegate
        appDelegate  = (vBulletinAppDelegate *) [[UIApplication sharedApplication] delegate];
        self.forumid = forumId;
        
        // notifications
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(reloadForumsDisplay)
                                                     name:@"reloadForumsDisplay"
                                                   object:nil ];
        
        
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = RGBCOLOR(184, 184, 184);
    
    // set the right navigation button
    self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                  target:self 
                                                  action:@selector(actionSheet)];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"reloadForumsDisplay"
                                                  object:nil];
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

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionSheet {
    UIActionSheet * sheet = [[UIActionSheet alloc] init];
    [sheet addButtonWithTitle:@"Mark Forums Read"];
    [sheet addButtonWithTitle:@"Cancel"];
    [sheet setCancelButtonIndex:1];
    [sheet setDelegate:self];
    [sheet showInView:self.view];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reloadForumsDisplay {
    // use this to see if sub forums are there or not
    // [self.dataSource numberOfSectionsInTableView:self.tableView]);
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] 
                          atScrollPosition:UITableViewScrollPositionTop 
                                  animated:YES];
    [self reload];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIActionSheetDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        MARK;
    } 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
    ForumDisplayDataSource * dataSource = 
        [[ForumDisplayDataSource alloc] initWithForumId:[self forumid]];
    
    self.dataSource  = dataSource; // read only
    self.dataSource2 = dataSource;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTTableViewDelegate>) createDelegate {
    return [[ForumDisplayDelegate alloc] initWithController:self];
}

@end
