//
//  HVNewsViewController.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-02-13.
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
#import "HVNews.h"
#import "HVNewsStore.h"
#import "HVNewsViewController.h"
#import "HVNewsDetailViewController.h"

@interface HVNewsViewController ()
@end

@implementation HVNewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    [[self navigationItem] setTitle:@"Nyheter på HV"];
    
    
    
    return self;
}

-(id)init{
    return [self initWithStyle:UITableViewStylePlain];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[HVNewsStore sharedInstance] setWebConnectionDelegate:(id)self];
    [[HVNewsStore sharedInstance] addAllNewsFromWebService];
    [self showLoading];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [[[HVNewsStore sharedInstance] allNews] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [indexPath row];

    static NSString *CellIdentifier = @"Cell";
    
    HVNews *newsItem =[[[HVNewsStore sharedInstance] allNews] objectAtIndex:index];
    
    HVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    
    if(cell==nil){
        cell = [[HVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell markAsRead:newsItem.hasBeenRead];
    cell.descriptionText.text = newsItem.description;
    cell.titleLabel.text = newsItem.title;
    cell.dateLabel.text = newsItem.publishedDateString;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    HVNews *newsItem = [[[HVNewsStore sharedInstance] allNews] objectAtIndex:[indexPath row]];
    
    newsItem.hasBeenRead = YES;
    HVNewsViewController *detailView = [[HVNewsViewController alloc] init];
    [detailView setNewsItem:newsItem];
    [[self navigationController] pushViewController:detailView animated:YES];
}
   

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


-(void)NewsStore:(HVNewsStore *)store dataIsReadyForView:(HVError *) error{
    [self hideLoading];
    
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error errorTitle] message:[error errorDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    [self reloadData:nil];
    
}

- (void)showLoading {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Förbereder din dag"];
}

- (void)hideLoading {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)reloadData:(id)sender {
    [[self tableView] reloadData];
}

@end
