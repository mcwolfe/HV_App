//
//  HVNewsStore.m
//  studentapp
//
//  Created by Ulf Andersson on 2013-03-24.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVNewsStore.h"
#import "HVNews.h"
#import "HVUserModel.h"
#import "RaptureXML/RXMLElement.h"

@implementation HVNewsStore

@synthesize webConnectionDelegate;

/*-------------------------------------------------
 * Beskrivning: Designated init för HVActivityStore.
 *
 * Viktigt: Anropa inte denna metoden. Använd singleton
 * instancen sharedInstance istället.
 *
 * Return: Initierad HVActivityStore.
 ------------------------------------------------*/

-(id)init{
    self = [super init];
    
    if(self){
        allNews = [[NSMutableArray alloc] init];
        feedURL = @"http://www.hv.se/feeds/nyheter.xml";
    }
    return self;
}

/*-------------------------------------------------
 * Beskrivning: singleton instance för HVNewsStore
 *
 * Return: statiskt objekt av HVNewsStore
 ------------------------------------------------*/

+(HVNewsStore *) sharedInstance {
    static HVNewsStore *store;
    if(!store){
        store = [[HVNewsStore alloc] init];
    }
    return store;
}

/*-------------------------------------------------
 * Beskrivning: Getter för allNews
 *
 * Return: Alla aktiviteter som finns i allNews.
 ------------------------------------------------*/

-(NSMutableArray *) allNews{
    return allNews;
}

/*-------------------------------------------------
 * Beskrivning: Flyttar en HVNewsItem i HVNewsStore
 * från ett index till ett annat. Användbart om ett view objekt
 * behöver flyttas och modellen behöver uppdateras.
 *
 * Return: void.
 ------------------------------------------------*/


-(void)moveNewsItemFromIndex:(int)from toIndex:(int)to
{
    if(from==to){
        return;
    }
    HVNews *newsItem = [allNews objectAtIndex:from];
    [allNews removeObjectAtIndex:from];
    [allNews insertObject:newsItem atIndex:to];
}

/*-------------------------------------------------
 * Beskrivning: Lägger till en HVActivitity i HVActivityStore.
 *
 * Return: void.
 ------------------------------------------------*/
-(void)addNews:(HVNews *)newsItem{
    
    for(HVNews *n in self.allNews){
        if([n.guid isEqualToString:newsItem.guid]){
            return;
        }
    }
    [allNews addObject:newsItem];
}

-(void)addNewsFromArray:(NSArray *)news{
    for(HVNews *n in news){
        [self addNews:n];
    }
}

/*-------------------------------------------------
 * Beskrivning: Anropar startFetchingFromHVWebService.
 * Skillnaden mot denna metod och ovannämnd är att denna
 * är deklarerad i .h filen.
 *
 * Return: void.
 ------------------------------------------------*/
-(void) addAllNewsFromWebService{
    [self startFetchingFromHVWebService];
}


-(void) startFetchingFromHVWebService{
    [self startFetchingFromWebServiceWithURL:[self HVWebserviceURL]];
}

#pragma mark hantering av XML och NSURLConnection

/*-------------------------------------------------
 * Beskrivning: Påbörjar hämtning omedelbart från en URL,
 * och initierar ("nollställer") dataRecivied.
 *
 * Return: void.
 ------------------------------------------------*/

-(void)startFetchingFromWebServiceWithURL:(NSURL *)url{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLRequest *request   = [[NSURLRequest alloc]initWithURL:url];
    dataRecieved            = [[NSMutableData alloc] init];
    connection              = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

/*-------------------------------------------------
 * Beskrivning: Anropas varje gång anslutningen tar
 * emot data. Datan som vi tar emot samlar i i vår
 * NSMutableData "data".
 *
 * Return: void.
 ------------------------------------------------*/

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incomingData{
    [dataRecieved appendData:incomingData];
}
/*-------------------------------------------------
 * Beskrivning: Anropas när anslutningen är färdig
 * och har lyckats.
 *
 * Viktigt: Anropas inte om anslutningen misslyckas.
 *
 * Return: void.
 ------------------------------------------------*/

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *xmlResponse   = [[NSString alloc] initWithData:dataRecieved encoding:NSISOLatin1StringEncoding];
    
    NSArray *xmlNews        = [self generateNewsFromXMLWithString:xmlResponse];
    
    dataRecieved            = nil;
    
    [self addNewsFromArray:xmlNews];
    
    [[self webConnectionDelegate] NewsStore:self dataIsReadyForView:nil];

}

/*-------------------------------------------------
 * Beskrivning: Genererar en array med HVNews
 * från en string.
 *
 * Return: HVNews Array.
 ------------------------------------------------*/

-(NSArray *) generateNewsFromXMLWithString:(NSString *)xmlString{
    RXMLElement     *rootElement        =[[RXMLElement alloc]
                                          initFromXMLString:xmlString
                                          encoding:NSISOLatin1StringEncoding];
    
    RXMLElement     *channel            =[rootElement child:@"channel"];
    NSArray         *items              =[channel children:@"item"];
    NSMutableArray  *news               =[[NSMutableArray alloc] initWithCapacity:items.count];
    NSDateFormatter *formatter          =[[NSDateFormatter alloc] init];
    NSLocale        *formatterLocale   =[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    NSURL           *tempurl            =[NSURL URLWithString:@"http://www.hv.se"];
    
    [formatter setLocale:formatterLocale];
    [formatter setDateFormat:@"EEE, dd MMM yyy HH:mm:ss Z"];
    
    for (RXMLElement *XMLItem in items){
        RXMLElement *guid           =   [XMLItem child:@"guid"];
        RXMLElement *title          =   [XMLItem child:@"title"];
        RXMLElement *description    =   [XMLItem child:@"description"];
        RXMLElement *date           =   [XMLItem child:@"dc:date"];
        
        HVNews *newNewsItem         =   [[HVNews alloc]
                                         initWithGuid:guid.text
                                         title:title.text
                                         url:tempurl
                                         shortDescription:@"Minsann"
                                         description:description.text
                                         publishedDate:[formatter dateFromString:date.text]
                                         colorCode:@"3_disco_"
                                         priority:1
                                         basePriority:1
                                         eventStart:[formatter dateFromString:date.text]
                                         eventEnd:[formatter dateFromString:date.text]
                                         RSSSource:nil
                                         category:nil
                                         isVisible:YES
                                         tag:nil];
        
        [news addObject:newNewsItem];
        
        
    }
    return news;
}
/*-------------------------------------------------
 * Beskrivning: Sammanställer en NSURL till HV's server.
 * använder sig av HVUserModel och den haschsträng som ligger
 * lagrad där.
 *
 * Return: NSURL till hv's server.
 ------------------------------------------------*/

-(NSURL *)HVWebserviceURL{
    NSMutableString *tempurl=[[NSMutableString alloc] init];
    [tempurl appendString:feedURL];
    NSURL *url = [NSURL URLWithString:tempurl];
    return url;
}

@end
