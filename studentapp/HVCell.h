//
//  HVCell.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//
// En kommentar

#import <UIKit/UIKit.h>

@interface HVCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
- (void)setSideColor:(UIColor *)color;
- (void)modifyTextLabel;
@end
