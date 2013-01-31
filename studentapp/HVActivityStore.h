//
//  HVActivityStore.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HVError;
@class HVActivityStore;
@protocol HVActivityStoreDelegate <NSObject>

- (void)ActivityStore:(HVActivityStore *)store dataIsReadyForView:(HVError *)error;

@end

@class HVActivity;
@interface HVActivityStore : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableArray  *allActivities;
    NSURLConnection *connection;
    NSMutableData   *dataReceived;
    NSString        *feedURL;
}

@property (nonatomic, weak) id <HVActivityStoreDelegate> webConnectionDelegate;

+ (HVActivityStore *)sharedInstance;

- (NSMutableArray *)allActivites;
- (void)addActivity:(HVActivity *)activity;
- (void)addAllActivitiesFromWebService;
- (void)addActivitiesFromTestData;
- (void)moveActivityFromIndex:(int)from toIndex:(int)to;
- (void)startFetchingFromWebServiceWithURL:(NSURL *)url;
@end
