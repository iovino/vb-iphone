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
#import "ForumDisplayThreadItem.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumDisplayThreadItem

@synthesize views     = _views;
@synthesize replies   = _repies;
@synthesize selected  = _selected;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithTitle:(NSString*)title
             author:(NSString*)author
              views:(NSString*)views 
            replies:(NSString*)replies 
               icon:(UIImage*)icon
                url:(NSString*)url {
    ForumDisplayThreadItem * item = [[self alloc] init];
    item.text         = title;
    item.subtitle     = author;
    item.URL          = url;
    item.defaultImage = icon;
    item.views        = views;
    item.replies      = replies;
    item.selected     = @"0";
    
    return item;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	self = [super initWithCoder:decoder];
    if (self) {
        self.views    = [decoder decodeObjectForKey:@"views"];
        self.replies  = [decoder decodeObjectForKey:@"replies"];
        self.selected = [decoder decodeObjectForKey:@"selected"];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
    [super encodeWithCoder:encoder];
    if (self.views) {
        [encoder encodeObject:self.views forKey:@"views"];
    }
    if (self.replies) {
        [encoder encodeObject:self.replies forKey:@"replies"];
    }
    if (self.selected) {
        [encoder encodeObject:self.selected forKey:@"selected"];
    }
}


@end
