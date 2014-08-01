//
//  User.h
//  Ryan
//
//  Created by William Lutz on 8/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *name;
    NSString *gender;
    NSString *email;
    NSString *age;
}
// get methods
- (NSString *) name;

- (NSString *) email;

- (NSString *) gender;

- (NSString *) age;

// set methods
-(void)setName:(NSString *)input;

-(void)setEmail:(NSString *)input;

-(void)setGender:(NSString *)input;

-(void)setAge:(NSString *)input;

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *gender;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *age;
@end
