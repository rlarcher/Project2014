//
//  FirstViewController.m
//  Ryan
//
//  Created by William Lutz on 7/15/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "MyLunchViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBSession.h>
#import "PastLunchesViewController.h"
#import "SettingsViewController.h"
#import "AFNetworking.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // set this variable false initially
        // it will stay false unless we find the user
        self.parsingUserData = false;
        self.foundUser = false;
        
        self.title = @"SitWith";
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tablepic"]];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        // hide the back button because this is first screen
        [self.navigationItem setHidesBackButton:YES];

        self.settingsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.settingsButton.frame = CGRectMake(0, 0, 80, 30);
        [self.settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
        
        // add the target
        [self.settingsButton addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
        
        // make it the upper left button
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:self.settingsButton];
        self.navigationItem.leftBarButtonItem = button;
        
        // SitWith logo
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SitWithSmall"]];
        [logo setContentMode:UIViewContentModeScaleAspectFit];
        logo.frame = CGRectOffset(logo.frame, self.view.center.x-(logo.frame.size.width/2), 100);
        [self.view addSubview:logo];
        
        // button to view available lunches
        UIButton *viewLunches = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        viewLunches.frame = CGRectMake(60, 410, 200, 44);
        [viewLunches setTitle:@"View Available Lunches" forState:UIControlStateNormal];
        [self.view addSubview:viewLunches];
        
        // make button a link to the new viewcontroller
        [viewLunches addTarget:self action:@selector(showLunches:) forControlEvents:UIControlEventTouchUpInside];
        
        // button to view user's lunches
        UIButton *myLunches = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myLunches.frame = CGRectMake(60, 445, 200, 44);
        [myLunches setTitle:@"My Current Lunches" forState:UIControlStateNormal];
        [self.view addSubview:myLunches];
        
        // make button link to new viewcontroller
        [myLunches addTarget:self action:@selector(viewMyLunches:) forControlEvents:UIControlEventTouchUpInside];
        
        // button for past lunches
        UIButton *pastLunches = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        pastLunches.frame = CGRectMake(60, 375, 200, 44);
        [pastLunches setTitle:@"Past Lunches" forState:UIControlStateNormal];
        [self.view addSubview:pastLunches];
        
        // make button link to past lunch view
        [pastLunches addTarget:self action:@selector(showPastLunches:) forControlEvents:UIControlEventTouchUpInside];
        
        // create the login
        FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile",
                                                                                @"email",@"user_friends"]];
        loginView.delegate = self;
        
        // Align the button in the center horizontally
        loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), (self.view.center.y + (loginView.frame.size.height )));
        [self.view addSubview:loginView];
        
        // set the name of the user
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 200, 50)];
        self.nameLabel.text = @"";
        [self.view addSubview:self.nameLabel];
        
        self.contact = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.contact.frame = CGRectMake(100, 285, 120, 50);
        [self.contact setTitle:@"Contact SitWith" forState:UIControlStateNormal];
        [self.view addSubview:self.contact];
        
        // add target for contact button
        [self.contact addTarget:self action:@selector(showEmail:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"SitWith IOS Feedback";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@sitwith.co"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:@"" isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // set the welcome message with the user name
    userName = (NSMutableString *)user.name;
    self.nameLabel.text = [NSString stringWithFormat:@"Welcome %@",user.first_name];
    userEmail = user[@"email"];
}

-(void) showSettings:(UIButton *)sender
{
    // change the view to show the settings
    SettingsViewController *settingsViewController = [[SettingsViewController alloc]init];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)showLunches:(UIButton *)sender
{
    // change the view to show available lunches
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

- (void)showPastLunches:(UIButton *)sender
{
    // change the view to show past lunches
    PastLunchesViewController *pastLunchesViewController = [[PastLunchesViewController alloc] init];
    [self.navigationController pushViewController:pastLunchesViewController animated:YES];
}

- (void)viewMyLunches:(UIButton *)sender
{
    // change the view to show user's lunches
    MyLunchViewController *myLunchViewController = [[MyLunchViewController alloc]init];
    [self.navigationController pushViewController:myLunchViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *server = @"http://128.237.127.135:8888/SitWithWebServer/getAllLunchTable";
    NSURL *url = [NSURL URLWithString:server];
    /*NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Make sure to set the responseSerializer correctly
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        [parser setDelegate:self];
        [parser parse];
        
        NSLog(@"It worked");

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }];
    
    [operation start];*/
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    BOOL result = [parser parse];
    if(result == NO)
    {
        NSLog(@"%@",[parser parserError].localizedDescription);
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Did start element");
    if([elementName isEqualToString:@"user"])
    {
        self.parsingUserData = YES;
        return;
    }
    if([elementName isEqualToString:@"name"])
    {
        self.parsingUserName = YES;
    }
    if([elementName isEqualToString:@"email"])
    {
        self.parsingEmail = YES;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"Did end element");
    // reached the end of the XML file
    if([elementName isEqualToString:@"Users"]) return;
    if([elementName isEqualToString:@"name"])
    {
        // let app know that it is between name tags
        self.parsingUserName = NO;
        // this checks to see if user is in the xml table
        if([self.userFromParse isEqualToString:userName])
        {
            self.foundUser = YES;
            // now find a way to add the user to the database
            
        }
        else {
            self.userFromParse = nil;
        }
    }
    if([elementName isEqualToString:@"email"]) self.parsingEmail = NO;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.parsingUserName)
    {
        // add the found characters to the parsed UserName
        // this only occurs for string between xml name tags
        [self.userFromParse appendString:string];
    }
    if(self.parsingEmail)
    {
        [userEmail appendString:string];
        NSLog(string);
    }
}

// error handling
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XMLParser error: %@", [parseError localizedDescription]);
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Started the document");
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"XMLParser error: %@", [validationError localizedDescription]);
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
