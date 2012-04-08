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
#import "ForumDisplayThreadItemCell.h"

// The Thread Item
#import "ForumDisplayThreadItem.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// Three20's JSON library
#import <extThree20JSON/extThree20JSON.h>

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumDisplayThreadItemCell

@synthesize viewsLabel       = _viewsLabel;
@synthesize repliesLabel     = _repliesLabel;
@synthesize viewsIcon        = _viewsIcon;
@synthesize repliesIcon      = _repliesIcon;
@synthesize inEditMode       = _inEditMode;
@synthesize isCellSelected   = _isCellSelected;
@synthesize checkMarkImage   = _checkMarkImage;
@synthesize threadItem       = _threadItem;
@synthesize iconButton       = _iconButton;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    if (self) {
        self.viewsLabel     = [[UILabel alloc] init];
        self.repliesLabel   = [[UILabel alloc] init];
        self.viewsIcon      = [[UIImageView alloc] init];
        self.repliesIcon    = [[UIImageView alloc] init];
        self.iconButton     = [[UIButton alloc] init];
        self.checkMarkImage = [[UIImageView alloc] init];
        self.checkMarkImage.alpha = 0.0;
        self.checkMarkImage.image = vBStyleImage(@"/threads/unselected.png");
        
        [self.contentView addSubview:self.viewsLabel];
        [self.contentView addSubview:self.repliesLabel];
        [self.contentView addSubview:self.viewsIcon];
        [self.contentView addSubview:self.repliesIcon];
        [self.contentView addSubview:self.checkMarkImage];
        
        self.inEditMode     = NO;
        self.isCellSelected = NO;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {    
//    ForumDisplayThreadItem * item = object;
//    CGSize titleSize  = [item.text sizeWithFont:TTSTYLEVAR(forumTableCellDetailFont)
//                              constrainedToSize:CGSizeMake(260, CGFLOAT_MAX)
//                                  lineBreakMode:UILineBreakModeWordWrap];
//
//    return 50 + titleSize.height;
//}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
    if (_item != object) {
        [super setObject:object];
        
        ForumDisplayThreadItem * item = object;
        
        if (item.views.length) {
            self.viewsLabel.text = item.views;
        }
        if (item.replies.length) {
            self.repliesLabel.text = item.replies;
        }
        if (item.selected.length) {
            self.isCellSelected = [item.selected boolValue];
        }
        
        self.threadItem = item;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.viewsLabel.font              = TTSTYLEVAR(forumTableCellDetailFont);
    self.viewsLabel.backgroundColor   = TTSTYLEVAR(forumTableCellDetailBackgroundColor);
    self.viewsLabel.textColor         = TTSTYLEVAR(forumTableCellDetailTextColor);
    self.viewsLabel.shadowColor       = TTSTYLEVAR(forumTableCellDetailShadowColor);
    self.viewsLabel.shadowOffset      = TTSTYLEVAR(forumTableCellDetailShadowOffset);
    self.viewsLabel.numberOfLines     = 99;
    
    self.repliesLabel.font            = TTSTYLEVAR(forumTableCellDetailFont);
    self.repliesLabel.backgroundColor = TTSTYLEVAR(forumTableCellDetailBackgroundColor);
    self.repliesLabel.textColor       = TTSTYLEVAR(forumTableCellDetailTextColor);
    self.repliesLabel.shadowColor     = TTSTYLEVAR(forumTableCellDetailShadowColor);
    self.repliesLabel.shadowOffset    = TTSTYLEVAR(forumTableCellDetailShadowOffset);
    self.repliesLabel.numberOfLines   = 99;
    
    // calulate the width & height based on the number of views and replies
    CGSize viewsSize    = [self.viewsLabel.text sizeWithFont:TTSTYLEVAR(forumTableCellDetailFont)
                                           constrainedToSize:CGSizeMake(65, CGFLOAT_MAX)
                                               lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize repliesSize  = [self.repliesLabel.text sizeWithFont:TTSTYLEVAR(forumTableCellDetailFont)
                                             constrainedToSize:CGSizeMake(65, CGFLOAT_MAX)
                                                 lineBreakMode:UILineBreakModeTailTruncation];
    
    // position the views based on how long the number is
    NSInteger xAxisForViews = self.frame.size.width - viewsSize.width - repliesSize.width - 60;
    NSInteger yAxisForViews = self.detailTextLabel.frame.origin.y;
    self.viewsLabel.frame   = 
    CGRectMake(xAxisForViews, yAxisForViews, viewsSize.width, viewsSize.height);
    
    NSInteger xAxisForReplies = self.viewsLabel.frame.origin.x + viewsSize.width + 30;
    NSInteger yAxisForReplies = self.detailTextLabel.frame.origin.y;
    self.repliesLabel.frame   = 
    CGRectMake(xAxisForReplies, yAxisForReplies, repliesSize.width, repliesSize.height);
    
    [self.viewsIcon setFrame:
     CGRectMake(self.viewsLabel.frame.origin.x - TTSTYLEVAR(forumTableCellStatsSpacing), 
                self.viewsLabel.frame.origin.y, 
                TTSTYLEVAR(forumTableCellStatsImageSize).width, 
                TTSTYLEVAR(forumTableCellStatsImageSize).height)];
    
    [self.repliesIcon setFrame:
     CGRectMake(self.repliesLabel.frame.origin.x - TTSTYLEVAR(forumTableCellStatsSpacing), 
                self.repliesLabel.frame.origin.y + 2,
                TTSTYLEVAR(forumTableCellStatsImageSize).width, 
                TTSTYLEVAR(forumTableCellStatsImageSize).height)];
    
    [self.viewsIcon setImage:TTSTYLEVAR(forumTableCellStatsViewsImage)];
    [self.repliesIcon setImage:TTSTYLEVAR(forumTableCellStatsRepliesImage)];
    
    [self.iconButton setFrame:self.imageView2.frame];
    [self.iconButton setImage:self.imageView2.image forState:UIControlStateNormal];
    [self.iconButton addTarget:self 
                        action:@selector(didSelectIcon)  
              forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.iconButton];
    
//    if (self.inEditMode == 1) {
//        if (self.isCellSelected) {
//            self.checkMarkImage.image = vBStyleImage(@"/threads/selected.png");
//            [self.bgView setImage:nil];
//            [self.bgView setBackgroundColor:[UIColor colorWithRed:255.0 / 255
//                                                            green:255.0 / 255
//                                                             blue:204.0 / 255 
//                                                            alpha:1.0 ]];
//        }
//        
//        else {
//            self.checkMarkImage.image = vBStyleImage(@"/threads/unselected.png");
//            UIImage * bgImage = TTSTYLEVAR(forumTableCellBackground);
//            bgImage = [bgImage stretchableImageWithLeftCapWidth:floorf(bgImage.size.width/2) 
//                                                   topCapHeight:floorf(bgImage.size.height/2)];    
//            [self.bgView setImage:bgImage];
//            
//        }
//    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectIcon {
    UIActionSheet * sheet = [[UIActionSheet alloc] init];
    [sheet addButtonWithTitle:@"Who Posted"];   
    [sheet addButtonWithTitle:@"Stick/Unstick Thread"];
    [sheet addButtonWithTitle:@"Open/Close Thread"];
    [sheet addButtonWithTitle:@"Cancel"];
    [sheet setCancelButtonIndex:3];
    [sheet setDelegate:self];
    [sheet setTag:0];
    [sheet setTitle:self.textLabel.text];
    [sheet showInView:self.contentView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)returnIntFromUrl:(NSString *)url {
    
    // create an NSError object
    NSError * error = NULL;	

    // define the regex expressoin to use, in this case, the first and only integer
    NSRegularExpression *regex = 
        [NSRegularExpression regularExpressionWithPattern:@"[\\w]+(\\d+)" 
                                                  options:NSRegularExpressionCaseInsensitive 
                                                    error:&error];
    
    // see if we found a match
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:url 
                                                         options:0 
                                                           range:NSMakeRange(0, [url length])];
    
    // return the match if found
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSString *substringForFirstMatch = [url substringWithRange:rangeOfFirstMatch];
        return [NSString stringWithFormat:@"%@", substringForFirstMatch];
    }
    
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - UIActionSheetDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // get the thread id
    NSString * threadid  = [self returnIntFromUrl:self.threadItem.URL];
    
    // see who posted
    if (buttonIndex == 0) {
        NSString * url = [NSString stringWithFormat:@"vb://forums/whoposted/%@", threadid];
        [[TTNavigator navigator] openURLAction:
         [[TTURLAction actionWithURLPath:url] applyAnimated:YES]];    
    } 
    
    // stick / unstick thread
    if (buttonIndex == 1) {
        NSString          * url       = [NSString stringWithString:kModeratorUrl];
        TTURLRequest      * request   = [TTURLRequest requestWithURL:url delegate:self];
        TTURLJSONResponse * response  = [[TTURLJSONResponse alloc] init];
                        
        request.response  = response;
        request.cacheExpirationAge = 1;
        
        [request.parameters setValue:threadid forKey:@"threadid"];
        [request.parameters setValue:@"stick" forKey:@"do"];

        [request setHttpMethod:@"POST"];
        [request send];
    } 
    
    // open / close thread
    if (buttonIndex == 2) {
        NSString          * url       = [NSString stringWithString:kModeratorUrl];
        TTURLRequest      * request   = [TTURLRequest requestWithURL:url delegate:self];
        TTURLJSONResponse * response  = [[TTURLJSONResponse alloc] init];
        
        request.response  = response;
        request.cacheExpirationAge = 1;
        
        [request.parameters setValue:self.threadItem.URL forKey:@"url"];
        [request.parameters setValue:@"openclosethread" forKey:@"do"];
        
        [request setHttpMethod:@"POST"];
        [request send];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark - TTURLRequestDelagate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse * response = request.response;
    NSDictionary      * results  = response.rootObject;    
    
    // check for errors
    if ([[results valueForKey:@"hasErrors"] intValue] == 1) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                         message:[results valueForKey:@"errorMsg"]
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil ];
        [alert show]; return;
    }
    
    // reload table after (un)stuck is complete
    if ([request.parameters valueForKey:@"do"] == @"stick") {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadForumsDisplay" 
                                                            object:nil];
    }
    
    // update thread icon after open/close is complete
    if ([request.parameters valueForKey:@"do"] == @"openclosethread") {
        
        NSString * iconPath = [NSString stringWithString:@""];
        
        if ([[results valueForKey:@"sticky"] intValue] == 1) {
            iconPath = @"/threads/sticky_icon.png";
        } else {
            iconPath = [NSString stringWithFormat:@"/threads/thread%@.gif", 
                        [results valueForKey:@"status"]];
        }
        
        [self.imageView2 setAlpha:0.0];
        [self.iconButton setImage:vBStyleImage(iconPath)
                         forState:UIControlStateNormal];
    }
}

@end
