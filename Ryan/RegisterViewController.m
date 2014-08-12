//
//  RegisterViewController.m
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
// When user creates a lunch

#import "FirstViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "SecondViewController.h"
#import <EventKit/EventKit.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // allocate dateformatter in order to get string from nsdate
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:chosenDate];
    _arrGoogleCalendars = [[NSMutableArray alloc]init];
    _dictCurrentCalendar = [[NSDictionary alloc]init];
    long year = [components year];
    int month = [components month];
    int day = [components day];

    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm:ss"];
    // chosenDate is global that holds date selected by user in previous viewcontroller
    self.myDate = [NSString stringWithFormat:@"%ld-%02d-%02d %@",year,month,day,[df stringFromDate:chosenDate]];
    
    // add the label with the restaurant name
    self.restaurant = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 300, 150)];
    self.restaurant.numberOfLines = 0;
    self.restaurant.text = [NSString stringWithFormat:@"Make a lunch at %@ \n on %@?",chosenRestaurant,self.myDate];
    [self.view addSubview:self.restaurant];
    
    // button to confirm created lunch
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirm.frame = CGRectMake(60, 200, 150, 100);
    [confirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.view addSubview:confirm];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    add.frame = CGRectMake(20, 250, 250, 100);
    [add setTitle:@"Add to Calendar" forState:UIControlStateNormal];
    [self.view addSubview:add];
    
    [add addTarget:self action:@selector(addCalendar:) forControlEvents:UIControlEventTouchUpInside];
    
    // alert that is shown after user presses confirm
    self.alertConfirm = [[UIAlertView alloc] initWithTitle:nil message:@"Thank you for using SitWith" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [confirm addTarget:self action:@selector(confirmed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addCalendar:(UIButton *)sender {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:chosenDate];
    long day = (long)[components day];
    long month = (long)[components month];
    long year = (long)[components year];
    NSString *googleurl = [NSString stringWithFormat:@"https://www.google.com/calendar/render?tab=mc&date=%ld%02ld%02ld",year,month,day];
    NSURL *url = [NSURL URLWithString:googleurl];
    //[[ UIApplication sharedApplication]openURL:url];
    /*
    self.googleAccess = [[GoogleAccess alloc] initWithFrame:self.view.frame];
    [self.googleAccess setGOAuthDelegate:self];
    
    [self.googleAccess authorizeUserWithClientID:@"408023889507-caigg2ccaf341i1275an6lof3an1og1h.apps.googleusercontent.com"
                           andClientSecret:@"yhwtMACOVUcFL4BbiQMDIcRW"
                             andParentView:self.view
                                 andScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/userinfo.profile", nil]
     ];
    NSString *apiURLString = [NSString stringWithFormat:@"https://www.googleapis.com/calendar/v3/calendars/%@/events/quickAdd",
                              [_dictCurrentCalendar objectForKey:@"id"]];
    
    NSString *lunchText = @"This is an event 08/31/2014";
    
    [self.googleAccess callAPI:apiURLString
           withHttpMethod:httpMethod_POST
       postParameterNames:[NSArray arrayWithObjects:@"calendarId", @"text", nil]
      postParameterValues:[NSArray arrayWithObjects:[_dictCurrentCalendar objectForKey:@"id"], lunchText, nil]];
    */
    
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
    
}

-(void)authorizationWasSuccessful{
    // If user authorization is successful, then make an API call to get the calendar list.
    // For more infomation about this API call, visit:
    // https://developers.google.com/google-apps/calendar/v3/reference/calendarList/list
    [self.googleAccess callAPI:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
           withHttpMethod:httpMethod_GET
       postParameterNames:nil
      postParameterValues:nil];
    NSLog(@"success");
}

-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData{
    NSError *error;
    
    if ([responseJSONAsString rangeOfString:@"calendarList"].location != NSNotFound) {
        // If the response from Google contains the "calendarList" literal, then the calendar list
        // has been downloaded.
        NSLog(@"Calendar has been downloaded");
        // Get the JSON data as a dictionary.
        NSDictionary *calendarInfoDict = [NSJSONSerialization JSONObjectWithData:responseJSONAsData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            // This is the case that an error occured during converting JSON data to dictionary.
            // Simply log the error description.
            NSLog(@"%@", [error localizedDescription]);
        }
        else{
            // Get the calendars info as an array.
            NSArray *calendarsInfo = [calendarInfoDict objectForKey:@"items"];
            
            // If the arrGoogleCalendars array is nil then initialize it so to store each calendar as a NSDictionary object.
            if (_arrGoogleCalendars == nil) {
                _arrGoogleCalendars = [[NSMutableArray alloc] init];
            }
            
            // Make a loop and get the next data of each calendar.
            for (int i=0; i<[calendarsInfo count]; i++) {
                // Store each calendar in a temporary dictionary.
                NSDictionary *currentCalDict = [calendarsInfo objectAtIndex:i];
                
                
                // Create an array which contains only the desired data.
                NSArray *values = [NSArray arrayWithObjects:[currentCalDict objectForKey:@"id"],
                                   [currentCalDict objectForKey:@"summary"],
                                   nil];
                // Create an array with keys regarding the values on the previous array.
                NSArray *keys = [NSArray arrayWithObjects:@"id", @"summary", nil];
                
                // Add key-value pairs in a dictionary and then add this dictionary into the arrGoogleCalendars array.
                [_arrGoogleCalendars addObject:
                 [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys]];
            }
            
            // Set the first calendar as the selected one.
            _dictCurrentCalendar = [[NSDictionary alloc] initWithDictionary:[_arrGoogleCalendars objectAtIndex:0]];
        }
    }
}

-(void)accessTokenWasRevoked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Your access was revoked!"
                                                   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)revokeAccess:(id)sender {
    [self.googleAccess revokeAccessToken];
}

-(void)errorOccuredWithShortDescription:(NSString *)errorShortDescription andErrorDetails:(NSString *)errorDetails{
    NSLog(@"%@", errorShortDescription);
    NSLog(@"%@", errorDetails);
}


-(void)errorInResponseWithBody:(NSString *)errorMessage{
    NSLog(@"%@", errorMessage);
}

- (void)confirmed:(UIButton *)sender {
    // user pressed confirm so make lunch with server
    // base url SitWithWebServer/createLunchTableWithJoin?availablebegintime= &restaurant_id= &restaurant_name= &email= &user_name=
    // strings to use in url to make lunch
    //NSDateFormatter *df = [[NSDateFormatter alloc]init];
    // NSString *oldavailablebegintime = [df stringFromDate:chosenDate];
    NSString *restaurant_id = [selectedMakeRestaurant restaurant_id];
    NSString *restaurant_name = [selectedMakeRestaurant name];
    NSString *email = userEmail;
    NSString *user_name = userName;
    
    NSString *availablebegintime = self.myDate;
    // get rid of space in user name
    NSMutableString *newString = [[NSMutableString alloc]init];
    for (int i = 0; i < [user_name length]; i++) {
        if(![[user_name substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
        {
            newString = (NSMutableString *)[NSString stringWithFormat:@"%@%@",newString,[user_name substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    // get rid of space in restaurant name
    NSMutableString *newRestString = [[NSMutableString alloc]init];
    for (int i = 0; i < [restaurant_name length]; i++) {
        if(![[restaurant_name substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
        {
            newRestString = (NSMutableString *)[NSString stringWithFormat:@"%@%@",newRestString,[restaurant_name substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    // get rid of space in date
    NSString *newDate = [NSString stringWithFormat:@"%@.0",availablebegintime];

    availablebegintime = [newDate stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    user_name = (NSString *)newString;
    restaurant_name = (NSString *)newRestString;
    NSString *url = [NSString stringWithFormat:@"%@/createLunchTableWithJoin?availablebegintime=%@&restaurant_id=%@&restaurant_name=%@&email=%@&user_name=%@",serverAddress,availablebegintime,restaurant_id,restaurant_name,email,user_name];
    NSURL *serverUrl = [NSURL URLWithString:url];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:serverUrl];
    [parser parse];
    // show alert and change the view
    [self.alertConfirm show];
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
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
