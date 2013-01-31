//
//  HVUserModel.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-05.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//
//-------------------------------------------------
// Innehåller info om användaren.
//
//-------------------------------------------------
#import "HVUserModel.h"

@implementation HVUserModel

@synthesize hasch;

/*-------------------------------------------------
 * Beskrivning: init. Inte tänkt att använda så
 * därför anropas singleton konstruktorn.
 *
 * Return: HVUserModel's singleton.
 ------------------------------------------------*/
- (id)init {
    NSLog(@"%@: använd [HVUserModel sharedInstance] istället.", self);
    return [HVUserModel sharedInstance];
}

/*-------------------------------------------------
 * Beskrivning: Designated init
 *
 * Return: ny instance av HVUserModel
 ------------------------------------------------*/
- (id)initForSingleton {
    self = [super init];
    if (self) {
        
    }
    return self;
}

//Class methods
/*-------------------------------------------------
 * Beskrivning: Singleton för HVUserModel
 * Return: statiskt objekt av HVUserModel
 ------------------------------------------------*/
+ (HVUserModel *) sharedInstance {
    static HVUserModel *shared;
    
    if (!shared) {
        shared = [[HVUserModel alloc] initForSingleton];
    }
    
    return shared;
}

//Properties
/*-------------------------------------------------
 * Beskrivning: Setter för om användaren ska vara
 * inloggad eller inte. Datum för när användaren
 * loggade in sätts också om value är YES
 *
 * Return: void
 ------------------------------------------------*/
- (void)setLoginStatus:(HVLoginStatus)status {
    if (status == HVLoggedIn) {
        dateLoggedIn = [NSDate date];
    }
    loginStatus = status;
}
/*-------------------------------------------------
 * Beskrivning: Getter för om användaren är inloggad.
 *
 * Return: NO om inget datum är satt, annars värdet
 * av loggedIn
 ------------------------------------------------*/
- (HVLoginStatus)loginStatus {
    if (loginStatus == HVDemo) {
        return HVDemo;
    }
    
    if (!hasch) {
        return HVLoggedOut;
    }
    
    return loginStatus;
}
@end
