//
//  HVError.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-18.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVError.h"

@implementation HVError
@synthesize errorCode;
@synthesize errorDescription;
@synthesize errorTitle;

- (id)init
{
    self = [self initWithDescription:@"empty error description"
                                code:0
                          errorTitle:@""];
    return self;
}

- (id)initWithDescription:(NSString *)description code:(int)eCode errorTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        errorCode = eCode;
        errorDescription = description;
        errorTitle = title;
    }
    return self;
}

+ (HVError *)errorFromNSError:(NSError *)error {
    return [[HVError alloc] initWithDescription:[error localizedDescription]
                                           code:[error code]
                                     errorTitle:[NSString stringWithFormat:@"Felkod: %d", [error code]]];
}

+ (HVError *)loginFailedWrongCredentials
{
    return [[HVError alloc] initWithDescription:@"Fel användarnamn eller lösenord"
                                           code:1
                                     errorTitle:@"Kunde inte logga in"];
}
+ (HVError *)loginFailedWebserviceDown
{
    return [[HVError alloc] initWithDescription:@"Inloggningsservericen är nere för tillfället. Vänligen försök snart igen."
                                           code:2
                                     errorTitle:@"Kunde inte logga in"];
}
+ (HVError *)loginFailedRequestTimedOut
{
    return [[HVError alloc] initWithDescription:@"Inloggningen gjorde timeout. Har du täckning till internet?"
                                           code:3
                                     errorTitle:@"Kunde inte logga in"];
}


@end
