//
//  PastLunch.m
//  Ryan
//
//  Created by William Lutz on 8/4/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
// Class for past SitWith lunches

#import "PastLunch.h"

@implementation PastLunch

// set methods
- (void)setRestaurantName:(NSString *)input
{
    restaurantName = input;
}

- (void)setDate:(NSString *)input
{
    date = input;
}

- (void)setUser1Name:(NSString *)input
{
    user1Name = input;
}

- (void)setUser2Name:(NSString *)input
{
    user2Name = input;
}

- (void)setUser3Name:(NSString *)input
{
    user3Name = input;
}

- (void)setUser4Name:(NSString *)input
{
    user4Name = input;
}

// get methods
- (NSString *)restaurantName
{
    return restaurantName;
}

- (NSString *)date
{
    return date;
}

- (NSString *)user1Name
{
    return user1Name;
}

- (NSString *)user2Name
{
    return user2Name;
}

- (NSString *)user3Name
{
    return user3Name;
}

- (NSString *)user4Name
{
    return user4Name;
}

- (NSString *)user1FirstName
{
    NSString *entireName = [self user1Name];
    NSMutableString *firstName = [NSMutableString stringWithString: @""];
    int nameLength = entireName.length;
    for (int i = 0; i < nameLength; i+= 1) {
        if ([[entireName substringWithRange:NSMakeRange(i,1)] isEqualToString:@" "]) {
            return firstName;
        }
        else
        {
            [firstName appendString:[entireName substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return firstName;
}

- (NSString *)user2FirstName
{
    NSString *entireName = [self user2Name];
    NSMutableString *firstName = [NSMutableString stringWithString: @""];
    int nameLength = entireName.length;
    for (int i = 0; i < nameLength; i+= 1) {
        if ([[entireName substringWithRange:NSMakeRange(i,1)] isEqualToString:@" "]) {
            return firstName;
        }
        else
        {
            [firstName appendString:[entireName substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return firstName;
}

- (NSString *)user3FirstName
{
    NSString *entireName = [self user3Name];
    NSMutableString *firstName = [NSMutableString stringWithString: @""];
    int nameLength = entireName.length;
    for (int i = 0; i < nameLength; i+= 1) {
        if ([[entireName substringWithRange:NSMakeRange(i,1)] isEqualToString:@" "]) {
            return firstName;
        }
        else
        {
            [firstName appendString:[entireName substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return firstName;
}

- (NSString *)user4FirstName
{
    NSString *entireName = [self user4Name];
    NSMutableString *firstName = [NSMutableString stringWithString: @""];
    int nameLength = entireName.length;
    for (int i = 0; i < nameLength; i+= 1) {
        if ([[entireName substringWithRange:NSMakeRange(i,1)] isEqualToString:@" "]) {
            return firstName;
        }
        else
        {
            [firstName appendString:[entireName substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return firstName;
}

@end
