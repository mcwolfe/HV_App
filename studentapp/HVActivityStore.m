//
//  HVActivityStore.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//
//-------------------------------------------------
// Håller ordning på alla HVActivity som kommer skapas
// uppdateras och ta bort. Denna klassen kommer även
// innehålla logik för hur objekten konverteras från
// HV's webservice till HVActivity objekt.
//
// Läs på mer om: MVCS - Model View Controller Store
//-------------------------------------------------
#import "HVActivityStore.h"
#import "HVActivity.h"
#import "HVUserModel.h"
#import "RaptureXML/RXMLElement.h"

@implementation HVActivityStore

@synthesize webConnectionDelegate;

/*-------------------------------------------------
 * Beskrivning: Designated init för HVActivityStore.
 *
 * Viktigt: Anropa inte denna metoden. Använd singleton
 * instancen sharedInstance istället.
 *
 * Return: Initierad HVActivityStore.
 ------------------------------------------------*/
- (id)init {
    self = [super init];
    
    if (self) {
        allActivities = [[NSMutableArray alloc] init];
        feedURL       = @"https://mittkonto.hv.se/public/appfeed/app_rss.php?app_key=";
    }
    
    return self;
}

/*-------------------------------------------------
 * Beskrivning: singleton instance för HVActivityStore
 *
 * Return: statiskt objekt av HVActivityStore
 ------------------------------------------------*/
+ (HVActivityStore *)sharedInstance {
    static HVActivityStore *store;
    
    if (!store) {
        store = [[HVActivityStore alloc] init];
    }
    
    return store;
}

/*-------------------------------------------------
 * Beskrivning: Getter för allActivites
 *
 * Return: Alla aktiviteter som finns i HVActivityStore.
 ------------------------------------------------*/
- (NSMutableArray *)allActivites {
    return allActivities;
}

/*-------------------------------------------------
 * Beskrivning: Flyttar en HVActivity i HVActivityStore
 * från ett index till ett annat. Användbart om ett view objekt
 * behöver flyttas och modellen behöver uppdateras.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)moveActivityFromIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    
    HVActivity *activity = [allActivities objectAtIndex:from];
    
    [allActivities removeObjectAtIndex:from];
    [allActivities insertObject:activity
                        atIndex:to];
}

/*-------------------------------------------------
 * Beskrivning: Lägger till en HVActivitity i HVActivityStore.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)addActivity:(HVActivity *)activity {
    [allActivities addObject:activity];
}

/*-------------------------------------------------
 * Beskrivning: Ersätter de aktiviter i HVActivityStore
 * med HVActivity's från testdata i demodata.xml.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)addActivitiesFromTestData {
    NSError *error = nil;
    NSString *testDataFilePath = [[NSBundle mainBundle] pathForResource:@"demodata"
                                                                 ofType:@"xml"];
    
    NSString *testXMLData = [NSString stringWithContentsOfFile:testDataFilePath
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
    if (error) {
        NSLog(@"%@ XML Error: %@", self, [error description]);
        @throw @"XML Testdata";
    }
    NSArray *XMLActivities = [self generateActivitiesFromXMLWithString:testXMLData];
    
    [allActivities removeAllObjects];
    [allActivities addObjectsFromArray:XMLActivities];
    
}

/*-------------------------------------------------
 * Beskrivning: Anropar startFetchingFromHVWebService.
 * Skillnaden mot denna metod och ovannämnd är att denna
 * är deklarerad i .h filen.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)addAllActivitiesFromWebService {
    [self startFetchingFromHVWebService];
}

#pragma mark XML och NSURLConnection hantering

/*-------------------------------------------------
 * Beskrivning: Anropar startFetchingFromWebServiceWithURL:
 * med URL:en till HV's server.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)startFetchingFromHVWebService {
    [self startFetchingFromWebServiceWithURL:[self HVWebserviceURL]];
}

/*-------------------------------------------------
 * Beskrivning: Påbörjar hämtning omedelbart från en URL,
 * och initierar ("nollställer") dataRecivied.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)startFetchingFromWebServiceWithURL:(NSURL *)url {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    dataReceived          = [[NSMutableData alloc] init];
    connection            = [[NSURLConnection alloc] initWithRequest:request
                                                            delegate:self
                                                    startImmediately:YES];
}

/*-------------------------------------------------
 * Beskrivning: Anropas varje gång anslutningen tar
 * emot data. Datan som vi tar emot samlar i i vår
 * NSMutableData "data".
 *
 * Return: void.
 ------------------------------------------------*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incomingData {
    [dataReceived appendData:incomingData];
}

/*-------------------------------------------------
 * Beskrivning: Anropas när anslutningen är färdig
 * och har lyckats.
 *
 * Viktigt: Anropas inte om anslutningen misslyckas.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *xmlResponse  = [[NSString alloc] initWithData:dataReceived
                                                  encoding:NSISOLatin1StringEncoding];
    NSArray *XMLActivities = [self generateActivitiesFromXMLWithString:xmlResponse];
    
    dataReceived = nil;
    
    [allActivities removeAllObjects];
    [allActivities addObjectsFromArray:XMLActivities];
    
    [[self webConnectionDelegate] ActivityStore:self
                             dataIsReadyForView:nil];
}

/*-------------------------------------------------
 * Beskrivning: Genererar en array med HVActivity's
 * från en string.
 *
 * Return: HVActivity Array.
 ------------------------------------------------*/
