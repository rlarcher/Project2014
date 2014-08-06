//
//  Restaurant.m
//  Ryan
//
//  Created by William Lutz on 8/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

// get methods
- (NSString *) name
{
    return name;
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

- (NSString *)restaurant_id
{
    return restaurant_id;
}

// set methods
-(void)setName:(NSString *)input
{
    name = input;
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

-(void)setRestaurant_id:(NSString *)input
{
    restaurant_id = input;
}

@end
