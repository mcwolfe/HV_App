//
//  HVError.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-18.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVError : NSObject

@property (nonatomic) int               errorCode;
@property (nonatomic, retain) NSString *errorDescription;
@property (nonatomic, retain) NSString *errorTitle;

+ (HVError *)errorFromNSError:(NSError *)error;
+ (HVError *)loginFailedWrongCredentials;
+ (HVError *)loginFailedWebserviceDown;
+ (HVError *)loginFailedRequestTimedOut;

- (id)initWithDescription:(NSString *)description code:(int)eCode errorTitle:(NSString *)title;


@end
