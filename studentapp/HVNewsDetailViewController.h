//
//  HVNewsDetailViewController.h
//  studentapp
//
//  Created by Ulf Andersson on 2013-03-24.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HVNews;

@interface HVNewsDetailViewController : UIViewController
{
    __weak IBOutlet UILabel     *titleLabel;
    __weak IBOutlet UILabel     *tagLabel;
    __weak IBOutlet UITextView  *textContent;
    __weak IBOutlet UIView      *colorView;
    
    
}

@property   (nonatomic, retain) HVNews *newsItem;

@end
