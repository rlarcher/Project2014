//
//  Restaurant.h
//  Ryan
//
//  Created by William Lutz on 8/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
{
    NSString *name;
    NSString *address;
    NSString *hours;
    NSString *picture;
    NSString *restaurant_id;
}

// get methods
- (NSString *) name;

- (NSString *) address;

- (NSString *) hours;

- (NSString *) picture;

- (NSString *) restaurant_id;

// set methods
-(void)setName:(NSString *)input;

-(void)setAddress:(NSString *)input;

-(void)setHours:(NSString *)input;

-(void)setPicture:(NSString *)input;

-(void)setRestaurant_id:(NSString *)input;

@end
