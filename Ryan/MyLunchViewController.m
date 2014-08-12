//
//  MyLunchViewController.m
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
// View Controller for User looking through past lunches
// that he/she attended

#import "MyLunchViewController.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "PastLunch.h"
#import "UserUpcomingLunch.h"

@interface MyLunchViewController ()

@end

@implementation MyLunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parsingDate = NO;
        self.parsingEmail = NO;
        self.parsingRestaurant = NO;
        self.parsingUserName = NO;
        self.upcomingLunchIndex = 0;
        userUpcomingLunchObjects = [[NSMutableArray alloc]init];
        
        NSString *theEmail = userEmail;
        // for now this is a sample email but it will eventually be the line of code below
        
        // NSString *theEmail = userEmail;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/getUpcomingRequestTobeProcessedByEmail?email=%@",serverAddress,theEmail]];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [parser setDelegate:self];
        BOOL result = [parser parse];
        if(!result) NSLog(@"Oh no that parse thing didn't go so well :(");
    }
    return self;
}

// Parsing Methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // create new upcoming lunch object
    if([elementName isEqualToString:@"RequestTobeProcessed"])
    {
        self.currentUpcomingLunch = [[UserUpcomingLunch alloc]init];
    }
    // set booleans based on tags
    if([elementName isEqualToString:@"lunchtabletime"])
    {
        self.parsingDate = YES;
    }
    if([elementName isEqualToString:@"email"])
    {
        self.parsingEmail = YES;
    }
    if([elementName isEqualToString:@"user_name"])
    {
        self.parsingUserName = YES;
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        self.parsingRestaurant = YES;
    }
    if([elementName isEqualToString:@"id"])
    {
        self.parsingLunchtable_id = YES;
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        self.parsingRestaurant_id = YES;
    }
    if([elementName isEqualToString:@"id"])
    {
        self.parsingRequest_id = YES;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // add the current object to the array of upcoming lunch objects
    if([elementName isEqualToString:@"RequestTobeProcessed"])
    {
        [userUpcomingLunchObjects addObject:self.currentUpcomingLunch];
        self.currentUpcomingLunch = nil;
    }
    // set booleans at the end of each tag
    if([elementName isEqualToString:@"lunchtabletime"])
    {
        self.parsingDate = NO;
    }
    if([elementName isEqualToString:@"email"])
    {
        self.parsingEmail = NO;
    }
    if([elementName isEqualToString:@"user_name"])
    {
        self.parsingUserName = NO;
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        self.parsingRestaurant = NO;
    }
    if([elementName isEqualToString:@"lunchtable_id"])
    {
        self.parsingLunchtable_id = NO;
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        self.parsingRestaurant_id = NO;
    }
    if([elementName isEqualToString:@"id"])
    {
        self.parsingRequest_id = NO;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // booleans will determine which tag the parser is inside
    if(self.parsingDate)
    {
        [self.currentUpcomingLunch setDate:(NSString *)string];
    }
    if(self.parsingEmail)
    {
        [self.currentUpcomingLunch setEmail:(NSString *)string];
    }
    if(self.parsingRestaurant)
    {
        [self.currentUpcomingLunch setRestaurant:(NSString *)string];
    }
    if(self.parsingUserName)
    {
        [self.currentUpcomingLunch setUserName:(NSString *)string];
    }
    if(self.parsingRestaurant_id)
    {
        [self.currentUpcomingLunch setRestaurant_id:(NSString *)string];
    }
    if(self.parsingLunchtable_id)
    {
        [self.currentUpcomingLunch setLunctable_id:(NSString *)string];
    }
    if(self.parsingRequest_id)
    {
        [self.currentUpcomingLunch setRequesttobeprocessed_id:(NSString *)string];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Current Lunches";
    [self.view setBackgroundColor:[UIColor whiteColor]];

    // get first upcoming lunch object
    if([userUpcomingLunchObjects count] > 0)
    {
        UserUpcomingLunch *firstUpcomingLunch = userUpcomingLunchObjects[self.upcomingLunchIndex];
        self.lunch = [[UITextView alloc] initWithFrame:CGRectMake(20, 80, 140, 60)];
        // just leave with no lunches for now
        self.lunch.text = [NSString stringWithFormat:@"%@ %@",[firstUpcomingLunch restaurant],[firstUpcomingLunch date]];
        
        self.cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.cancel.frame = CGRectMake(210, 60, 100, 100);
        [self.cancel setTitle:@"Cancel Lunch" forState:UIControlStateNormal];
        [self.cancel addTarget:self action:@selector(confirmRemoveLunch:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.cancel];
        
        // button to see next upcoming lunch
        self.next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.next.frame = CGRectMake(40, 150, 250, 40);
        [self.next setTitle:@"Next Upcoming Lunch" forState:UIControlStateNormal];
        [self.view addSubview:self.next];
        
        // target for next button
        [self.next addTarget:self action:@selector(nextLunch:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        self.lunch = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
        self.lunch.text = @"You do not have any lunches now";
    }
    [self.lunch setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.lunch];

    self.confirmView = [[UIViewController alloc]init];
    self.confirmView.view.frame = self.view.frame;
    
    self.confirm = [[UIAlertView alloc] initWithTitle:@"Cancel Lunch" message:@"You have been removed from this lunch" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    self.confirm.transform = CGAffineTransformMakeTranslation(25, 25);
}

- (void)nextLunch:(UIButton *)sender {
    // this will scroll through the user's upcoming lunches
    
    // make sure the user has some upcoming lunches
    if([userUpcomingLunchObjects count] != 0)
    {
        self.upcomingLunchIndex += 1;
        // wrap-around when user reaches last lunch
        if(self.upcomingLunchIndex >= [userUpcomingLunchObjects count]) self.upcomingLunchIndex = 0;
        UserUpcomingLunch *nextUpcomingLunch = userUpcomingLunchObjects[self.upcomingLunchIndex];
        self.lunch.text = [NSString stringWithFormat:@"%@ %@",[nextUpcomingLunch restaurant],[nextUpcomingLunch date]];

    }
}

- (void)confirmRemoveLunch:(UIButton *)sender {
    //SitWithWebServer/deleteRequesttobeprocessed?requesttobeprocessed_id= &lunchtable_id= &email=
    UserUpcomingLunch *currentUpcomingLunch = userUpcomingLunchObjects[self.upcomingLunchIndex];
    NSString *requesttobeprocessed_id = [currentUpcomingLunch requesttobeprocessed_id];
    NSString *lunchtable_id = [currentUpcomingLunch lunchtable_id];
    NSString *email = [currentUpcomingLunch email];
    NSString *fullUrl = [NSString stringWithFormat:@"%@/deleteRequesttobeprocessed?requesttobeprocessed_id=%@&lunchtable_id=%@&email=%@",serverAddress,requesttobeprocessed_id,lunchtable_id,email];
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser parse];
    [self.confirm show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self.lunch removeFromSuperview];
        [self.cancel removeFromSuperview];
    }
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
