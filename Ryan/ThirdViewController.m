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
        self.choose = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 350, 50)];
        self.choose.text = @"Choose a location and time for your lunch";
        [self.view addSubview:self.choose];
        
        
        // button for first restaurant choice
        self.restaurant1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.restaurant1.frame = CGRectMake(110, 150, 75, 30);
        [self.restaurant1 setTitle:@"Union Grill" forState:UIControlStateNormal];
        [self.view addSubview:self.restaurant1];
        
        // add the target for first restaurant
        [self.restaurant1 addTarget:self action:@selector(chooseRest1:) forControlEvents:UIControlEventTouchUpInside];
        
        // button for second restaurant choice
        self.restaurant2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.restaurant2.frame = CGRectMake(110, 190, 75, 30);
        [self.restaurant2 setTitle:@"Harris Grill" forState:UIControlStateNormal];
        [self.view addSubview:self.restaurant2];
        
        // add the target for second restaurant choice
        [self.restaurant2 addTarget:self action:@selector(chooseRest2:) forControlEvents:UIControlEventTouchUpInside];
        
        // button for third restaurant choice
        self.restaurant3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.restaurant3.frame = CGRectMake(50, 230, 200, 30);
        [self.restaurant3 setTitle:@"Sharp Edge Bistro" forState:UIControlStateNormal];
        [self.view addSubview:self.restaurant3];
        
        // add the target for the third restaurant
        [self.restaurant3 addTarget:self action:@selector(chooseRest3:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Make Lunch";
    
    self.dateAndTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 300, 300, 40)];
    self.dateAndTime.datePickerMode = UIDatePickerModeDateAndTime;
    self.dateAndTime.hidden = NO;
    self.dateAndTime.minuteInterval = 30;
    self.dateAndTime.minimumDate = [NSDate date];
    chosenDate = [NSDate date];
    self.dateAndTime.date = [NSDate date];
    [self.view addSubview:self.dateAndTime];
    [self.dateAndTime addTarget:self action:@selector(changeChosenDate:) forControlEvents:UIControlEventValueChanged];
    
    self.badTime = [[UIAlertView alloc] initWithTitle:@"Invalid Time" message:@"Please select a time between 12 and 4" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
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
    NSLog(@"hour is %d",[dateComps hour]);
    chosenDate = self.dateAndTime.date;
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


