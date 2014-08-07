//
//  SecondViewController.m
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "Restaurant.h"
#import "ConfirmAlertViewController.h"
#import "UpcomingLunch.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // custom initialization
    }
    return self;
}

// this function is for the left swipe
// same as when user presses skip button
 -(IBAction)leftSwipeHandle:(UISwipeGestureRecognizer *)sender
{
    self.restaurantIndex += 1;
    // if user has cycled through all lunches
    if(self.restaurantIndex >= [upcomingLunchObjects count]) self.restaurantIndex = 0;
    // get the next lunch object
    UpcomingLunch *newLunch = upcomingLunchObjects[self.restaurantIndex];
    UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newLunch picture]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.lunchPicture setImage:resizedImage];
    //[self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:[newLunch restaurantName]];
    NSString *theCount = [newLunch count];
    if([theCount isEqualToString:@"0"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"emptyTable"]];
    }
    if([theCount isEqualToString:@"1"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"1Table"]];
    }
    if([theCount isEqualToString:@"2"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"2Table"]];
    }
    if([theCount isEqualToString:@"3"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"3Table"]];
    }
    if([theCount isEqualToString:@"4"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"4Table"]];
    }
    int num = [theCount intValue];
    num = 4 - num;
    self.remaining.text = [NSString stringWithFormat:@"%d seats left",num];
    [self.time setText:[newLunch time]];
}

// this button is for the right swipe
// same as when user presses the join button
 -(IBAction)rightSwipeHandle:(UISwipeGestureRecognizer *)sender
{
    UpcomingLunch *thisLunch = upcomingLunchObjects[self.restaurantIndex];
    if(!([[thisLunch count] isEqualToString:@"4"]))
    {
        // set global equal to selected lunch
        signUpLunch = upcomingLunchObjects[self.restaurantIndex];
        self.registerAlert.message = [NSString stringWithFormat:@"Confirm lunch for %@?",[thisLunch time]];
        //[self.registerAlert show];
        self.restaurantIndex += 1;
        if(self.restaurantIndex >= [upcomingLunchObjects count]) self.restaurantIndex = 0;
        // get the next lunch object
        UpcomingLunch *newLunch = upcomingLunchObjects[self.restaurantIndex];
        UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newLunch picture]]]];
        CGSize scaleSize = CGSizeMake(200, 200);
        UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
        [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.lunchPicture setImage:resizedImage];
        //[self.address setText:restaurantLocations[self.restaurantIndex]];
        [self.locationName setText:[newLunch restaurantName]];
        NSString *theCount = [newLunch count];
        if([theCount isEqualToString:@"0"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"emptyTable"]];
        }
        if([theCount isEqualToString:@"1"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"1Table"]];
        }
        if([theCount isEqualToString:@"2"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"2Table"]];
        }
        if([theCount isEqualToString:@"3"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"3Table"]];
        }
        if([theCount isEqualToString:@"4"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"4Table"]];
        }
        int num = [theCount intValue];
        num = 4 - num;
        self.remaining.text = [NSString stringWithFormat:@"%d seats left",num];
        [self.time setText:[newLunch time]];
        ConfirmAlertViewController *confirmAlertViewController = [[ConfirmAlertViewController alloc]init];
        [self.navigationController pushViewController:confirmAlertViewController animated:YES];
    }
    else
    {
        [self.fullAlert show];
    }
}

