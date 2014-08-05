//
//  PastLunch.h
//  Ryan
//
//  Created by William Lutz on 8/4/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PastLunch : NSObject
{
    NSString *restaurantName;
    NSString *date;
    NSString *user1Name;
    NSString *user2Name;
    NSString *user3Name;
    NSString *user4Name;
}

// set methods
- (void)setRestaurantName:(NSString *)input;

- (void)setDate:(NSString *)input;

- (void)setUser1Name:(NSString *)input;

- (void)setUser2Name:(NSString *)input;

- (void)setUser3Name:(NSString *)input;

- (void)setUser4Name:(NSString *)input;


// get methods
- (NSString *)restaurantName;

- (NSString *)date;

- (NSString *)user1Name;

- (NSString *)user2Name;

- (NSString *)user3Name;

- (NSString *)user4Name;

- (NSString *)user1FirstName;

- (NSString *)user2FirstName;

- (NSString *)user3FirstName;

- (NSString *)user4FirstName;

@end
