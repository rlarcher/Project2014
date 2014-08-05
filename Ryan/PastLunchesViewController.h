//
//  PastLunchesViewController.h
//  Ryan
//
//  Created by William Lutz on 7/24/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PastLunch.h"

@interface PastLunchesViewController : UIViewController <NSXMLParserDelegate>
@property NSArray *pastLunchArray;
@property (strong,nonatomic) UITextView *lunch;
@property (strong,nonatomic) UIButton *feedback;
@property (strong,nonatomic) UITextView *myText;
@property BOOL foundUser;
@property BOOL parsingUserData;
@property BOOL parsingUserName;
@property NSMutableString *userFromParse;
@property PastLunch *userPastLunch;
@property BOOL parsingRestaurantName;
@property BOOL parsingDate;
@property BOOL parsingUser1;
@property BOOL parsingUser2;
@property BOOL parsingUser3;
@property BOOL parsingUser4;
@property int pastLunchIndex;
@end
