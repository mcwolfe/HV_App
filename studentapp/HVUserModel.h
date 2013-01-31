//
//  HVUserModel.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-05.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//
//  

#import <Foundation/Foundation.h>

typedef enum {
    HVLoggedIn = 1,
    HVLoggedOut,
    HVDemo
} HVLoginStatus;

@interface HVUserModel : NSObject
{
    HVLoginStatus loginStatus;
    NSDate       *dateLoggedIn;
}

@property (nonatomic, retain) NSString *hasch;

+ (HVUserModel *)sharedInstance;

- (void)setLoginStatus:(HVLoginStatus)status;
- (HVLoginStatus)loginStatus;
@end
