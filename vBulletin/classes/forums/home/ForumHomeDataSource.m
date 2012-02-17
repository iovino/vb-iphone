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
#import "ForumHomeDataSource.h"

// Class Data Model
#import "ForumHomeDataModel.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// vBulletin's Table Items
#import "vBulletinTableSubtitleItem.h"

// vBulletin's Table Item Cells
#import "vBulletinTableSubtitleItemCell.h"

// vBulletin's Table Header
//#import "vBulletinTableHeaderView.h"

// Three20's Date Extras
//#import <Three20Core/NSDateAdditions.h>

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumHomeDataSource

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    
	if (self) {
        _dataModel = [[ForumHomeDataModel alloc] init];
	}
	
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TTTableViewDataSource

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _dataModel;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView *)tableView {
    
    NSMutableArray * items    = [[NSMutableArray alloc] init];
    NSMutableArray * sections = [[NSMutableArray alloc] init];
    
    // loop through all the parent forums
    for (id parent in _dataModel.forums) 
    {
        NSMutableArray * item = [[NSMutableArray alloc] init];

        // loop through this parent's child forums
        for (NSArray * forum in [parent valueForKey:@"children"]) {
        
            // setup some convenient variables to add to the item object
            NSString * iconPath = [NSString stringWithString:@""];
            NSString * title    = [NSString stringWithString:[forum valueForKey:@"title"]];
            NSString * detail   = [NSString stringWithString:[forum valueForKey:@"description"]];
            NSString * url      = [NSString stringWithFormat:@"vb://forums/forumdisplay/%@", 
                                   [forum valueForKey:@"forumid"]];

            // figure out which forum lightbulb we need to show
            if ([[forum valueForKey:@"statusicon"] isEqualToString:@"new"]) {
                iconPath = TTSTYLEVAR(forumTableCellForumLightbulbPathActive);
            } else {
                iconPath = TTSTYLEVAR(forumTableCellForumLightbulbPath);
            }

            // build the forum object and add it to the item array
            [item addObject:[vBulletinTableSubtitleItem itemWithTitle:title
                                                             subtitle:detail
                                                                 icon:vBStyleImage(iconPath)
                                                                  url:url]];
        }
        
        // add all the built items to the temp items array for later use
        [items addObject:item];
        
        // set the parent title to the sections array for later use
        [sections addObject:[parent valueForKey:@"title"]];        
    }
    
    // asign the built items and sections array to the source ivars
    self.items    = items;
    self.sections = sections;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
    
	if ([object isKindOfClass:[vBulletinTableSubtitleItem class]]) {  
		return [vBulletinTableSubtitleItemCell class];  
	}
    
	return [super tableView:tableView cellClassForObject:object];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Error Handling

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)titleForLoading:(BOOL)reloading {
	return @"Loading...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)titleForEmpty {
	return @"No forums to display";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)titleForError:(NSError *)error {
	return @"Oops";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)subtitleForError:(NSError *)error {
	return @"The forum home is not available at this time. Please try again later.";
}

@end
