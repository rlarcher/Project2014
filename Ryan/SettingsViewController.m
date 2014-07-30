//
//  SettingsViewController.m
//  Ryan
//
//  Created by William Lutz on 7/30/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "SettingsViewController.h"

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
        CGFloat screenHeight = screenRect.size.height;
        self.visit.frame = CGRectMake(screenWidth/2-80, screenHeight/3, 120, 50);
        [self.visit setTitle:@"Visit SitWith" forState:UIControlStateNormal];
        [self.visit addTarget:self action:@selector(visitSite:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.visit];
    }
    return self;
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
