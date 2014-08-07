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

@property BOOL parsingUserName;
@property BOOL foundUserName;

- (BOOL)searchForUser;

@end
