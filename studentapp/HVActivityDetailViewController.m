//
//  HVActivityDetailViewController.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-08.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVActivityDetailViewController.h"
#import "HVActivity.h"
@interface HVActivityDetailViewController ()

@end

@implementation HVActivityDetailViewController
@synthesize activity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        showOnMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Hitta hit"
                                                           style:UIBarButtonSystemItemAction
                                                          target:self
                                                          action:@selector(showMap:)];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"Dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [titleLabel  setText:self.activity.title];
    [tagLabel    setText:self.activity.tag];
    [textContent setText:self.activity.activityDescription];
    [colorView   setBackgroundColor:self.activity.color];
    
    [self.navigationItem setTitle:self.activity.title];
    [self.navigationItem setRightBarButtonItem:showOnMapButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMap:(id)sender {
    
}

@end
