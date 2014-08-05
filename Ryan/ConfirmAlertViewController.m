//
//  ConfirmAlertViewController.m
//  Ryan
//
//  Created by William Lutz on 8/5/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "ConfirmAlertViewController.h"
#import "AppDelegate.h"

@interface ConfirmAlertViewController ()

@end

@implementation ConfirmAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.confirm = [[UIAlertView alloc] initWithTitle:@"Confirm lunch" message:
                              [NSString stringWithFormat:@"Confirm lunch for %@? ", lunchDateAndTime] delegate:self cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes",nil];
        [self.confirm show];
        
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        // user clicked no
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(buttonIndex == 1)
    {
        // user clicked yes
        [self.navigationController popViewControllerAnimated:YES];
    }
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
