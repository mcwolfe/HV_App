//
//  HVDayViewController.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-05.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVLoginService.h"
#import "HVActivityStore.h"

@class MBProgressHUD;

@interface HVDayViewController : UITableViewController <HVLoginServiceDelegate, HVActivityStoreDelegate>
{
    UIBarButtonItem *logOutButton;
    UIBarButtonItem *reloadDataButton;
}

- (void)showLoading;
- (void)hideLoading;
@end
