//
//  HVCellBackground.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-28.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVCellBackground : UIView

@property (nonatomic) BOOL isSelected;
@property (retain, nonatomic) UIColor *sideColor;

- (id)initAsSelected:(BOOL)selected;

@end
