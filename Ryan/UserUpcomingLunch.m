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

- (NSString *)lunchtable_id
{
    return lunchtable_id;
}

- (NSString *)restaurant_id
{
    return restaurant_id;
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

- (void)setLunctable_id:(NSString *)input
{
    lunchtable_id = input;
}

- (void)setRestaurant_id:(NSString *)input
{
    restaurant_id = input;
}
@end
