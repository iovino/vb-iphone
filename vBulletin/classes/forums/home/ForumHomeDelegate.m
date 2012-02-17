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
#import "ForumHomeDelegate.h"

// Forum Data Model
#import "ForumHomeDataModel.h"

// Main Table Header
#import "vBulletinTableHeaderView.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumHomeDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // fetch the forum's home source and model
    id<TTTableViewDataSource> source = (id<TTTableViewDataSource>)tableView.dataSource;
    ForumHomeDataModel      * model  = (ForumHomeDataModel *)[source model];
    
    // fetch the current forum's information from the model (title, description, etc..)
    NSDictionary * forum = 
        [[NSDictionary alloc] initWithDictionary:[[model forums] objectAtIndex:section]];    
    NSString * title       = [NSString stringWithFormat:@"<b>%@</b>", [forum valueForKey:@"title"]];
    NSString * description = [NSString stringWithString:[forum valueForKey:@"description"]];
    
    // return the table's header view
    return [[vBulletinTableHeaderView alloc] initWithTitle:title 
                                                description:description];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    // fetch the forum's home source and model
    id<TTTableViewDataSource> source = (id<TTTableViewDataSource>)tableView.dataSource;
    ForumHomeDataModel      * model  = (ForumHomeDataModel *)[source model];
    
    // fetch the current forum's information from the model (title, description, etc..)
    NSDictionary * forum =
        [[NSDictionary alloc] initWithDictionary:[[model forums] objectAtIndex:section]];
    NSString * title = [NSString stringWithString:[forum valueForKey:@"title"]];
    NSString * descp = [NSString stringWithString:[forum valueForKey:@"description"]];
    
    // get the label's width and max size
    CGFloat labelWidth   = 320 - TTSTYLEVAR(forumTableHeaderPadding) * 2;
    CGSize  labelMaxSize = CGSizeMake(labelWidth, CGFLOAT_MAX);
    
    // figure out the current title and descriptions size based on the content, font and font size
    CGSize titleSize = [title sizeWithFont:TTSTYLEVAR(forumTableHeaderTitleFont)
                         constrainedToSize:labelMaxSize
                             lineBreakMode:UILineBreakModeWordWrap]; 
    CGSize descSize  = [descp sizeWithFont:TTSTYLEVAR(forumTableHeaderDescFont)
                         constrainedToSize:labelMaxSize
                             lineBreakMode:UILineBreakModeWordWrap]; 
    
    // figure out the height of the background based on the above values
    NSInteger bgHeight = 
        titleSize.height + descSize.height + TTSTYLEVAR(forumTableHeaderPadding) * 2;
    
    // if the description is present, add its height to the equation
    if (![descp isEqualToString:@""]) {
        bgHeight = bgHeight + TTSTYLEVAR(forumTableHeaderTextLineSpacing);
    }

    // return the height for the header    
    return bgHeight;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<TTTableViewDataSource> dataSource = (id<TTTableViewDataSource>)tableView.dataSource;    
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    return [cls tableView:tableView rowHeightForObject:object];
}

@end
