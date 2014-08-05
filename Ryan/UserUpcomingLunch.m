//
//  UserUpcomingLunch.m
//  Ryan
//
//  Created by William Lutz on 8/5/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "UserUpcomingLunch.h"

@implementation UserUpcomingLunch

// get methods
- (NSString *)userName;
{
    return userName;
}

- (NSString *)email
{
    return email;
}

- (NSString *)restaurant
{
    return restaurant;
}

- (NSString *)date
{
    return date;
}

// set methods
- (void)setUserName:(NSString *)input
{
    userName = input;
}

- (void)setEmail:(NSString *)input
{
    email = input;
}
- (void)setRestaurant:(NSString *)input
{
    restaurant = input;
}

- (void)setDate:(NSString *)input
{
    date = input;
}

@end
