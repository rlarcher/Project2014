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

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.parsingAddress = NO;
        self.parsingRestaurant = NO;
        self.parsingName = NO;
        restaurantNames = [[NSMutableArray alloc] init];
        restaurantLocations = [[NSMutableArray alloc]init];
        restaurantPictures = [[NSMutableArray alloc]init];
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"restaurant_list" ofType:@"xml"]];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [parser setDelegate:self];
        BOOL result = [parser parse];
        if(!result) NSLog(@"Oh no that parse thing didn't go so well");
        
        self.title = @"Find Lunches";
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        // set the back button so it goes to the home screen
        [self.navigationItem setHidesBackButton:YES];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(home:)];
        self.navigationItem.leftBarButtonItem = backButton;
        
        // arrays and variables for restaurant information
        self.restaurantPictures = @[@"sharpedgebistro",@"UnionGrill",@"HarrisGrill"];
        self.restaurantAddresses = @[@"302 S. St. Clair St. Pittsburgh, PA 15206",@"413 S. Craig St. Pittsburgh, PA 15213",@"5747 Ellsworth Ave. Pittsburgh, PA 15232"];
        self.lunchTimes = @[@"August 18th at Noon",@"August 19th at Noon",@"August 20th at Noon"];
        self.restaurantIndex = 0;
        
        // set the array of pictures for number of seats taken
        self.availabilityArray = @[@"1Table",@"2Table",@"3Table",@"4Table"];
        
        self.availabilityPic = [UIImageView alloc];
        self.availabilityPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.availabilityArray[0]]];
        [self.availabilityPic setContentMode:UIViewContentModeScaleAspectFit];
        self.availabilityPic.frame = CGRectMake(145,310,25,25);
        [self.view addSubview:self.availabilityPic];
        
        // display the lunch picture
        self.lunchPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.restaurantPictures[self.restaurantIndex]]];
        [self.lunchPicture setContentMode:UIViewContentModeScaleAspectFit];
        self.lunchPicture.frame = CGRectOffset(self.lunchPicture.frame, self.view.center.x-(self.lunchPicture.frame.size.width/2), 100);
        [self.view addSubview:self.lunchPicture];
        
        // restaurant name
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        self.locationName = [[UITextView alloc]initWithFrame:CGRectMake(0, 360, screenWidth, 70)];
        [self.locationName setText:restaurantNames[self.restaurantIndex]];
        [self.locationName setBackgroundColor:[UIColor lightGrayColor]];
        self.locationName.editable = NO;
        self.locationName.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.locationName];

        
        // restaurant address
        self.address = [[UITextView alloc] initWithFrame:CGRectMake(0, 385,screenWidth, 100)];
        [self.address setText:restaurantLocations[self.restaurantIndex]];
        [self.address setBackgroundColor:[UIColor lightGrayColor]];
        self.address.editable = NO;
        self.address.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.address];
        
        // add time to the view
        self.time = [[UITextView alloc] initWithFrame:CGRectMake(0, 340, screenWidth, 30)];
        [self.time setText:self.lunchTimes[self.restaurantIndex]];
        [self.time setBackgroundColor:[UIColor lightGrayColor]];
        self.time.editable = NO;
        self.time.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.time];
       
        // button to show next lunch
        UIButton *nextLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        nextLunch.frame = CGRectMake(100, 420, 100, 44);
        [nextLunch setTitle:@"Next" forState:UIControlStateNormal];
        [self.view addSubview:nextLunch];
        
        // call function that will change lunch info
        [nextLunch addTarget:self action:@selector(showNextLunch:) forControlEvents:UIControlEventTouchUpInside];
        
        // button to show previous lunch
        UIButton *prevLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        prevLunch.frame = CGRectMake(30, 420, 100, 44);
        [prevLunch setTitle:@"Previous" forState:UIControlStateNormal];
        [self.view addSubview:prevLunch];
        
        // call function that will change lunch info
        [prevLunch addTarget:self action:@selector(showPrevLunch:) forControlEvents:UIControlEventTouchUpInside];
        
        // button to sign up
        UIButton *signUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        signUp.frame = CGRectMake(170, 420, 100, 44);
        [signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
        [self.view addSubview:signUp];
        
        // target for sign up
        [signUp addTarget:self action:@selector(signUpLunch:) forControlEvents:UIControlEventTouchUpInside];
        
        // button to make your own lunch
        UIButton *makeLunch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        makeLunch.frame = CGRectMake(60, 450, 200, 44);
        [makeLunch setTitle:@"Make Lunch" forState:UIControlStateNormal];
        [self.view addSubview:makeLunch];
        
        // call function to change the view
        [makeLunch addTarget:self action:@selector(makeLunch:) forControlEvents:UIControlEventTouchUpInside];
        
        // alert when lunch is selected
        self.registerAlert = [[UIAlertView alloc] initWithTitle:@"SitWith" message:
                              [NSString stringWithFormat:@"Confirm lunch for %@? ",self.lunchTimes[0]] delegate:nil cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes",nil];

    }
    return self;
}

    -(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
    {
        if([elementName isEqualToString:@"name"])
        {
            self.parsingName = YES;
        }
        if([elementName isEqualToString:@"address"])
        {
            self.parsingAddress = YES;
        }
        if([elementName isEqualToString:@"picture"])
        {
            self.parsingPicture = YES;
        }
    }
    
    -(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
        //NSLog(@"Did end element");
        if([elementName isEqualToString:@"name"])
        {
            self.parsingName = NO;
        }
        if([elementName isEqualToString:@"address"])
        {
            self.parsingAddress = NO;
        }
        if([elementName isEqualToString:@"picture"])
        {
            self.parsingPicture = NO;
        }
    }
    
    -(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
    {
        if(self.parsingName)
        {
            [restaurantNames addObject:(NSString *)string];
        }
        if(self.parsingAddress)
        {
            [restaurantLocations addObject:(NSString *)string];
        }
        if(self.parsingPicture)
        {
            [restaurantPictures addObject:(NSString *)string];
        }
    }
    

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.restaurantIndex += 1;
    if(self.restaurantIndex >= [self.restaurantPictures count]) self.restaurantIndex = 0;
    UIImage *image = [UIImage imageNamed:self.restaurantPictures[self.restaurantIndex]];
    [self.lunchPicture setImage:image];
    [self.address setText:self.restaurantAddresses[self.restaurantIndex]];
    [self.time setText:self.lunchTimes[self.restaurantIndex]];
}

-(void)signUpLunch:(UIButton *)sender
{
    self.registerAlert.message = [NSString stringWithFormat:@"Confirm lunch for %@?",self.lunchTimes[self.restaurantIndex]];
    [self.registerAlert show];
}

- (void)makeLunch:(UIButton *)sender
{
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdViewController animated:YES];
}

-(void)home:(UIBarButtonItem *)sender {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:firstViewController animated:YES];
}

- (void)showNextLunch:(UIButton *)sender
{
    self.restaurantIndex += 1;
    if(self.restaurantIndex >= [self.restaurantPictures count]) self.restaurantIndex = 0;
    UIImage *image = [UIImage imageNamed:self.restaurantPictures[self.restaurantIndex]];
    [self.lunchPicture setImage:image];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:restaurantNames[self.restaurantIndex]];
    [self.time setText:self.lunchTimes[self.restaurantIndex]];
}

-(void)showPrevLunch:(UIButton *)sender
{
    self.restaurantIndex -= 1;
    if(self.restaurantIndex < 0) self.restaurantIndex = [self.restaurantPictures count] - 1;
    UIImage *image = [UIImage imageNamed:self.restaurantPictures[self.restaurantIndex]];
    [self.lunchPicture setImage:image];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:restaurantNames[self.restaurantIndex]];
    [self.time setText:self.lunchTimes[self.restaurantIndex]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
