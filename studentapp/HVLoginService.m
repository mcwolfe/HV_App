//
//  HVLoginService.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "HVLoginService.h"
#import "RXMLElement.h"
#import "HVError.h"

@implementation HVLoginService

@synthesize delegate;

/*-------------------------------------------------
 * Beskrivning: Gör en koppling mot HV's server för att
 * validera användarnamn och lösenord. Metoden påbörjar ett
 * NSUrlRequest som sedan anropas connection:didReciveData.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)validateLoginWithUsername:(NSString *)username password:(NSString *)pass {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableString *completeString = [[NSMutableString alloc] init];
    
    [completeString appendString:username];
    [completeString appendString:pass];
    
    NSString *loginHash = [self generateHashWithString:completeString];
    
    lastUsedHash = loginHash;
    
    data = [[NSMutableData alloc] init];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self urlToFetchFromWithHasch:loginHash]];
    
    connection = [[NSURLConnection alloc] initWithRequest:request
                                                 delegate:self
                                         startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)receivedata {
    [data appendData:receivedata];
}

/*-------------------------------------------------
 * Beskrivning: Anropas när anslutning är färdig och
 * har lyckats ta emot all data.
 *
 * Viktigt: Anropas inte om någonting gått fel på vägen.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *xmlString = [[NSString alloc]initWithData:data
                                               encoding:NSISOLatin1StringEncoding];
    
    RXMLElement *root = [[RXMLElement alloc] initFromXMLString:xmlString
                                                      encoding:NSISOLatin1StringEncoding];
    
    RXMLElement *channel = [root child:@"channel"];
    
    NSArray *items = [channel children:@"item"];
    
    //Om det inte finns några items att hämta så innebär det att inloggningen misslyckades (i dagsläget).
    if([items count] < 1) {
        [self.delegate loginService:self
              didFinishLoginWithError:[HVError loginFailedWrongCredentials]];
    } else {
        [self.delegate loginService:self
               didFinishLoginWithHash:lastUsedHash];
    }
}

/*-------------------------------------------------
 * Beskrivning: Anropas om något går fel när data hämtas.
 *
 * Viktigt: Anropas bara om något fel med kopplingen uppstår.
 *
 * Return: void.
 ------------------------------------------------*/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self.delegate loginService:self didFinishLoginWithError:[HVError errorFromNSError:error]];
}

/*-------------------------------------------------
 * Beskrivning: Genererar en SHA256 kryptering av
 * den NSString som skickas med som argument.
 *
 * Return: En SHA256 krypterad NSString.
 ------------------------------------------------*/
- (NSString *)generateHashWithString:(NSString *)inString {
    const char *input = [inString UTF8String];
    
    Byte result[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(input, strlen(input), result);
    
    //Takes the unsigned char result and converts it into NSMutableString
    NSMutableString *toReturn = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    
    for(int i = 0;i < CC_SHA256_DIGEST_LENGTH; i++) {
        [toReturn appendFormat:@"%02x",result[i]];
    }
    
    return toReturn;
}

/*-------------------------------------------------
 * Beskrivning: Gör om en NSString till hexadecimal.
 *
 * Return: NSString med hexadecimalt värde.
 ------------------------------------------------*/
- (NSString *)stringToHex:(NSString *)string {
    const char *utf8 = [string UTF8String];
    
    NSMutableString *hex = [NSMutableString string];
    
    while ( *utf8 ) [hex appendFormat:@"%02X" , *utf8++ & 0x00FF];
    
    return [NSString stringWithFormat:@"%@", hex];
}

/*-------------------------------------------------
 * Beskrivning: Bygger på den befintliga strängen mot
 * HV's server med en hasch-sträng som motsvarar användarens
 * inloggningsuppgifter.
 *
 * Return: NSUrl mot HV's server.
 ------------------------------------------------*/
- (NSURL *)urlToFetchFromWithHasch:(NSString *)hasch {
    NSMutableString *temp = [[NSMutableString alloc] init];
    
    [temp appendString:@"https://mittkonto.hv.se/public/appfeed/app_rss.php?app_key="];
    [temp appendString:hasch];
    
    NSURL *url = [NSURL URLWithString:temp];
    
    return url;
}

@end
