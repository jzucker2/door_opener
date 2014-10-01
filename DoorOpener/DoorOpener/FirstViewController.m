//
//  FirstViewController.m
//  DoorOpener
//
//  Created by Jordan Zucker on 9/30/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import "FirstViewController.h"
#import "BeaconManager.h"

@interface FirstViewController ()

@property (nonatomic) BeaconManager *beaconManager;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _beaconManager = [BeaconManager sharedBeaconManager];
    
    [_beaconManager startMonitoringForRegion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
