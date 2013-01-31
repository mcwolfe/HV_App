//
//  HVLoginService.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HVError;
@class HVLoginService;

@protocol HVLoginServiceDelegate
@optional
- (void)loginService:(HVLoginService *)sender didFinishLoginWithHash:(NSString *)hash;
- (void)loginService:(HVLoginService *)sender didFinishLoginWithError:(HVError *)error;
@end

@interface HVLoginService : NSObject <NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *lastUsedHash;
}

@property (nonatomic, weak) id <HVLoginServiceDelegate> delegate;

- (NSString *)generateHashWithString:(NSString *)inString;
- (void)validateLoginWithUsername:(NSString *)username password:(NSString *)pass;

@end
