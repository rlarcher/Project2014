//
//  ThirdViewController.m
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "Restaurant.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Create a Lunch";
        self.view.backgroundColor = [UIColor whiteColor];
        
        // init globals
        selectedMakeRestaurant = [[Restaurant alloc]init];
        restaurantObjects = [[NSMutableArray alloc]init];
        
        // set parsing booleans false
        self.parsingAddress = NO;
        self.parsingHours = NO;
        self.parsingName = NO;
        self.parsingPicture = NO;
        self.parsingRestaurant_id = NO;
        
        NSString *server = [NSString stringWithFormat:@"%@/getRestaurants",serverAddress];
        NSURL *url = [NSURL URLWithString:server];
        NSData *xmlData = [NSData dataWithContentsOfURL:url];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:xmlData];
        [parser setDelegate:self];
        BOOL result = [parser parse];
        if(!result) NSLog(@"Oh no that parse thing didn't go so well");
        
        // tell them to choose a location
        self.choose = [[UILabel alloc] initWithFrame:CGRectMake(60, 65, 350, 30)];
        self.choose.text = @"Choose a location and time";
        [self.view addSubview:self.choose];
        
        self.instructions = [[UITextView alloc]initWithFrame:CGRectMake(10, 90, 400, 40)];
        self.instructions.text = @"Swipe left for next restaurant and right to make lunch";
        [self.view addSubview:self.instructions];
        
    }
    return self;
}

// function called when parser reaches the beginning of an element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"Restaurant"])
    {
        self.currentRestaurant = [[Restaurant alloc] init];
    }
    if([elementName isEqualToString:@"name"])
    {
        self.parsingName = YES;
    }
    if([elementName isEqualToString:@"address"])
    {
        self.parsingAddress = YES;
    }
    if([elementName isEqualToString:@"hours"])
    {
        self.parsingHours = YES;
    }
    if([elementName isEqualToString:@"picture"])
    {
        self.parsingPicture = YES;
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        self.parsingRestaurant_id = YES;
    }
}

// parser reached the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"Restaurant"])
    {
        [restaurantObjects addObject:self.currentRestaurant];
        self.currentRestaurant = nil;
        
    }
    if([elementName isEqualToString:@"name"])
    {
        self.parsingName = NO;
    }
    if([elementName isEqualToString:@"address"])
    {
        self.parsingAddress = NO;
    }
    if([elementName isEqualToString:@"hours"])
    {
        self.parsingHours = NO;
    }
    if([elementName isEqualToString:@"picture"])
    {
        self.parsingPicture = NO;
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        self.parsingRestaurant_id = NO;
    }
}

