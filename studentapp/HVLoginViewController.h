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

@interface HVLoginViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, HVLoginServiceDelegate>
{  
    __weak IBOutlet UIButton *loginButton;
    UITextField              *usernameField;
    UITextField              *passwordField;
    UITableView              *loginTable;
    
    MBProgressHUD            *progressHUD;
    HVLoginService           *loginService;
}

- (IBAction)viewTapped:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)demo:(id)sender;

@end
