//
//  RegisterViewController.m
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "FirstViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "SecondViewController.h"

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
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    
    // chosenDate is global that holds date selected by user in previous viewcontroller
    NSString *myDate = [df stringFromDate:chosenDate];
    
    // add the label with the restaurant name
    self.restaurant = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 300, 150)];
    self.restaurant.numberOfLines = 0;
    self.restaurant.text = [NSString stringWithFormat:@"Make a lunch at %@ \n on %@?",chosenRestaurant,myDate];
    [self.view addSubview:self.restaurant];
    
    // button to confirm created lunch
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirm.frame = CGRectMake(60, 200, 150, 100);
    [confirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.view addSubview:confirm];
    
    // alert that is shown after user presses confirm
    self.alertConfirm = [[UIAlertView alloc] initWithTitle:nil message:@"Thank you for using SitWith" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [confirm addTarget:self action:@selector(confirmed:) forControlEvents:UIControlEventTouchUpInside];
                         
}

- (void)confirmed:(UIButton *)sender {
    // user pressed confirm so make lunch with server
    // base url SitWithWebServer/createLunchTableWithJoin?availablebegintime= &restaurant_id= &restaurant_name= &email= &user_name=
    
    // strings to use in url to make lunch
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    NSString *availablebegintime = [df stringFromDate:chosenDate];
    NSString *restaurant_id = [selectedMakeRestaurant restaurant_id];
    NSString *restaurant_name = [selectedMakeRestaurant name];
    NSString *email = userEmail;
    NSString *user_name = userName;
    
    // get rid of space in user name
    NSMutableString *newString = [[NSMutableString alloc]init];
    for (int i = 0; i < [user_name length]; i++) {
        if(![[user_name substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "])
        {
            newString = (NSMutableString *)[NSString stringWithFormat:@"%@%@",newString,[user_name substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    user_name = (NSString *)newString;
    
    NSString *url = [NSString stringWithFormat:@"%@/createLunchTableWithJoin?availablebegintime=%@&restaurant_id=%@&email=%@&user_name=%@",serverAddress,availablebegintime,restaurant_id,email,user_name];
    NSURL *serverUrl = [NSURL URLWithString:url];
    //NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:serverUrl];
    //[parser parse];
    
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
