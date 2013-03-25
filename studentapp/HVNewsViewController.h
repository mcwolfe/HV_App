//
//  HVNewsViewController.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-02-13.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVNewsStore.h"

@interface HVNewsViewController : UITableViewController
{
}

- (void)showLoading;
- (void)hideLoading;

@property (nonatomic, retain) HVNews *newsItem;

@end
