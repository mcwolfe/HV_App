//
//  HVSettingsViewController.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-07.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVSettingsViewController.h"

@interface HVSettingsViewController ()

@end

@implementation HVSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Inställningar"];
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

@end
