//
//  RegisterViewController.h
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleAccess.h"

@interface RegisterViewController : UIViewController <GoogleOAuthDelegate>
@property UILabel *restaurant;
@property UIAlertView *alertConfirm;
@property NSString *myDate;
@property GoogleAccess *googleAccess;
@property NSDictionary *dictCurrentCalendar;
@property NSMutableArray *arrGoogleCalendars;

@end
