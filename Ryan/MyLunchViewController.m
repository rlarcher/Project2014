//
//  MyLunchViewController.m
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

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
        
        NSString *sampleEmail = @"lippmanj@hotmail.com";
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.191.127.201:8080/SitWithWebServer/getUpcomingRequestTobeProcessedByEmail?email=%@",sampleEmail]];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [parser setDelegate:self];
        BOOL result = [parser parse];
        if(!result) NSLog(@"Oh no that parse thing didn't go so well");
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(elementName);
    if([elementName isEqualToString:@"RequestTobeProcessed"])
    {
        self.currentUpcomingLunch = [[UserUpcomingLunch alloc]init];
    }
    if([elementName isEqualToString:@"lunchtabletime"])
    {
        self.parsingDate = YES;
    }
    if([elementName isEqualToString:@"email"])
    {
        self.parsingEmail = YES;
    }
    if([elementName isEqualToString:@"user name"])
    {
        self.parsingUserName = YES;
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        self.parsingRestaurant = YES;
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"RequestTobeProcessed"])
    {
        [userUpcomingLunchObjects addObject:self.currentUpcomingLunch];
        self.currentUpcomingLunch = nil;
    }
    if([elementName isEqualToString:@"lunchtabletime"])
    {
        self.parsingDate = NO;
    }
    if([elementName isEqualToString:@"email"])
    {
        self.parsingEmail = NO;
    }
    if([elementName isEqualToString:@"user name"])
    {
        self.parsingUserName = NO;
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        self.parsingRestaurant = NO;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
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
        self.lunch = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
        // just leave with no lunches for now
        self.lunch.text = [NSString stringWithFormat:@"%@ %@",[firstUpcomingLunch restaurant],[firstUpcomingLunch date]];
    }
    else
    {
        self.lunch = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
        self.lunch.text = @"You do not have any lunches now";
    }
    [self.lunch setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.lunch];
    
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
    
    self.confirmView = [[UIViewController alloc]init];
    self.confirmView.view.frame = self.view.frame;
    
    self.confirm = [[UIAlertView alloc] initWithTitle:@"Cancel Lunch" message:@"Are you sure you want to remove yourself from this lunch" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    self.confirm.transform = CGAffineTransformMakeTranslation(25, 25);
}

- (void)nextLunch:(UIButton *)sender {
    if([userUpcomingLunchObjects count] != 0)
    {
        self.upcomingLunchIndex += 1;
        if(self.upcomingLunchIndex >= [userUpcomingLunchObjects count]) self.upcomingLunchIndex = 0;
        UserUpcomingLunch *nextUpcomingLunch = userUpcomingLunchObjects[self.upcomingLunchIndex];
        self.lunch.text = [NSString stringWithFormat:@"%@ %@",[nextUpcomingLunch restaurant],[nextUpcomingLunch date]];

    }
}

- (void)confirmRemoveLunch:(UIButton *)sender {
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
