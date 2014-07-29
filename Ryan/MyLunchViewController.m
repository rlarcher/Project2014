//
//  MyLunchViewController.m
//  Ryan
//
//  Created by William Lutz on 7/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "MyLunchViewController.h"

@interface MyLunchViewController ()

@end

@implementation MyLunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Current Lunches";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.lunch = [[UITextView alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
    // just leave with no lunches for now
    self.lunch.text = @"Harris Grill 8/15/2014 1:25 PM";
    [self.lunch setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.lunch];
    
    self.cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancel.frame = CGRectMake(210, 60, 100, 100);
    [self.cancel setTitle:@"Cancel Lunch" forState:UIControlStateNormal];
    [self.cancel addTarget:self action:@selector(removeLunch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancel];
}

-(void)removeLunch:(UIButton *)sender {
    [self.lunch removeFromSuperview];
    [self.cancel removeFromSuperview];
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
