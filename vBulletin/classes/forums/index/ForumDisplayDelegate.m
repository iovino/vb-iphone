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
#import "ForumDisplayDelegate.h"

// Forum Data Model
#import "ForumDisplayDataModel.h"

// Main Table Header
#import "vBulletinTableHeaderView.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumDisplayDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    // fetch the forum's source class
    id<TTTableViewDataSource> source  = (id<TTTableViewDataSource>)tableView.dataSource;
    
    // set the forum's title
    NSString * title = 
        [NSString stringWithString:[source tableView:tableView titleForHeaderInSection:section]];

    // return the table's header view
    return [[vBulletinTableHeaderView alloc] initWithTitle:title
                                                description:@""];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    // fetch the forum's source class
    id<TTTableViewDataSource> source = (id<TTTableViewDataSource>)tableView.dataSource;
    
    // set the forum's title
    NSString * title = 
        [NSString stringWithString:[source tableView:tableView titleForHeaderInSection:section]];    
    
    NSLog(@"title %@", title);
    
    
    // render a text label for the title
    TTStyledTextLabel * titleLabel = [[TTStyledTextLabel alloc] init];
    titleLabel.text            = [TTStyledText textFromXHTML:title lineBreaks:YES URLs:YES];
    titleLabel.backgroundColor = TTSTYLEVAR(forumTableHeaderTitleBackgroundColor);
    titleLabel.textColor       = TTSTYLEVAR(forumTableHeaderTitleTextColor);
    titleLabel.font            = TTSTYLEVAR(forumTableHeaderTitleFont);
    titleLabel.text.width      = tableView.frame.size.width - TTSTYLEVAR(forumTableHeaderPadding) * 2;
    
    // return the title of the forum's title
    return titleLabel.text.height + TTSTYLEVAR(forumTableHeaderPadding) * 2;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<TTTableViewDataSource> dataSource = (id<TTTableViewDataSource>)tableView.dataSource;    
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    return [cls tableView:tableView rowHeightForObject:object];
}


@end
