//
//  MyLunchViewController.h
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PastLunch.h"
#import "UserUpcomingLunch.h"

@interface MyLunchViewController : UIViewController <NSXMLParserDelegate>
@property (strong,nonatomic) UIButton *cancel;
@property (strong,nonatomic) UIButton *next;
@property (strong,nonatomic) UITextView *lunch;
@property (strong,nonatomic) UIAlertView *confirm;
@property (strong,nonatomic) UIViewController *confirmView;
@property UserUpcomingLunch *currentUpcomingLunch;
@property PastLunch *userPastLunch;
@property BOOL parsingUserName;
@property BOOL parsingEmail;
@property BOOL parsingDate;
@property BOOL parsingRestaurant;
@property BOOL parsingRestaurant_id;
@property BOOL parsingLunchtable_id;
@property BOOL parsingRequest_id;
@property int upcomingLunchIndex;
@end
