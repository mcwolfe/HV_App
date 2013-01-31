//
//  HVActivityService.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-17.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVActivityService.h"

@implementation HVActivityService

- (id)init
{
    self = [super init];
    if (self) {
        baseURL = @"https://mittkonto.hv.se/public/appfeed/app_rss.php?app_key=";
        fetchingIsDone = NO;
    }
    return self;
}
- (BOOL)fetchingIsDone
{
    return fetchingIsDone;
}

- (void)startFetching
{
    data = [[NSMutableData alloc] init];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self urlToFetchFrom]];
    connection = [[NSURLConnection alloc] initWithRequest:request
                                                 delegate:self
                                         startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incomingData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [data appendData:incomingData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSString *xmlResponse = [[NSString alloc] initWithData:data
                                                  encoding:NSISOLatin1StringEncoding];
    NSLog(@"%@", xmlResponse);
    fetchingIsDone = YES;
}

- (NSURL *)urlToFetchFrom
{
    NSURL *url = [NSURL URLWithString:@"https://mittkonto.hv.se/public/appfeed/app_rss.php?app_key=3efd5d52327ec5a2014e38b3133717da6c6069a9ff39398ec313ba4a77c7a9eb"];
    
    return url;
}

@end
