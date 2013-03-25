//
//  HVNews.h
//  studentapp
//
//  Created by Ulf Andersson on 2013-03-24.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVNews : NSObject

@property (nonatomic) int               basePriority;
@property (nonatomic) int               priority;
@property (nonatomic) BOOL              isVisible;
@property (nonatomic) BOOL              hasBeenRead;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
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
