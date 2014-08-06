//
//  AppDelegate.h
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "UpcomingLunch.h"

@class ViewController;

// THESE ARE ALL GLOBALS STORED IN THE APP DELGATE

// restaurant user selects for signup
UpcomingLunch *signUpLunch;

// string version of selected restaurant
NSString *chosenRestaurant;
NSArray *possibleHours;
NSArray *possibleMinutes;
NSArray *ampm;

// date of restaurant selected
NSDate *chosenDate;

// object for when user makes lunch
Restaurant *selectedMakeRestaurant;

// string version of date and time
NSString *lunchDateAndTime;

// these represent the information for logged in user
NSMutableString *userName;
NSMutableString *userEmail;

// arrays that will hold data taken from xml files
NSMutableArray *restaurantAvailability;
NSMutableArray *restaurantNames;
NSMutableArray *restaurantLocations;
NSMutableArray *restaurantPictures;
NSMutableArray *beginTimes;

// arrays to hold objects taken from xml
NSMutableArray *upcomingLunchObjects;
NSMutableArray *restaurantObjects;
NSMutableArray *userPastLunchObjects;
NSMutableArray *userUpcomingLunchObjects;

NSString *serverAddress;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong,nonatomic) ViewController *viewController;
@property (strong, nonatomic) UIWindow *window;
@end



