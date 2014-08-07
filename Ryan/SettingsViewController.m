//
//  SettingsViewController.m
//  Ryan
//
//  Created by William Lutz on 7/30/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.visit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        //CGFloat screenHeight = screenRect.size.height;
        self.visit.frame = CGRectMake(screenWidth/2-80, 90, 120, 50);
        [self.visit setTitle:@"Visit sitWith.co" forState:UIControlStateNormal];
        [self.visit addTarget:self action:@selector(visitSite:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.visit];
        
        // button to see what to expect (FAQ)
        self.fqButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.fqButton.frame = CGRectMake(40, 130, 200, 50);
        [self.fqButton setTitle:@"What To Expect" forState:UIControlStateNormal];
        [self.fqButton addTarget:self action:@selector(showfq:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.fqButton];
        
        // button for user to delete account
        self.delete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.delete.frame = (CGRectMake(40, 180, 200, 50));
        [self.delete setTitle:@"Delete Account" forState:UIControlStateNormal];
        [self.view addSubview:self.delete];
        
        // now add the target
        [self.delete addTarget:self action:@selector(deleteAccount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)deleteAccount:(UIButton *)sender
{
    // delete the user's account
    NSString *baseUrl = [NSString stringWithFormat:@"%@/deleteUser?email=%@",serverAddress,userEmail];
    NSURL *url = [NSURL URLWithString:baseUrl];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser parse];
}

-(void)showfq:(UIButton *)sender
{
    // make the view for the FAQ
    UIViewController *fq = [[UIViewController alloc] init];
    fq.view.frame = self.view.frame;
    fq.title = @"What To Expect";
    [fq.view setBackgroundColor:[UIColor whiteColor]];
    
    self.descriptionHeader = [[UITextView alloc]initWithFrame:CGRectMake(20, 50, 300, 150)];
    self.descriptionHeader.editable = NO;
    self.descriptionHeader.text = @"We know SitWith is a new concept so you may be unsure of what to expect, but not to worry!  We built this page to help paint a picture of what a SitWith lunch is really like.";
    [fq.view addSubview:self.descriptionHeader];
    
    UITextView *questions = [[UITextView alloc]initWithFrame:CGRectMake(20, 200, 300, 300)];
    questions.editable = NO;
    questions.text = @"You should expect . . .\n\nAn hour lunch at a great Pittsburgh restaurant. - You may get caught up in some great conversation, though, so we suggest setting aside about an hour and a half for these lunches\nTo meet new people in a social setting for a relaxed conversation.\n\nA split check – everyone pays their own way.\n\nTo be on time for your lunch (e.g., 11:30 am sharp).\n\nTo be set up with a diverse group of people with diverse backgrounds.\n\nTo be asked to provide feedback after your lunch is over. We are a young startup after all, so we crave feedback.\n\nTo NOT exchange business cards, phone numbers, emails, Twitter handles, Facebook friends, or LinkedIn connections until after you leave the restaurant. It gives everyone the opportunity to say “no thanks” comfortably.";
    [fq.view addSubview:questions];
    
    [self.navigationController pushViewController:fq animated:YES];
}

-(void)visitSite:(UIButton *)sender
{
    NSURL *myUrl = [NSURL URLWithString:@"http://www.sitwith.co"];
    [[ UIApplication sharedApplication]openURL:myUrl];
    
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
