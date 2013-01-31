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

@property (retain, nonatomic) UITextView *descriptionText;
@property (retain, nonatomic) UILabel    *titleLabel;
@property (retain, nonatomic) UILabel    *tagLabel;
@property (retain, nonatomic) UILabel    *dateLabel;

- (void)setSideColor:(UIColor *)color;
@end
