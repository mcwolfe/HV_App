//
//  HVActivityDetailViewController.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-08.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HVActivity;
@interface HVActivityDetailViewController : UIViewController
{
    __weak IBOutlet UILabel    *titleLabel;
    __weak IBOutlet UILabel    *tagLabel;
    __weak IBOutlet UITextView *textContent;
    __weak IBOutlet UIView     *colorView;
    
    UIBarButtonItem *showOnMapButton;
}

@property (nonatomic, retain) HVActivity *activity;

@end
