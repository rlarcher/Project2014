//
//  ConfirmAlertViewController.h
//  Ryan
//
//  Created by William Lutz on 8/5/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleAccess.h"

@interface ConfirmAlertViewController : UIViewController <UIAlertViewDelegate, GoogleOAuthDelegate>

@property UIAlertView *confirm;

@property GoogleAccess *googleAccess;

@end
