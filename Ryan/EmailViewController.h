//
//  EmailViewController.h
//  Ryan
//
//  Created by William Lutz on 7/28/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SimpleEmailViewController : UIViewController <MFMailComposeViewControllerDelegate> 
- (IBAction)showEmail:(id)sender;
@end