// this handles the characters between the XML tags
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.parsingAddress)
    {
        [self.currentRestaurant setAddress:string];
    }
    if(self.parsingHours)
    {
        [self.currentRestaurant setHours:string];
    }
    if(self.parsingName)
    {
        [self.currentRestaurant setName:string];
    }
    if(self.parsingPicture)
    {
        [self.currentRestaurant setPicture:string];
    }
    if(self.parsingRestaurant_id)
    {
        [self.currentRestaurant setRestaurant_id:string];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Make Lunch";
    self.restaurantIndex = 0;

    // get the first restaurant object for initial display
    Restaurant *firstRestaurant = restaurantObjects[self.restaurantIndex];
    
    // display the lunch picture
    UIImage *firstLunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[firstRestaurant picture]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [firstLunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.lunchPicture = [[UIImageView alloc] initWithImage:resizedImage];
    [self.lunchPicture setContentMode:UIViewContentModeScaleAspectFit];
    self.lunchPicture.frame = CGRectOffset(self.lunchPicture.frame, self.view.center.x-(self.lunchPicture.frame.size.width/2), 100);
    [self.view addSubview:self.lunchPicture];
    
    // restaurant name
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.locationName = [[UITextView alloc]initWithFrame:CGRectMake(0, 340, screenWidth, 50)];
    [self.locationName setText:[firstRestaurant name]];
    [self.locationName setBackgroundColor:[UIColor whiteColor]];
    self.locationName.editable = NO;
    self.locationName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.locationName];
    
    
    // restaurant address
    self.address = [[UITextView alloc] initWithFrame:CGRectMake(0, 370,screenWidth, 40)];
    [self.address setText:[firstRestaurant address]];
    [self.address setBackgroundColor:[UIColor whiteColor]];
    self.address.editable = NO;
    self.address.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.address];
    
    // button for next restaurant
    self.nextRestaurant = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.nextRestaurant.frame = CGRectMake(0, 300, screenWidth/2, 50);
    [self.nextRestaurant setTitle:@"Next Restaurant" forState:UIControlStateNormal];
    [self.view addSubview:self.nextRestaurant];
    
    // add target for next button
    [self.nextRestaurant addTarget:self action:@selector(changeRestaurant:) forControlEvents:UIControlEventTouchUpInside];
    
    self.chooseRestaurant = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.chooseRestaurant.frame = CGRectMake(screenWidth / 2, 300, screenWidth / 2, 50);
    [self.chooseRestaurant setTitle:@"Make Lunch" forState:UIControlStateNormal];
    [self.view addSubview:self.chooseRestaurant];
    
    // add target for choose restaurant
    [self.chooseRestaurant addTarget:self action:@selector(makeLunch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // date picker for the user to select the date and time
    self.dateAndTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 390, 300, 40)];
    self.dateAndTime.datePickerMode = UIDatePickerModeDateAndTime;
    self.dateAndTime.hidden = NO;
    self.dateAndTime.minuteInterval = 30;
    
    // get current date
    NSDate *date = [NSDate date];
    // initialize a calendar
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    // get components of current date
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    // keep the date but change the time to 11:00
    [components setHour: 11];
    [components setMinute: 0];
    [components setSecond: 0];
    NSDate *newDate = [gregorian dateFromComponents: components];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    
    // add two weeks to current date and make it the minimum date available
    dayComponent.day = 14;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:newDate options:0];
    dayComponent.day = 60;
    NSDate *maxNextDate = [theCalendar dateByAddingComponents:dayComponent toDate:newDate options:0];
    self.dateAndTime.minimumDate = nextDate;
    self.dateAndTime.maximumDate = maxNextDate;
    
    chosenDate = nextDate;
    [self.view addSubview:self.dateAndTime];
    
    // add the handler for the date picker
    [self.dateAndTime addTarget:self action:@selector(changeChosenDate:) forControlEvents:UIControlEventValueChanged];
    
    // alert to tell users that the time selected is invalid
    self.badTime = [[UIAlertView alloc] initWithTitle:@"Invalid Time" message:@"Please select a time between 11 and 2" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // right swipe
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    
    // left swipe
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    
}

 -(IBAction)leftSwipeHandle:(UISwipeGestureRecognizer *)sender
{
    // change the restaurant information displayed
    self.restaurantIndex += 1;
    if(self.restaurantIndex >= [restaurantObjects count]) self.restaurantIndex = 0;
    Restaurant *newRestaurant = restaurantObjects[self.restaurantIndex];
    UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newRestaurant picture]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.lunchPicture setImage:resizedImage];
    [self.address setText:[newRestaurant address]];
    [self.locationName setText:[newRestaurant name]];
}

-(IBAction)rightSwipeHandle:(UISwipeGestureRecognizer *)sender
{
    chosenRestaurant = restaurantNames[self.restaurantIndex];
    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)changeChosenDate:(id)sender {
    // set up date formatter
    NSCalendar *gregorianCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self.dateAndTime.date];
    // if hour is not between 11 and 2 alert user
    if([dateComps hour] > 14 || [dateComps hour] < 11)
    {
        [self.badTime show];
        return;
    }
    chosenDate = self.dateAndTime.date;
}

-(void)changeRestaurant:(UIButton *)sender
{
    // change the restaurant information displayed
        self.restaurantIndex += 1;
        if(self.restaurantIndex >= [restaurantObjects count]) self.restaurantIndex = 0;
        Restaurant *newRestaurant = restaurantObjects[self.restaurantIndex];
        UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newRestaurant picture]]]];
        CGSize scaleSize = CGSizeMake(200, 200);
        UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
        [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.lunchPicture setImage:resizedImage];
        [self.address setText:[newRestaurant address]];
        [self.locationName setText:[newRestaurant name]];
}

- (void)makeLunch:(UIButton *)sender
{
    selectedMakeRestaurant = restaurantObjects[self.restaurantIndex];
    Restaurant *restaurant = restaurantObjects[self.restaurantIndex];
    chosenRestaurant = [restaurant name];
    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)chooseRest1:(UIButton *)sender
{
    // change view with restaurant set
    chosenRestaurant = @"Union Grill";
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}


- (void)chooseRest2:(UIButton *)sender {
    // change view with restaurant set
    chosenRestaurant = @"Harris Grill";
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)chooseRest3:(UIButton *)sender {
    // change view with restaurant set
    chosenRestaurant = @"Sharp Edge Bistro";
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
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


