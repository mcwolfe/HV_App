//
//  HVCommonGraphics.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-28.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVCommonGraphics : NSObject

void drawLinearGradient(CGContextRef context, CGRect rect, UIColor *startColor, UIColor *endColor);

CGRect rectFor1PxStroke(CGRect rect);
@end
