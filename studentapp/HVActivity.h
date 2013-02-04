//
//  HVActivity.h
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVActivity : NSObject

@property (nonatomic) int               basePriority;
@property (nonatomic) int               priority;
@property (nonatomic) BOOL              isVisible;
@property (nonatomic) BOOL              hasBeenRead;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *activityDescription;
@property (nonatomic, retain) NSString *activityShortDescription;
@property (nonatomic, retain) NSString *tag;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *RSSSource;
@property (nonatomic, retain) NSString *guid;
@property (nonatomic, retain) NSDate   *publishedDate;
@property (nonatomic, retain) NSDate   *eventDateStart;
@property (nonatomic, retain) NSDate   *eventDateEnd;
@property (nonatomic, retain) NSURL    *url;
@property (nonatomic, retain) UIColor  *color;

+ (HVActivity *)createDummy;

- (id) initWithGuid:(NSString *)guid_
              title:(NSString *)title_
                url:(NSURL *)link_
   shortDescription:(NSString *)shortDesc
        description:(NSString *)desc
      publishedDate:(NSDate *)pubDate
          colorCode:(NSString *)code
           priority:(int)prio
       basePriority:(int)basePrio
         eventStart:(NSDate *)eStart
           eventEnd:(NSDate *)eEnd
          RSSSource:(NSString *)source
           category:(NSString *)cat
          isVisible:(BOOL)visible
                tag:(NSString *)tag_;
- (void)setColorWithCode:(NSString *)HVColorCode;
- (NSString *)eventDateString;
- (NSString *)publishedDateString;


@end