// function called when parser reaches the beginning of an element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
    {
        //NSLog(elementName);
        if([elementName isEqualToString:@"LunchTable"])
        {
            self.currentLunch = [[UpcomingLunch alloc]init];
        }
        if([elementName isEqualToString:@"count"])
        {
            self.parsingCount = YES;
        }
        if([elementName isEqualToString:@"Restaurant"])
        {
            self.parsingRestaurant = YES;
        }
        if([elementName isEqualToString:@"restaurant_name"])
        {
            self.parsingName = YES;
        }
        if([elementName isEqualToString:@"address"])
        {
            self.parsingAddress = YES;
        }
        if([elementName isEqualToString:@"restaurant_picture"])
        {
            self.parsingPicture = YES;
        }
        if([elementName isEqualToString:@"availablebegintime"])
        {
            self.parsingTime = YES;
        }
        if([elementName isEqualToString:@"count"])
        {
            self.parsingAvailability = YES;
        }
        if([elementName isEqualToString:@"lunchtable_id"])
        {
            self.parsingLunchtable_id = YES;
        }
        if([elementName isEqualToString:@"restaurant_id"])
        {
            self.parsingRestaurant_id = YES;
        }
        if([elementName isEqualToString:@"lunchtabletime"])
        {
            self.parsingLunchtabletime = YES;
        }
    }
// parser reached the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
        //NSLog(elementName);
        if([elementName isEqualToString:@"count"])
        {
            self.parsingCount = NO;
        }
        if([elementName isEqualToString:@"restaurant_name"])
        {
            self.parsingName = NO;
        }
        if([elementName isEqualToString:@"address"])
        {
            self.parsingAddress = NO;
        }
        if([elementName isEqualToString:@"restaurant_picture"])
        {
            self.parsingPicture = NO;
        }
        if([elementName isEqualToString:@"availablebegintime"])
        {
            self.parsingTime = NO;
        }
        if([elementName isEqualToString:@"count"])
        {
            self.parsingAvailability = NO;
        }
        if([elementName isEqualToString:@"lunchtable_id"])
        {
            self.parsingLunchtable_id = NO;
        }
        if([elementName isEqualToString:@"restaurant_id"])
        {
            self.parsingRestaurant_id = NO;
        }
        if([elementName isEqualToString:@"lunchtabletime"])
        {
            self.parsingLunchtabletime = NO;
        }
        if([elementName isEqualToString:@"LunchTable"])
        {
            [upcomingLunchObjects addObject:self.currentLunch];
            self.currentLunch = nil;
        }
    }

// this handles the characters between the XML tags
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
    {
        if(self.parsingName)
        {
            [restaurantNames addObject:(NSString *)string];
            [self.currentLunch setRestaurantName:(NSString *)string];
        }
        if(self.parsingAddress)
        {
            //[restaurantLocations addObject:(NSString *)string];
            [self.currentLunch setAddress:(NSString *)string];
        }
        if(self.parsingPicture)
        {
            //[restaurantPictures addObject:(NSString *)string];
            [self.currentLunch setPicture:(NSString *)string];
        }
        if(self.parsingTime)
        {
            NSString *formattedTime = [string substringToIndex:[string length]-5];
            //[beginTimes addObject:(NSString *)formattedTime];
            [self.currentLunch setTime:formattedTime];
        }
        if(self.parsingAvailability)
        {
            //[restaurantAvailability addObject:(NSString *)string];
        }
        if(self.parsingCount)
        {
            [self.currentLunch setCount:string];
        }
        if(self.parsingLunchtable_id)
        {
            [self.currentLunch setLunchtable_id:(NSString *)string];
        }
        if(self.parsingRestaurant_id)
        {
            [self.currentLunch setRestaurant_id:(NSString *)string];
        }
        if(self.parsingLunchtabletime)
        {
            [self.currentLunch setLunchtabletime:(NSString *)string];
        }
    }
    
// handle the click on the alert
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        // find a way to add the user to the database
        // otherwise the user clicked no
    }
    else
    {
        // user cancelled at confirmation
    }
    self.restaurantIndex += 1;
    if(self.restaurantIndex >= [self.restaurantPictures count]) self.restaurantIndex = 0;
    UIImage *image = [UIImage imageNamed:self.restaurantPictures[self.restaurantIndex]];
    [self.lunchPicture setImage:image];
    [self.address setText:self.restaurantAddresses[self.restaurantIndex]];
    [self.time setText:self.lunchTimes[self.restaurantIndex]];
}

