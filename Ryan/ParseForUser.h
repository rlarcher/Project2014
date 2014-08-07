//
//  ParseForUser.h
//  Ryan
//
//  Created by William Lutz on 8/6/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ParseForUser : NSObject<NSXMLParserDelegate>

// bool that represents whether or not parser is inside a user tag
@property BOOL parsingUserName;
// bool that represents whether or not parser found user based on the login
// name from facebook
@property BOOL foundUserName;

// function to search for user
- (BOOL)searchForUser;

@end
