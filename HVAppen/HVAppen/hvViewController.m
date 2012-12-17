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
@synthesize textFieldPassword, textFieldUserName, hashFromNameAndPassword;
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
    
    hashFromNameAndPassword = [hvViewController generateHashWithString:hashString];
    NSLog(@"%@",hashString);
    
    NSLog(@"%@", hashFromNameAndPassword);
    
}

+ (NSString *)generateHashWithString:(NSString *)inString
{
    const char *input = [inString UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(input, strlen(input), result);

    //Takes the unsigned char result and converts it into NSMutableString
    NSMutableString *toReturn = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0;i<CC_SHA256_DIGEST_LENGTH;i++)
    {
        [toReturn appendFormat:@"%02x",result[i]];
    }
    
    return toReturn;
}
@end