- (NSArray *)generateActivitiesFromXMLWithString:(NSString *)xmlString {
    RXMLElement     *rootElement = [[RXMLElement alloc] initFromXMLString:xmlString
                                                             encoding:NSISOLatin1StringEncoding];
    RXMLElement     *channel     = [rootElement child:@"channel"];
    NSArray         *items       = [channel children:@"item"];
    NSMutableArray  *activities  = [[NSMutableArray alloc] initWithCapacity:items.count];
    NSDateFormatter *formatter   = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    
    for (RXMLElement *XMLActivity in items) {

        
        RXMLElement *guid             = [XMLActivity child:@"guid"];
        RXMLElement *title            = [XMLActivity child:@"title"];
        RXMLElement *shortDescription = [XMLActivity child:@"shortDescription"];
        RXMLElement *description      = [XMLActivity child:@"description"];
        RXMLElement *pubdate          = [XMLActivity child:@"pubDate"];
        RXMLElement *color            = [XMLActivity child:@"color"];
        RXMLElement *priority         = [XMLActivity child:@"priority"];
        RXMLElement *source           = [XMLActivity child:@"source"];
        RXMLElement *category         = [XMLActivity child:@"category"];
        RXMLElement *tag              = [XMLActivity child:@"tag"];
        
        HVActivity *newActivity = [[HVActivity alloc] initWithGuid:guid.text
                                                             title:title.text
                                                               url:nil
                                                  shortDescription:shortDescription.text
                                                       description:description.text
                                                     publishedDate:[formatter dateFromString:[NSString stringWithFormat:@"%@", pubdate.text]]
                                                         colorCode:color.text
                                                          priority:priority.text.intValue
                                                      basePriority:0
                                                        eventStart:nil
                                                          eventEnd:nil
                                                         RSSSource:source.text
                                                          category:category.text
                                                         isVisible:YES
                                                               tag:tag.text];
        
        NSLog(@"%@", [newActivity publishedDateString]);
        [activities addObject:newActivity];
    }
    
    return activities;
    
}

/*-------------------------------------------------
 * Beskrivning: Sammanställer en NSURL till HV's server.
 * använder sig av HVUserModel och den haschsträng som ligger
 * lagrad där.
 *
 * Return: NSURL till hv's server.
 ------------------------------------------------*/
- (NSURL *)HVWebserviceURL {
    NSMutableString *tempurl = [[NSMutableString alloc] init];
    
    [tempurl appendString:feedURL];
    [tempurl appendString:[HVUserModel sharedInstance].hasch];
    
    NSURL *url = [NSURL URLWithString:tempurl];
    
    return url;
}
@end
