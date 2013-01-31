//
//  HVViewController.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-04.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVLoginViewController.h"
#import "HVDayViewController.h"
#import "HVLoginService.h"
#import "HVUserModel.h"
#import "HVActivityDetailViewController.h"
#import "MBProgressHUD.h"
#import "HVError.h"

@interface HVLoginViewController ()

@end

@implementation HVLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationPageSheet;
        
        loginService = [[HVLoginService alloc] init];
        progressHUD  = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [loginService setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //Om användaren är på usernameField och trycker next..
    if (textField == usernameField) {
        //Flytta fokus till passwordField.
        [passwordField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self login:nil];
    }
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-------------------------------------------------
 * Beskrivning: Anropas om användaren trycker någonstans
 * på vyn. (Vyn är förövrigt ändrad till typen
 * controller, precis som en knapp eller textfield.
 *
 * Return: void
 ------------------------------------------------*/
- (IBAction)viewTapped:(id)sender {
    [[self view] endEditing:YES];
}

/*-------------------------------------------------
 * Beskrivning: Anropas när loginButton trycks ner.
 * Kontrollerar användarnamn och lösenord mot
 * HVLoginService. Om användarnuppgifterna stämmer
 * så försvinner login vyn, om inte så visas ett fel.
 *
 * Return: void
 * TODO: Prata med HVLoginService
 ------------------------------------------------*/
- (IBAction)login:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
                                              animated:YES];
    hud.labelText = @"Laddar";
    
    NSString *username = [usernameField text];
    NSString *password = [passwordField text];
    
    [loginService validateLoginWithUsername:username
                                   password:password];

}

- (IBAction)demo:(id)sender {
    [[HVUserModel sharedInstance] setLoginStatus:HVDemo];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark HVLoginServiceDelegate

- (void)loginService:(HVLoginService *)sender
didFinishLoginWithError:(HVError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.errorTitle
                                                    message:error.errorDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    
    [alert show];
}
- (void)loginService:(HVLoginService *)sender
didFinishLoginWithHash:(NSString *)hash {
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
    
    [[HVUserModel sharedInstance] setLoginStatus:HVLoggedIn];
    [[HVUserModel sharedInstance] setHasch:hash];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
@end
