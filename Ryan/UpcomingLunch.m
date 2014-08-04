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

@end
