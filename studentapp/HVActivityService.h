//
//  HVActivityService.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-17.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RaptureXML/RXMLElement.h"

@interface HVActivityService : NSObject <NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *baseURL;
    BOOL fetchingIsDone;
}

- (void)startFetching;
- (BOOL)fetchingIsDone;

- (NSURL *)urlToFetchFrom;
@end
