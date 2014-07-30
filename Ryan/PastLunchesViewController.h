//
//  PastLunchesViewController.h
//  Ryan
//
//  Created by William Lutz on 7/24/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastLunchesViewController : UIViewController <NSXMLParserDelegate>
@property NSArray *pastLunchArray;
@property (strong,nonatomic) UITextView *lunch;
@property (strong,nonatomic) UIButton *feedback;
@property BOOL foundUser;
@property BOOL parsingUserData;
@property BOOL parsingUserName;
@property NSMutableString *userFromParse;
@end
