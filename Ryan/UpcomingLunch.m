//
//  UpcomingLunch.m
//  Ryan
//
//  Created by William Lutz on 8/4/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "UpcomingLunch.h"

@implementation UpcomingLunch

// get methods
- (NSString *) restaurantName
{
    return restaurantName;
}

- (NSString *) address
{
    return address;
}

- (NSString *) hours
{
    return hours;
}

- (NSString *) picture
{
    return picture;
}

- (NSString *)date
{
    return date;
}

- (NSString *)time
{
    return time;
}

- (NSString *)count
{
    return count;
}

- (NSString *)lunchtable_id
{
    return lunchtable_id;
}

- (NSString *)restaurant_id
{
    return restaurant_id;
}

- (NSString *)lunchtabletime
{
    return lunchtabletime;
}

// set methods
-(void)setRestaurantName:(NSString *)input
{
    restaurantName = input;
}
-(void)setAddress:(NSString *)input
{
    address = input;
}

-(void)setHours:(NSString *)input
{
    hours = input;
}
-(void)setPicture:(NSString *)input
{
    picture = input;
}

-(void)setDate:(NSString *)input
{
    date = input;
}
-(void)setTime:(NSString *)input
{
    time = input;
}
-(void)setCount:(NSString *)input
{
    count = input;
}

-(void)setLunchtable_id:(NSString *)input
{
    lunchtable_id = input;
}

-(void)setRestaurant_id:(NSString *)input
{
    restaurant_id = input;
}

-(void)setLunchtabletime:(NSString *)input
{
    lunchtabletime = input;
}

@end
