//
//  HVNews.m
//  studentapp
//
//  Created by Ulf Andersson on 2013-03-24.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVNews.h"

@implementation HVNews

@synthesize title;
@synthesize description;
@synthesize url;
@synthesize basePriority;
@synthesize priority;
@synthesize isVisible;
@synthesize hasBeenRead;
@synthesize eventDateStart;
@synthesize eventDateEnd;
@synthesize publishedDate;
@synthesize tag;
@synthesize activityShortDescription;
@synthesize category;
@synthesize color;

/*-------------------------------------------------
 * Beskrivning: Designated init för HVNews.
 *
 * Return: Initierad HvNews med alla egenskaper satta.
 ------------------------------------------------*/
- (id)initWithGuid:(NSString *)guid_
             title:(NSString *)title_
               url:(NSURL *)   link
  shortDescription:(NSString *)shortDesc
       description:(NSString *)desc
     publishedDate:(NSDate *)  pubDate
         colorCode:(NSString *)code
          priority:(int)       prio
      basePriority:(int)       basePrio
        eventStart:(NSDate *)  eStart
          eventEnd:(NSDate *)  eEnd
         RSSSource:(NSString *)source
          category:(NSString *)cat
         isVisible:(BOOL)      visible
               tag:(NSString *)tag_ {
    self = [super init];
    
    if (self) {
        self.guid                     = guid_;
        self.title                    = title_;
        self.url                      = link;
        self.activityShortDescription = shortDesc;
        self.description              = desc;
        self.publishedDate            = pubDate;
        self.priority                 = prio;
        self.basePriority             = basePrio;
        self.eventDateStart           = eStart;
        self.eventDateEnd             = eEnd;
        self.RSSSource                = source;
        self.category                 = cat;
        self.isVisible                = visible;
        self.tag                      = tag_;
        
        [self setColorWithCode:code];
    }
    
    return self;
}

/*-------------------------------------------------
 * Beskrivning: initiering av HvNews.
 *
 * Return: initierad instans av HvNews.
 ------------------------------------------------*/
- (id)init
{
    return [self initWithGuid:@""
                        title:@""
                          url:nil
             shortDescription:@""
                  description:@""
                publishedDate:nil
                    colorCode:@""
                     priority:0
                 basePriority:0
                   eventStart:nil
                     eventEnd:nil
                    RSSSource:@""
                     category:@""
                    isVisible:YES
                          tag:@""];
}

/*-------------------------------------------------
 * Beskrivning: Setter för color. Omvandlar den färgkod
 * till rätt typ av UIColor. Om koden inte finns tillgänlig
 * så sätts color till [UIColor purpleColor].
 *
 * Return: void.
 ------------------------------------------------*/
-(void)setColorWithCode:(NSString *)HVColorCode {
    
    if ([HVColorCode isEqualToString:@"3_ladokreg_"]) {
        color = [UIColor redColor];
    } else if ([HVColorCode isEqualToString:@"3_ladoktenta_"]) {
        color = [UIColor colorWithRed:133.0f/255.0f
                                green:152.0f/255.0f
                                 blue:39.0f/255.0f
                                alpha:1.0f];
    } else if ([HVColorCode isEqualToString:@"1_disco_"]) {
        color = [UIColor colorWithRed:98.0f/255.0f
                                green:255.0f/255.0f
                                 blue:48.0f/255.0f
                                alpha:1.0f];
    } else if ([HVColorCode isEqualToString:@"3_disco_"]) {
        color = [UIColor colorWithRed:47.0f/255.0f
                                green:222.0f/255.0f
                                 blue:123.0f/255.0f
                                alpha:1.0f];
    } else if ([HVColorCode isEqualToString:@"1_disco-kronox_"]) {
        color = [UIColor colorWithRed:100.0f/255.0f
                                green:184.0f/255.0f
                                 blue:175.0f/255.0f
                                alpha:1.0f];
    } else if ([HVColorCode isEqualToString:@"2_disco-kronox_"]) {
        color = [UIColor colorWithRed:132.0f/255.0f
                                green:40.0f/255.0f
                                 blue:249.0f/255.0f
                                alpha:1.0f];
    } else if ([HVColorCode isEqualToString:@"3_disco-kronox_"]) {
        color = [UIColor colorWithRed:255.0f/255.0f
                                green:155.0f/255.0f
                                 blue:55.0f/255.0f
                                alpha:1.0f];
    } else {
        NSLog(@"Ej satt färgkod: %@", HVColorCode);
        color = [UIColor purpleColor];
    }
}

/*-------------------------------------------------
 * Beskrivning: Getter för tag. Lägger till en brädgård
 * på det befintliga värdet som kännetecknar en hashtag
 *
 * Return: En hashtag för aktiviteten.
 ------------------------------------------------*/
- (NSString *)tag {
    NSMutableString *tagString = [[NSMutableString alloc] init];
    
    [tagString appendString:@"#"];
    [tagString appendString:tag];
    
    return tagString;
}



/*-------------------------------------------------
 * Beskrivning: Formatterar eventDateStart och eventDateEnd.
 *
 * Return: NSString med start och slutdatum.
 ------------------------------------------------*/
- (NSString *)eventDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSMutableString *builder   = [[NSMutableString alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [builder stringByAppendingFormat:@"%@ - %@",
            [formatter stringFromDate:self.eventDateStart],
            [formatter stringFromDate:self.eventDateEnd]];
}

- (NSString *)publishedDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"dd/MM - HH:mm"
                                                             options:0
                                                              locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
    [formatter setDateFormat:formatString];
    return [formatter stringFromDate:self.publishedDate];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@: %@", self, title, description];
}
@end
