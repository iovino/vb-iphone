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
#import "ForumHomeDataModel.h"

// Three20's JSON Library
#import <extThree20JSON/extThree20JSON.h>

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumHomeDataModel

@synthesize forums          = _forums;
@synthesize resultsPerPage  = _resultsPerPage;
@synthesize finished        = _finished;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
    if (self) {
        _forums         = [[NSMutableArray alloc] init];
        _resultsPerPage = 10;
        _page           = 1;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading) {
        if (more) {
            _page++;
        }
        else {
            _page = 1;
            _finished = NO;
            [_forums removeAllObjects];
        }
        
        NSString     * url     = [NSString stringWithString:kForumHomeUrl];
        TTURLRequest * request = [TTURLRequest requestWithURL:url delegate:self];

        request.cachePolicy        = cachePolicy;
        request.cacheExpirationAge = DEFAULT_CACHE_EXPIRATION_AGE;
        
        TTURLJSONResponse * response = [[TTURLJSONResponse alloc] init];
        request.response  = response;
        
        [request setHttpMethod:@"GET"];
        [request send];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TTURLRequestDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse * response = request.response;
    NSDictionary      * feed     = response.rootObject;    
    
    NSArray           * items   = [feed valueForKey:@"forums"];    
    NSMutableArray    * preped  = [NSMutableArray arrayWithCapacity:[items count]];
    
    for (NSDictionary * item in items) {
        [preped addObject:item];
    }
    
    _finished = YES;
    [_forums addObjectsFromArray:preped];
    
    [super requestDidFinishLoad:request];
}

@end
