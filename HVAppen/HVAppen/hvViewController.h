//
//  hvViewController.h
//  HVAppen
//
//  Created by Rickard Fjeldseth on 2012-12-10.
//  Copyright (c) 2012 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface hvViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (nonatomic) NSString *hash;

- (IBAction)loginButton_tap:(id)sender;

+ (NSString *)generateHashWithString:(NSString *)inString;

@end
