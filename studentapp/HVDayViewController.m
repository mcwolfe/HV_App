//
//  HVDayViewController.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-05.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVDayViewController.h"
#import "HVLoginViewController.h"
#import "HVActivityDetailViewController.h"
#import "HVUserModel.h"
#import "HVActivityStore.h"
#import "HVActivity.h"
#import "HVCell.h"
#import "HVError.h"
#import "MBProgressHUD.h"
#import "HVCellBackground.h"
#import "HVSettingsViewController.h"

@interface HVDayViewController ()

@end

@implementation HVDayViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {

        [[self navigationItem] setTitle:@"Min dag på HV"];
        logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logga ut"
                                                        style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(logout:)];
        
        menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Meny"
                                                            style:UIBarButtonSystemItemAction
                                                           target:self
                                                           action:@selector(reloadData:)];
        [[self navigationItem] setLeftBarButtonItem:logOutButton];
        [[self navigationItem] setRightBarButtonItem:menuButton];
    }
    
    return self;
}

- (id)init {
    //Anropas designated init
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)dealloc {
    NSLog(@"Dealloc: %@", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    switch ([HVUserModel sharedInstance].loginStatus) {
        case HVLoggedIn:
            [[HVActivityStore sharedInstance] setWebConnectionDelegate:self];
            [[HVActivityStore sharedInstance] addAllActivitiesFromWebService];
            [self showLoading];
            break;
        case HVLoggedOut:
            [self logout:nil];
            break;
        case HVDemo:
            [[HVActivityStore sharedInstance] addActivitiesFromTestData];
            [[self tableView] reloadData];
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoading {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Förbereder din dag"];
}

- (void)hideLoading {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)logout:(id)sender {
    BOOL animated = NO;
    //Om sender är logout button så vill vi ha en animation. Annars vill vi inte ha en animation.
    if (sender == logOutButton) {
        animated = YES;
    }
    
    
    [[HVUserModel sharedInstance] setLoginStatus:HVLoggedOut];
    
    HVLoginViewController *loginView = [[HVLoginViewController alloc] init];
    
    [self presentViewController:loginView
                       animated:animated
                     completion:nil];
}

- (void)reloadData:(id)sender {
    
    HVSettingsViewController *svc = [[HVSettingsViewController alloc] init];
    [[self navigationController] pushViewController:svc animated:YES];
    //[[self tableView] reloadData];
}

#pragma mark - Table view data source

/*-------------------------------------------------
 * Beskrivning: Data source delegate från tableView.
 * Denna metod anropas först av tableViews data source delegate
 * för att veta hur många gånger den ska anropa tableView:numberOfRowsInSection:
 * 
 *
 * Return: Antalet sektioner som ska finnas i tableView
 ------------------------------------------------*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/*-------------------------------------------------
 * Beskrivning: Data source delegate från tableView.
 * tableView måste veta hur många rader det finns på
 * en viss sektion. Då vi just nu bara använder en sektion
 * så returnerar vi antalet på alla aktiviteter.
 *
 * Return: antalet rader som ska finnas för varje sektion i tableView.
 ------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[HVActivityStore sharedInstance] allActivites] count];
}

/*-------------------------------------------------
 * Beskrivning: Data source delegate från tableView.
 * Här sker kopplingen mellan vår "Store" (HVActivityStore) och tableViewn.
 * Till hjälp för att koppla rätt cell till rätt index så skickar
 * vår tableView med en indexPath varje gång. Index pathen berättar
 * vilken sektion och rad som den vill ha en cell för.
 *
 * Return: en egengjord HVCell för ett specifikt index i tableView.
 ------------------------------------------------*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Eftersom att vi än så länge bara har EN sektion så vill vi bara ha reda på vilken rad det gäller.
    int index = [indexPath row];
    
    //Utifrån vårt index kan vi plocka ut rätt aktivitet ur vår Store.
    HVActivity *activity = [[[HVActivityStore sharedInstance] allActivites] objectAtIndex:index];
    
    //För bättre minneshantering så kan vi välja att återanvända våra celler.
    //Det innebär att de celler som inte visas på skärmen läggs i en "pool"
    //Som kan återanvändas när de behövs.
    static NSString *CellIdentifier = @"Cell";
    
    //Försöker hämta en cell att återanvända från poolen med nyckeln "Cell"
    HVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Fanns det ingen cell att återanvända så skapar vi en ny.
    if (cell == nil) {
        cell = [[HVCell alloc] initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:CellIdentifier];
    }

    
    [cell markAsRead:activity.hasBeenRead];
    
    
    cell.descriptionText.text = activity.activityShortDescription;
    cell.tagLabel.text        = activity.tag;
    cell.dateLabel.text       = activity.publishedDateString;
    cell.titleLabel.text      = activity.title;
    
    [cell setSideColor:activity.color];
    
    //Har gjort en liten ändring
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HVActivity *activity = [[[HVActivityStore sharedInstance] allActivites] objectAtIndex:[indexPath row]];
    activity.hasBeenRead = YES;
    
    HVActivityDetailViewController *detailView = [[HVActivityDetailViewController alloc] init];
    [detailView setActivity:activity];
    
    [[self navigationController] pushViewController:detailView
                                           animated:YES];
}

#pragma mark Activity Store Delegate

- (void)ActivityStore:(HVActivityStore *)store dataIsReadyForView:(HVError *)error {
    [self hideLoading];
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error errorTitle]
                                                        message:[error errorDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    [self reloadData:nil];
}
@end
