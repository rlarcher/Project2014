//
//  UserUpcomingLunch.h
//  Ryan
//
//  Created by William Lutz on 8/5/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserUpcomingLunch : NSObject
{
    NSString *userName;
    NSString *email;
    NSString *restaurant;
    NSString *date;
}

// get methods
- (NSString *)userName;

- (NSString *)email;

- (NSString *)restaurant;

- (NSString *)date;

// set methods
- (void)setUserName:(NSString *)input;

- (void)setEmail:(NSString *)input;

- (void)setRestaurant:(NSString *)input;

- (void)setDate:(NSString *)input;
@end
