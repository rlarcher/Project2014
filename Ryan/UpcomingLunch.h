//
//  UpcomingLunch.h
//  Ryan
//
//  Created by William Lutz on 8/4/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpcomingLunch : NSObject
{
    NSString *restaurantName;
    NSString *address;
    NSString *hours;
    NSString *picture;
    NSString *date;
    NSString *time;
    NSString *count;
}

// get methods
- (NSString *) restaurantName;

- (NSString *) address;

- (NSString *) hours;

- (NSString *) picture;

- (NSString *)date;

- (NSString *)time;

- (NSString *)count;

// set methods
-(void)setRestaurantName:(NSString *)input;

-(void)setAddress:(NSString *)input;

-(void)setHours:(NSString *)input;

-(void)setPicture:(NSString *)input;

-(void)setDate:(NSString *)input;

-(void)setTime:(NSString *)input;

-(void)setCount:(NSString *)count;

@end
