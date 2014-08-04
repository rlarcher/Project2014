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
        
        // tell them to choose a location
        self.choose = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 350, 50)];
        self.choose.text = @"Choose a location and time for your lunch";
        [self.view addSubview:self.choose];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Make Lunch";
    self.restaurantIndex = 0;

    // display the lunch picture
    UIImage *firstLunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-xpf1/t1.0-9/1936792_101763893171479_5923274_n.jpg"]]];
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
    [self.locationName setText:restaurantNames[self.restaurantIndex]];
    [self.locationName setBackgroundColor:[UIColor whiteColor]];
    self.locationName.editable = NO;
    self.locationName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.locationName];
    
    
    // restaurant address
    self.address = [[UITextView alloc] initWithFrame:CGRectMake(0, 370,screenWidth, 40)];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
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
    
    self.dateAndTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 390, 300, 40)];
    self.dateAndTime.datePickerMode = UIDatePickerModeDateAndTime;
    self.dateAndTime.hidden = NO;
    self.dateAndTime.minuteInterval = 30;
    self.dateAndTime.minimumDate = [NSDate date];
    chosenDate = [NSDate date];
    self.dateAndTime.date = [NSDate date];
    [self.view addSubview:self.dateAndTime];
    [self.dateAndTime addTarget:self action:@selector(changeChosenDate:) forControlEvents:UIControlEventValueChanged];
    
    self.badTime = [[UIAlertView alloc] initWithTitle:@"Invalid Time" message:@"Please select a time between 12 and 4" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
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
    if(self.restaurantIndex >= [restaurantPictures count]) self.restaurantIndex = 0;
    UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:restaurantPictures[self.restaurantIndex]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.lunchPicture setImage:resizedImage];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:restaurantNames[self.restaurantIndex]];
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
    // if hour is not between 12 and 4 alert user
    if([dateComps hour] > 16 || [dateComps hour] < 12)
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
    if(self.restaurantIndex >= [restaurantPictures count]) self.restaurantIndex = 0;
    UIImage *lunchPicture = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:restaurantPictures[self.restaurantIndex]]]];
    CGSize scaleSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, 0.0);
    [lunchPicture drawInRect:CGRectMake(20, 20, scaleSize.width, scaleSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.lunchPicture setImage:resizedImage];
    [self.address setText:restaurantLocations[self.restaurantIndex]];
    [self.locationName setText:restaurantNames[self.restaurantIndex]];
    
}

- (void)makeLunch:(UIButton *)sender
{
    chosenRestaurant = restaurantNames[self.restaurantIndex];
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


