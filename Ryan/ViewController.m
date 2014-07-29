//
//  ViewController.m
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button1.frame = CGRectMake(100,100,100,40);
    
    [button1 setTitle:@"Click me!" forState:UIControlStateNormal];
    [button1 setTitle:@"clicked" forState:UIControlStateHighlighted];
    
    [self.view addSubview:button1];
    
    UIImageView *myImage = [[UIImageView alloc] initWithImage:
                            [UIImage imageNamed:@"SitWith"]];
    
    [myImage setContentMode:UIViewContentModeScaleAspectFit];
    
    myImage.frame = CGRectMake(100, 200, 75, 75);
    
    [self.view addSubview:myImage];
}

- (void)buttonPressed:(UIButton *)sender
{
    if(self.view.alpha == 1) {
        self.view.alpha = 0.2;
    }
    else {
        self.view.alpha = 1;
    }
}

- (void)loadView
{
    CGRect viewRect = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:viewRect];
    self.view = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
