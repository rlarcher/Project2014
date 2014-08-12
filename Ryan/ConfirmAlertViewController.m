//
//  ConfirmAlertViewController.m
//  Ryan
//
//  Created by William Lutz on 8/5/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

// When user signs up for an already existing lunch

#import "ConfirmAlertViewController.h"
#import "AppDelegate.h"
#import <EventKit/EventKit.h>

@interface ConfirmAlertViewController ()

@end

@implementation ConfirmAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.confirm = [[UIAlertView alloc] initWithTitle:@"Confirm lunch and add to calendar?" message:
                              [NSString stringWithFormat:@"Confirm lunch for %@? ", lunchDateAndTime] delegate:self cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes",nil];
        [self.confirm show];
        
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        // user clicked no
        [self.navigationController popViewControllerAnimated:YES];
        // do nothing because user said NO!
    }
    if(buttonIndex == 1)
    {
        // user clicked yes
        
        // get the strings from the UpcomingLunch object to use in the url
        NSString *lunchtable_id = [signUpLunch lunchtable_id];
        NSString *restaurant_id = [signUpLunch restaurant_id];
        NSString *restaurant_name = [signUpLunch restaurantName];
        NSString *user_name = userName;
        NSString *oldlunchtabletime = [signUpLunch time];
        NSString *email = userEmail;
        
        NSString *lunchtabletime = [oldlunchtabletime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // get rid of space in user name
        NSMutableString *newUserName = [[NSMutableString alloc]init];
        for (int i = 0; i < [user_name length]; i++) {
            if(![[user_name substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
            {
                newUserName = (NSMutableString *)[NSString stringWithFormat:@"%@%@",newUserName,[user_name substringWithRange:NSMakeRange(i, 1)]];
            }
        }
        user_name = (NSString *)newUserName;
        
        // get rid of space in restaurant name
        NSMutableString *newRestaurantName = [[NSMutableString alloc]init];
        for (int i = 0; i < [restaurant_name length]; i++) {
            if(![[restaurant_name substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
            {
                newRestaurantName = (NSMutableString *)[NSString stringWithFormat:@"%@%@",newRestaurantName,[restaurant_name substringWithRange:NSMakeRange(i, 1)]];
            }
        }
        restaurant_name = (NSString *)newRestaurantName;
        
        // add the user to the lunch
        // here is the base url SitWithWebServer/addRequestTobeProcessed?lunchtable_id=& restaurant_id=& restaurant_name= &email= &user_name= &lunchtabletime=
        
        NSString *lunchtime = [lunchtabletime stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        lunchtabletime = [NSString stringWithFormat:@"%@:00.0",lunchtime];
        NSString *serverurl = [NSString stringWithFormat:@"%@/addRequestTobeProcessed?lunchtable_id=%@&restaurant_id=%@&restaurant_name=%@&email=%@&user_name=%@&lunchtabletime=%@",serverAddress,lunchtable_id,restaurant_id,restaurant_name,email,user_name,lunchtime];
        NSURL *url = [NSURL URLWithString:serverurl];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@",lunchtable_id,restaurant_id,restaurant_name,email,user_name,lunchtime);
        [parser parse];
        EKEventStore *store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = @"SitWith Lunch";
            event.startDate = chosenDate; //today
            event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
            [event setCalendar:[store defaultCalendarForNewEvents]];
            NSError *err = nil;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
        }];
        // go back to previous view
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // here is the google stuff so it can easily be removed
    self.googleAccess = [[GoogleAccess alloc] initWithFrame:self.view.frame];
    [self.googleAccess setGOAuthDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