// when user presses the join button
-(void)signUpLunch:(UIButton *)sender
{
    UpcomingLunch *thisLunch = upcomingLunchObjects[self.restaurantIndex];
    if(!([[thisLunch count] isEqualToString:@"4"]))
    {
        // set global variable equal to lunch object chosen
        signUpLunch= upcomingLunchObjects[self.restaurantIndex];
        self.registerAlert.message = [NSString stringWithFormat:@"Confirm lunch for %@?",[thisLunch time]];
        //[self.registerAlert show];
        
        // increment index to show next lunch when user returns to this view
        self.restaurantIndex += 1;
        if(self.restaurantIndex >= [upcomingLunchObjects count]) self.restaurantIndex = 0;
        // get the next lunch object
        UpcomingLunch *newLunch = upcomingLunchObjects[self.restaurantIndex];
        UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newLunch picture]]]];
        CGSize scaleSize = CGSizeMake(200, 200);
        UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
        [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.lunchPicture setImage:resizedImage];
        //[self.address setText:restaurantLocations[self.restaurantIndex]];
        [self.locationName setText:[newLunch restaurantName]];
        NSString *theCount = [newLunch count];
        if([theCount isEqualToString:@"0"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"emptyTable"]];
        }
        if([theCount isEqualToString:@"1"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"1Table"]];
        }
        if([theCount isEqualToString:@"2"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"2Table"]];
        }
        if([theCount isEqualToString:@"3"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"3Table"]];
        }
        if([theCount isEqualToString:@"4"])
        {
            [self.availabilityPic setImage:[UIImage imageNamed:@"4Table"]];
        }
        int num = [theCount intValue];
        num = 4 - num;
        self.remaining.text = [NSString stringWithFormat:@"%d seats left",num];
        [self.time setText:[newLunch time]];
        ConfirmAlertViewController *confirmAlertViewController = [[ConfirmAlertViewController alloc]init];
        [self.navigationController pushViewController:confirmAlertViewController animated:YES];
    }
    else
    {
        [self.fullAlert show];
    }
}

// when user presses the make lunch button
- (void)makeLunch:(UIButton *)sender
{
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdViewController animated:YES];
}

// send app back to the home screen
-(void)home:(UIBarButtonItem *)sender {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:firstViewController animated:YES];
}

// show the next lunch when user presses skip
- (void)showNextLunch:(UIButton *)sender
{
    self.restaurantIndex += 1;
    if(self.restaurantIndex >= [upcomingLunchObjects count]) self.restaurantIndex = 0;
    UpcomingLunch *newLunch = upcomingLunchObjects[self.restaurantIndex];
    UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newLunch picture]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.lunchPicture setImage:resizedImage];
    //[self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:[newLunch restaurantName]];
    NSString *theCount = [newLunch count];
    if([theCount isEqualToString:@"0"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"emptyTable"]];
    }
    if([theCount isEqualToString:@"1"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"1Table"]];
    }
    if([theCount isEqualToString:@"2"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"2Table"]];
    }
    if([theCount isEqualToString:@"3"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"3Table"]];
    }
    if([theCount isEqualToString:@"4"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"4Table"]];
    }
    int num = [theCount intValue];
    num = 4 - num;
    self.remaining.text = [NSString stringWithFormat:@"%d seats left",num];
    [self.time setText:[newLunch time]];
}

