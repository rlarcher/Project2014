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
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"lunchtable_list" ofType:@"xml"]];
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
    [self.cancel addTarget:self action:@selector(confirmRemoveLunch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancel];
    
    self.confirmView = [[UIViewController alloc]init];
    self.confirmView.view.frame = self.view.frame;
    
    self.confirm = [[UIAlertView alloc] initWithTitle:@"Cancel Lunch" message:@"Are you sure you want to remove yourself from this lunch" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    self.confirm.transform = CGAffineTransformMakeTranslation(25, 25);
}

-(void)confirmRemoveLunch:(UIButton *)sender {
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
