//
//  SecondViewController.h
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (strong,nonatomic) UIImageView *lunchPicture;
@property (strong,nonatomic) NSArray *restaurantPictures;
@property (strong,nonatomic) NSArray *restaurantAddresses;
@property (strong,nonatomic) NSArray *lunchTimes;
@property (strong,nonatomic) UITextView *time;
@property (strong, nonatomic) UITextView *address;
@property (strong,nonatomic) UIAlertView *registerAlert;
@property int restaurantIndex;
@end
