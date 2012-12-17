//
//  hvViewController.m
//  HVAppen
//
//  Created by Rickard Fjeldseth on 2012-12-10.
//  Copyright (c) 2012 Högskolan Väst. All rights reserved.
//

#import "hvViewController.h"

@interface hvViewController ()

@end

@implementation hvViewController
@synthesize textFieldPassword, textFieldUserName, hash;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButton_tap:(id)sender {
    NSMutableString *hashString = [[NSMutableString alloc] init];
    NSString *username = [textFieldUserName text];
    NSString *password = [textFieldPassword text];
    
    [hashString appendString:username];
    [hashString appendString:password];
    
    hash = [hvViewController generateHashWithString:hashString];
    hashString = nil;
    NSLog(@"%@", hash);
    
}

+ (NSString *)generateHashWithString:(NSString *)inString
{
    const char *input = [inString UTF8String];
    char result[32];
    
    CC_SHA256(input, strlen(input), result);
    
    NSString *toReturn = [[NSString alloc] initWithCharacters:result length:32];
    
    return toReturn;
}
@end
