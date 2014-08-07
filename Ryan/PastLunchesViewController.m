//
//  PastLunchesViewController.m
//  Ryan
//
//  Created by William Lutz on 7/24/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "PastLunchesViewController.h"
#import "AppDelegate.h"
#import "MyMailViewController.h"
#import "FirstViewController.h"

@interface PastLunchesViewController ()

@end

@implementation PastLunchesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parsingUserData = false;
        self.foundUser = false;
        self.parsingDate = NO;
        self.parsingRestaurantName = NO;
        self.parsingUser1 = NO;
        self.parsingUser2 = NO;
        self.parsingUser3 = NO;
        self.parsingUser4 = NO;
        self.pastLunchIndex = 0;
        
        // array that will hold user past lunches
        // this will contain objects of type PastLunch
        userPastLunchObjects = [[NSMutableArray alloc]init];
        
        // start the parsing
        //NSString *sampleEmail = @"terryyangty619@gmail.com";
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/getPastTableByUserEmail?email=%@", serverAddress, userEmail]];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [parser setDelegate:self];
        BOOL result = [parser parse];
        if(!result) NSLog(@"Oh no that parse thing didn't go so well");
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Past Lunches";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.pastLunchArray = @[@"Sharp Edge Bistro",@"Harris Grill"];
    
    // create the text view for the guests and add it to the view
    self.myText = [[UITextView alloc]initWithFrame:CGRectMake(10, 40, 200, 150)];
    if([userPastLunchObjects count] > 0)
    {
        // get the initial past lunch object
        PastLunch *firstPastLunch = userPastLunchObjects[self.pastLunchIndex];
        self.myText.text = [NSString stringWithFormat:@"You previously had a lunch at %@ with %@, %@, %@, and %@",[firstPastLunch restaurantName],[firstPastLunch user1FirstName],[firstPastLunch user2FirstName],[firstPastLunch user3FirstName],[firstPastLunch user4FirstName]];
        
        // button to send feedback
        self.feedback = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.feedback.frame = CGRectMake(150, 100, 200, 100);
        [self.feedback setTitle:@"Send Feedback" forState:UIControlStateNormal];
        [self.view addSubview:self.feedback];
        
        // add target to the feedback button
        [self.feedback addTarget:self action:@selector(sendFeedback:) forControlEvents:UIControlEventTouchUpInside];
        
        // button to show the next past lunch
        UIButton *nextPastLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        nextPastLunch.frame = CGRectMake(60, 180, 200, 60);
        [nextPastLunch setTitle:@"Next Past Lunch" forState:UIControlStateNormal];
        [self.view addSubview:nextPastLunch];
        
        // add the target for the next past lunch button
        [nextPastLunch addTarget:self action:@selector(nextLunch:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        self.myText.text = @"You do not have any past lunches";
    }
    self.myText.editable = NO;
    [self.view addSubview:self.myText];
    
}

-(void)sendFeedback:(UIButton *)sender
{
    MyMailViewController *mailViewController = [[MyMailViewController alloc]init];
    [self.navigationController pushViewController:mailViewController animated:YES];
}

-(void)nextLunch:(UIButton *)sender
{
    self.pastLunchIndex += 1;
    if(self.pastLunchIndex >= [userPastLunchObjects count]) self.pastLunchIndex = 0;
    PastLunch *newPastLunch = userPastLunchObjects[self.pastLunchIndex];
    self.myText.text = [NSString stringWithFormat:@"You previously had a lunch at %@ with %@, %@, %@, and %@", [newPastLunch restaurantName],[newPastLunch user1FirstName],[newPastLunch user2FirstName],[newPastLunch user3FirstName],[newPastLunch user4FirstName]];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"LunchTable"])
    {
        self.userPastLunch = [[PastLunch alloc]init];
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        self.parsingRestaurantName = YES;
    }
    if([elementName isEqualToString:@"availablebegintime"])
    {
        self.parsingDate = YES;
    }
    if([elementName isEqualToString:@"aName"])
    {
        self.parsingUser1 = YES;
    }
    if([elementName isEqualToString:@"bName"])
    {
        self.parsingUser2 = YES;
    }
    if([elementName isEqualToString:@"cName"])
    {
        self.parsingUser3 = YES;
    }
    if([elementName isEqualToString:@"dName"])
    {
        self.parsingUser4 = YES;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"LunchTable"])
        {
            [userPastLunchObjects addObject:self.userPastLunch];
            self.userPastLunch = nil;
        }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        self.parsingRestaurantName = NO;
    }
    if([elementName isEqualToString:@"availablebegintime"])
    {
        self.parsingDate = NO;
    }
    if([elementName isEqualToString:@"aName"])
    {
        self.parsingUser1 = NO;
    }
    if([elementName isEqualToString:@"bName"])
    {
        self.parsingUser2 = NO;
    }
    if([elementName isEqualToString:@"cName"])
    {
        self.parsingUser3 = NO;
    }
    if([elementName isEqualToString:@"dName"])
    {
        self.parsingUser4 = NO;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.parsingDate)
    {
        [self.userPastLunch setDate:(NSString *)string];
    }
    if(self.parsingRestaurantName)
    {
        [self.userPastLunch setRestaurantName:(NSString *)string];
    }
    if(self.parsingUser1)
    {
        [self.userPastLunch setUser1Name:(NSString *)string];
    }
    if(self.parsingUser2)
    {
        [self.userPastLunch setUser2Name:(NSString *)string];
    }
    if(self.parsingUser3)
    {
        [self.userPastLunch setUser3Name:(NSString *)string];
    }
    if(self.parsingUser4)
    {
        [self.userPastLunch setUser4Name:(NSString *)string];
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
