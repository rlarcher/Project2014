//
//  ParseForUser.m
//  Ryan
//
//  Created by William Lutz on 8/6/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
// This class will check to see whether the user is already in the database or not
//

#import "ParseForUser.h"

@implementation ParseForUser

-(BOOL)searchForUser
{
    self.foundUserName = NO;
    NSString *serverURL = [NSString stringWithFormat:@"%@/getAllUser",serverAddress];
    NSURL *url = [NSURL URLWithString:serverURL];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    return self.foundUserName;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"name"])
    {
        self.parsingUserName = YES;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"name"])
    {
        self.parsingUserName = NO;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.parsingUserName)
    {
        if([string isEqualToString:userName])
        {
            self.foundUserName = YES;
        }
    }
}

@end
