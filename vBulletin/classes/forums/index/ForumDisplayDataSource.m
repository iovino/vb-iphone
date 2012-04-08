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
#import "ForumDisplayDataSource.h"

// Model File
#import "ForumDisplayDataModel.h"

// vBulletin's Table Items
#import "vBulletinTableSubtitleItem.h"

// vBulletin's Table Item Cells
#import "vBulletinTableSubtitleItemCell.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// The Thread Item
#import "ForumDisplayThreadItem.h"

// The Thread Item's Cell
#import "ForumDisplayThreadItemCell.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumDisplayDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark --
#pragma mark Memory Management

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithForumId:(NSString *)forumId {
    self = [super init];
    
	if (self) {
        // grab the data retrieved from the server
        _dataModel = [[ForumDisplayDataModel alloc] initWithForumId:forumId];
	}
	
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _dataModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView *)tableView {
    
    NSMutableArray * items    = [[NSMutableArray alloc] init];
    NSMutableArray * sections = [[NSMutableArray alloc] init];
    NSString       * title    = [NSString stringWithString:[_dataModel.foruminfo valueForKey:@"title"]];
    
    // loop through any sub-forums
    if ([_dataModel.subforums count] > 0) {
        NSMutableArray * forums = [[NSMutableArray alloc] init];
        
        for (id forum in _dataModel.subforums) {
            
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
            [forums addObject:[vBulletinTableSubtitleItem itemWithTitle:title
                                                               subtitle:detail
                                                                   icon:vBStyleImage(iconPath)
                                                                    url:url]];
        }
        
        [sections addObject:[NSString stringWithFormat:@"<b>Sub-Forums in :</b> %@", title]];
        [items addObject:forums];        
    }
    
    
    // loop through all the threads
    if ([_dataModel.threads count] > 0) {
        
        NSMutableArray * threads = [[NSMutableArray alloc] init];
        
        // make sure the announcements are first
        if ([_dataModel.announcements count] > 0) {
            for (id announcement in _dataModel.announcements) {            
                [threads addObject:[TTTableLink itemWithText:@"announcement test" // fix the weird array issues coming from server's json output
                                                         URL:[NSString stringWithFormat:@"vb://forums/announcement/%@", [announcement valueForKey:@"announcementid"]]]];
            }
        }
        
        // get all the threads
        for (id thread in _dataModel.threads) {            
            
            // set up an icon path
            NSString * iconPath = [NSString stringWithString:@""];
            
            if ([[thread valueForKey:@"sticky"] intValue] == 1) {
                iconPath = @"/threads/sticky_icon.png";
            } else {
                iconPath = 	[NSString stringWithFormat:@"/threads/thread%@.gif", [thread valueForKey:@"statusicon"]];
            }
            
            // add the thread item to a threads object
            [threads addObject:[ForumDisplayThreadItem itemWithTitle:[thread valueForKey:@"threadtitle"]
                                                              author:[thread valueForKey:@"postusername"]
                                                               views:[NSString stringWithFormat:@"%@", [thread valueForKey:@"views"]]
                                                             replies:[NSString stringWithFormat:@"%@", [thread valueForKey:@"replycount"]]
                                                                icon:vBStyleImage(iconPath)
                                                                 url:[NSString stringWithFormat:@"vb://forums/showthread/%@", [thread valueForKey:@"threadid"]]]];
        }
        
        // add the threads section header
        [sections addObject:[NSString stringWithFormat:@"<b>Threads in :</b> %@", title]];
        
        // include a "load more threads" button at the end of the list
        if ([_dataModel.threads count] < [[_dataModel.foruminfo valueForKey:@"totalthreads"] intValue]) {
            [threads addObject:[TTTableMoreButton itemWithText:@"Load more threads…"]];
        }
        
        // add the built threads to the main items object
        [items addObject:threads];        
        
    }
    
    self.items    = items;        
    self.sections = sections;        
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
    
//  if ([object isKindOfClass:[ForumDisplayAnnounceItem class]]) {  
//		return [ForumDisplayAnnounceItemCell class];  
//	}
    
    if ([object isKindOfClass:[ForumDisplayThreadItem class]]) {  
		return [ForumDisplayThreadItemCell class];  
	}
    
	if ([object isKindOfClass:[vBulletinTableSubtitleItem class]]) {  
		return [vBulletinTableSubtitleItemCell class];  
	}

	return [super tableView:tableView cellClassForObject:object];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Error Handling

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)titleForLoading:(BOOL)reloading {
	return @"Loading..."; 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)titleForEmpty {
	return @"No forums to display";
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)titleForError:(NSError *)error {
	return @"Oops";
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)subtitleForError:(NSError *)error {
	return @"The forum home is not available at this time.";
}

@end
