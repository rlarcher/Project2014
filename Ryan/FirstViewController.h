//
//  FirstViewController.h
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"

@interface FirstViewController : UIViewController <FBLoginViewDelegate>
- (IBAction)showEmail:(id)sender;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIButton *contact;
@property NSMutableString *userFromParse;
@property BOOL parsingUserData;
@property BOOL parsingUserName;
@property BOOL foundUser;
@property BOOL parsingEmail;
@property UIButton *settingsButton;
@property User *currentUser;
@end

@interface LoginUIViewController : UIViewController <FBLoginViewDelegate>
@end