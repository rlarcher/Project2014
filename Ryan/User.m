//
//  User.m
//  Ryan
//
//  Created by William Lutz on 8/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize name, email, gender, age;
// get methods
- (NSString *) name
{
    return name;
}

- (NSString *) email {
    return email;
}

- (NSString *) gender
{
    return gender;
}

- (NSString *) age
{
    return age;
}

// set methods
-(void)setName:(NSString *)input
{
    name = input;
}

-(void)setEmail:(NSString *)input
{
    email = input;
}
-(void)setGender:(NSString *)input
{
    gender = input;
}
-(void)setAge:(NSString *)input
{
    age = input;
}

@end
