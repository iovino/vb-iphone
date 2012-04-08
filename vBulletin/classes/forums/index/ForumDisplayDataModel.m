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
#import "ForumDisplayDataModel.h"

// Three20's JSON Library
#import <extThree20JSON/extThree20JSON.h>

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ForumDisplayDataModel

@synthesize forumid        = _forumid;
@synthesize foruminfo      = _foruminfo;
@synthesize subforums      = _subforums;
@synthesize threads        = _threads;
@synthesize announcements  = _announcements;
@synthesize resultsPerPage = _resultsPerPage;
@synthesize finished       = _finished;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithForumId:(NSString *)forumId {
    
    self = [super init];
    
	if (self) {
        self.forumid    = forumId;
        _subforums      = [[NSMutableArray alloc] init];
        _announcements  = [[NSMutableArray alloc] init];
        _threads        = [[NSMutableArray alloc] init];
        _resultsPerPage = 25;
        _page           = 1;
        _foruminfo      = [[NSDictionary alloc] init];
        
	}
	
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading && TTIsStringWithAnyText(_forumid)) 
    {
        if (more) {
            _page++;
        }
        else {
            _page     = 1;
            _finished = NO;
            
            [_subforums removeAllObjects];
            [_announcements removeAllObjects];
            [_threads removeAllObjects];
            
        }
        
        NSString     * url     = [NSString stringWithFormat:kForumDisplayUrl, _forumid, _page];
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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse * response     = request.response;
    NSDictionary      * responseData = response.rootObject;    
    
    // sub-forum bits
    NSArray           * forums     = [responseData valueForKey:@"forums"];    
    NSMutableArray    * forumItems = [NSMutableArray arrayWithCapacity:[forums count]];
    
    if ([forums count] > 0) {
        for (NSDictionary * forum in forums) {
            [forumItems addObject:forum];
        }
        
        [_subforums addObjectsFromArray:forumItems];
    }
    
    // announcement bits
    NSArray           * announce      = [responseData valueForKey:@"announcements"];    
    NSMutableArray    * announceItems = [NSMutableArray arrayWithCapacity:[announce count]];
    
    if ([announce count] > 0) {
        for (NSDictionary * thread in announce) {
            [announceItems addObject:announce];
        }
        
        [_announcements addObjectsFromArray:announceItems];
    }
    
    // thread bits
    NSArray           * threads     = [responseData valueForKey:@"threads"];    
    NSMutableArray    * threadItems = [NSMutableArray arrayWithCapacity:[threads count]];
    
    if ([threads count] > 0) {
        for (NSDictionary * thread in threads) {
            [threadItems addObject:thread];
        }
        
        [_threads addObjectsFromArray:threadItems];
    }
    
    // memory leak
    _foruminfo = [[NSDictionary alloc] initWithDictionary:[responseData valueForKey:@"foruminfo"]];
    _finished  = threadItems.count < _resultsPerPage;    
    
    [super requestDidFinishLoad:request];
}

@end
