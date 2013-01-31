//
//  HVCellBackground.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-28.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVCellBackground.h"
#import "HVCommonGraphics.h"

@implementation HVCellBackground

@synthesize isSelected;
@synthesize sideColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initAsSelected:(BOOL)selected {
    self = [super init];
    if (self) {
        self.isSelected = selected;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0
                                             blue:1.0 alpha:1.0];
    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0
                                                 blue:230.0/255.0 alpha:1.0];

    

    CGRect paperRect = self.bounds;
    
    if (self.isSelected) {
        drawLinearGradient(context, paperRect, lightGrayColor, whiteColor);

    } else {
        drawLinearGradient(context, paperRect, whiteColor, lightGrayColor);
    }

    
    
    //Om man vill ha ett vitt sträck:
    /*CGRect strokeRect = paperRect;
    strokeRect.size.height -= 1;
    strokeRect = rectFor1PxStroke(strokeRect);
    
    CGContextSetStrokeColorWithColor(context, whiteColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect); */
    
    CGRect sideRect = self.bounds;
    sideRect.size.width = 5.0;
    
    CGContextSetFillColorWithColor(context, sideColor.CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillRect(context, sideRect);
    
    
}


@end
