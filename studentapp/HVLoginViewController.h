//
//  HVViewController.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-04.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVLoginService.h"
@class MBProgressHUD;

@interface HVLoginViewController : UIViewController <UITextFieldDelegate, HVLoginServiceDelegate>
{  
    __weak IBOutlet UIButton    *loginButton;
    __weak IBOutlet UITextField *usernameField;
    __weak IBOutlet UITextField *passwordField;
    
    MBProgressHUD               *progressHUD;
    HVLoginService              *loginService;
}

- (IBAction)viewTapped:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)demo:(id)sender;

@end
