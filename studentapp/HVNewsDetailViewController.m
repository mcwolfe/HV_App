//
//  HVNewsDetailViewController.m
//  studentapp
//
//  Created by Ulf Andersson on 2013-03-24.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVNewsDetailViewController.h"
#import "HVNews.h"
@interface HVNewsDetailViewController ()

@end

@implementation HVNewsDetailViewController
@synthesize newsItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [titleLabel setText:self.newsItem.title];
    [textContent setText:self.newsItem.description];
    
    [self.navigationItem setTitle:self.newsItem.title];
}

@end
