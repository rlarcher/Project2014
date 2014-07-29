//
//  PastLunchesViewController.m
//  Ryan
//
//  Created by William Lutz on 7/24/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "PastLunchesViewController.h"
#import "AppDelegate.h"

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
    
    // past lunch text
    self.lunch = [[UITextView alloc]initWithFrame:CGRectMake(10, 30, 150, 100)];
    [self.lunch setBackgroundColor:[UIColor whiteColor]];
    self.lunch.text = self.pastLunchArray[0];
    [self.view addSubview:self.lunch];
    
    self.feedback = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.feedback.frame = CGRectMake(150, 60, 200, 100);
    [self.feedback setTitle:@"Send Feedback" forState:UIControlStateNormal];
    [self.view addSubview:self.feedback];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.logarun.com/xml.ashx?username=ryan.archer&type=view"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    BOOL result = [parser parse];
    if(!result) NSLog(@"Oops the parse didn't work :(");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"Did start element");
    if([elementName isEqualToString:@"user"])
    {
        self.parsingUserData = true;
        return;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"Did end element");
    if([elementName isEqualToString:@"name"])
    {
        // let app know that it is between name tags
        self.parsingUserData = YES;
        // this checks to see if user is in the xml table
        if([self.userFromParse isEqualToString:userName])
        {
            self.foundUser = YES;
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.parsingUserData)
    {
        // add the found characters to the parsed UserName
        // this only occurs for string between xml name tags
        [self.userFromParse appendString:string];
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
