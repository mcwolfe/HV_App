//
//  HVNewsStore.h
//  studentapp
//
//  Created by Ulf Andersson on 2013-03-24.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HVError;
@class HVNewsStore;

@protocol HVNewsStoreDelegate <NSObject>

-(void)NewsStore:(HVNewsStore *)store dataIsReadyForView:(HVError *)error;

@end

@class HVNews;

@interface HVNewsStore : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableArray  *allNews;
    NSURLConnection *connection;
    NSMutableData   *dataRecieved;
    NSString    *feedURL;
}

@property (nonatomic, weak) id <HVNewsStoreDelegate> webConnectionDelegate;

+(HVNewsStore *) sharedInstance;

-(NSMutableArray *) allNews;
-(void)addNews:(HVNews *)newsItem;
-(void)addAllNewsFromWebService;
-(void)moveNewsItemFromIndex:(int)from toIndex:(int)to;
-(void)startFetchingFromWebServiceWithURL:(NSURL *)url;

@end
