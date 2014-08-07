//
//  User.m
//  Ryan
//
//  Created by William Lutz on 8/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
// Class for SitWith users

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

- (NSString *) firstName
{
    NSString *entireName = [self name];
    NSMutableString *firstName = (NSMutableString *)@"";
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
