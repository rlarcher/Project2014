//
//  SecondViewController.h
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface SecondViewController : UIViewController <NSXMLParserDelegate>
@property (strong,nonatomic) UIImageView *lunchPicture;
@property (strong,nonatomic) NSArray *availabilityArray;
@property (strong,nonatomic) UIImageView *availabilityPic;
@property (strong,nonatomic) NSArray *restaurantPictures;
@property NSArray *restaurantAddresses;
@property (strong,nonatomic) NSArray *lunchTimes;
@property (strong,nonatomic) UITextView *time;
@property (strong, nonatomic) UITextView *address;
@property (strong,nonatomic) UITextView *locationName;
@property (strong,nonatomic) UIAlertView *registerAlert;
@property NSMutableString *currentAddress;
@property Restaurant *currentRestaurant;
// these variables will keep track of which data
// is being read by the parser
@property BOOL parsingRestaurant;
@property BOOL parsingAddress;
@property BOOL parsingName;
@property BOOL parsingPicture;
@property BOOL parsingTime;
@property BOOL parsingAvailability;

@property int restaurantIndex;
@end
