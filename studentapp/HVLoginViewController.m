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
        
        [self initLoginTable];
        loginService = [[HVLoginService alloc] init];
        [loginService setDelegate:self];
        progressHUD  = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return self;
}

-(void)initLoginTable
{
    CGRect parentBounds = [[self view] bounds];
    CGSize tableSize = CGSizeMake(300, 110);
    CGPoint originPoint = CGPointMake(parentBounds.size.width / 2 - tableSize.width / 2, parentBounds.size.height / 2 - tableSize.height / 2);
    
    loginTable = [[UITableView alloc] initWithFrame:CGRectMake(originPoint.x, originPoint.y, tableSize.width, tableSize.height)
                                              style:UITableViewStyleGrouped];
    
    
    [loginTable setBackgroundView:nil];
    [loginTable setBackgroundColor:[UIColor clearColor]];
    
    [loginTable setDelegate:self];
    [loginTable setDataSource:self];
    
    [[self view] addSubview:loginTable];
}

- (void)dealloc {
    NSLog(@"Dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark UITableview delegate and datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (indexPath.row == 0) {
        usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
        usernameField.placeholder = @"Användarnamn";
        usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
        usernameField.textAlignment = NSTextAlignmentCenter;
        usernameField.delegate = self;
        cell.accessoryView = usernameField;
    }
    if (indexPath.row == 1) {
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
        passwordField.placeholder = @"Lösenord";
        passwordField.secureTextEntry = YES;
        passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
        passwordField.textAlignment = NSTextAlignmentCenter;
        passwordField.delegate = self;
        
        cell.accessoryView = passwordField;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