/*
 FOR NOW THERE IS NO PREVIOUS LUNCH BUTTON
-(void)showPrevLunch:(UIButton *)sender
{
    self.restaurantIndex -= 1;
    if(self.restaurantIndex < 0) self.restaurantIndex = [self.restaurantPictures count] - 1;
    UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:restaurantPictures[self.restaurantIndex]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.lunchPicture setImage:resizedImage];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:restaurantNames[self.restaurantIndex]];
    [self.time setText:self.lunchTimes[self.restaurantIndex]];
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // INITIALIZE STUFF
    
    // booleans for parsing
    self.parsingCount = NO;
    self.parsingAddress = NO;
    self.parsingRestaurant = NO;
    self.parsingName = NO;
    self.parsingPicture = NO;
    self.parsingTime = NO;
    self.parsingLunchtable_id = NO;
    self.parsingLunchtabletime = NO;
    self.parsingRestaurant_id = NO;
    
    // the arrays for holdng info from xml
    self.lunchObjects = [[NSMutableArray alloc]init];
    restaurantAvailability = [[NSMutableArray alloc]init];
    restaurantNames = [[NSMutableArray alloc] init];
    restaurantLocations = [[NSMutableArray alloc]init];
    restaurantPictures = [[NSMutableArray alloc]init];
    beginTimes = [[NSMutableArray alloc]init];
    upcomingLunchObjects = [[NSMutableArray alloc]init];
    
    // restaurant object for selection
    signUpLunch = [[UpcomingLunch alloc]init];
    
    NSString *server = [NSString stringWithFormat:@"%@/getNotFilledUpcomingLunchTable?email=%@",serverAddress,userEmail];
    NSURL *url = [NSURL URLWithString:server];
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:xmlData];
    [parser setDelegate:self];
    BOOL result = [parser parse];
    if(!result) NSLog(@"Oh no that parse thing didn't go so well");
    self.title = @"Find Lunches";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // get first lunch object to display initially
    UpcomingLunch *firstLunch = upcomingLunchObjects[self.restaurantIndex];
    
    // this is the global that holds the date and time
    lunchDateAndTime = [[NSString alloc]init];
    lunchDateAndTime = [firstLunch time];
    
    // set the back button so it goes to the home screen
    [self.navigationItem setHidesBackButton:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(home:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // arrays and variables for restaurant information
    self.restaurantPictures = @[@"sharpedgebistro",@"UnionGrill",@"HarrisGrill"];
    restaurantLocations = (NSMutableArray *)@[@"302 S. St. Clair St. Pittsburgh, PA 15206",@"413 S. Craig St. Pittsburgh, PA 15213",@"5747 Ellsworth Ave. Pittsburgh, PA 15232"];
    self.lunchTimes = @[@"August 18th at Noon",@"August 19th at Noon",@"August 20th at Noon"];
    self.restaurantIndex = 0;
    
    // set the array of pictures for number of seats taken
    self.availabilityArray = @[@"1Table",@"2Table",@"3Table",@"4Table"];
    
    // display the picture for the number of seats left
    self.availabilityPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emptyTable"]];
    NSString *myCount = [firstLunch count];
    if([myCount isEqualToString:@"0"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"emptyTable"]];
    }
    if([myCount isEqualToString:@"1"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"1Table"]];
    }
    if([myCount isEqualToString:@"2"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"2Table"]];
    }
    if([myCount isEqualToString:@"3"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"3Table"]];
    }
    if([myCount isEqualToString:@"4"])
    {
        [self.availabilityPic setImage:[UIImage imageNamed:@"4Table"]];
    }
    
    [self.availabilityPic setContentMode:UIViewContentModeScaleAspectFit];
    self.availabilityPic.frame = CGRectMake(100,310,25,25);
    [self.view addSubview:self.availabilityPic];
    
    self.remaining = [[UITextView alloc]init];
    self.remaining.frame = CGRectMake(180, 310, 100, 100);
    self.remaining.editable = NO;
    self.remaining.text = @"4 seats left";
    [self.view addSubview:self.remaining];
    
    // display the lunch picture
    UIImage *firstLunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[firstLunch picture]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [firstLunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.lunchPicture = [[UIImageView alloc] initWithImage:resizedImage];
    [self.lunchPicture setContentMode:UIViewContentModeScaleAspectFit];
    self.lunchPicture.frame = CGRectOffset(self.lunchPicture.frame, self.view.center.x-(self.lunchPicture.frame.size.width/2), 100);
    [self.view addSubview:self.lunchPicture];
    
    // instructions for using this view
    UITextView *instructions = [[UITextView alloc]init];
    instructions.frame = CGRectMake(50, 70, 300, 40);
    instructions.text = @"Swipe left to skip a lunch and right to join";
    [self.view addSubview:instructions];
    
    // restaurant name
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.locationName = [[UITextView alloc]initWithFrame:CGRectMake(0, 360, screenWidth, 70)];
    [self.locationName setText:[firstLunch restaurantName]];
    [self.locationName setBackgroundColor:[UIColor whiteColor]];
    self.locationName.editable = NO;
    self.locationName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.locationName];
    
    
    // restaurant address
    self.address = [[UITextView alloc] initWithFrame:CGRectMake(0, 385,screenWidth, 100)];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.address setBackgroundColor:[UIColor whiteColor]];
    self.address.editable = NO;
    self.address.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.address];
    
    // add time to the view
    self.time = [[UITextView alloc] initWithFrame:CGRectMake(0, 340, screenWidth, 30)];
    [self.time setText:[firstLunch time]];
    [self.time setBackgroundColor:[UIColor whiteColor]];
    self.time.editable = NO;
    self.time.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.time];
    
    // button to show next lunch
    UIButton *nextLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextLunch.frame = CGRectMake(70, 420, 100, 44);
    [nextLunch setTitle:@"Skip" forState:UIControlStateNormal];
    [nextLunch setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [nextLunch setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self.view addSubview:nextLunch];
    
    // call function that will change lunch info
    [nextLunch addTarget:self action:@selector(showNextLunch:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     // button to show previous lunch
     UIButton *prevLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     prevLunch.frame = CGRectMake(30, 420, 100, 44);
     [prevLunch setTitle:@"Previous" forState:UIControlStateNormal];
     [self.view addSubview:prevLunch];
     
     // call function that will change lunch info
     [prevLunch addTarget:self action:@selector(showPrevLunch:) forControlEvents:UIControlEventTouchUpInside];
     */
    
    // make the button to sign up
    UIButton *signUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUp.frame = CGRectMake(140, 420, 100, 44);
    [signUp setTitle:@"Join" forState:UIControlStateNormal];
    [signUp setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [signUp setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self.view addSubview:signUp];
    
    // call the function when the user clicks the sign up button
    [signUp addTarget:self action:@selector(signUpLunch:) forControlEvents:UIControlEventTouchUpInside];
    
    // create the button to make your own lunch
    UIButton *makeLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    makeLunch.frame = CGRectMake(60, 450, 200, 44);
    [makeLunch setTitle:@"Make Lunch" forState:UIControlStateNormal];
    [makeLunch setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [makeLunch setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self.view addSubview:makeLunch];
    
    // call function to change the view on button press
    [makeLunch addTarget:self action:@selector(makeLunch:) forControlEvents:UIControlEventTouchUpInside];
    
    // alert when lunch is selected
    self.registerAlert = [[UIAlertView alloc] initWithTitle:@"SitWith" message:
                          [NSString stringWithFormat:@"Confirm lunch for %@? ",[firstLunch time]] delegate:nil cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes",nil];
    
    self.registerAlert.transform = CGAffineTransformMakeTranslation(25, 25);
    
    self.fullAlert = [[UIAlertView alloc]initWithTitle:@"Lunch Full" message:@"This lunch is full" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    self.fullAlert.transform = CGAffineTransformMakeTranslation(25, 25);
    
    // right swipe
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    // add to view
    [self.view addGestureRecognizer:rightRecognizer];
    
    // left swipe
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    // add to view
    [self.view addGestureRecognizer:leftRecognizer];
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
