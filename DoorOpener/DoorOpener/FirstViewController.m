//
//  FirstViewController.m
//  DoorOpener
//
//  Created by Jordan Zucker on 9/30/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import "FirstViewController.h"
#import "BeaconManager.h"

@interface FirstViewController () <BeaconManagerDelegate>

@property (nonatomic) BeaconManager *beaconManager;

@property (nonatomic, weak) IBOutlet UILabel *RSSILabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _beaconManager = [BeaconManager sharedBeaconManager];
    _beaconManager.delegate = self;
    
    [_beaconManager startMonitoringForRegion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BeaconManagerDelegate

- (void)discoveredBeacon:(NSString *)beaconKey distance:(NSString *)distance
{
    NSLog(@"View discoveredBeacon distance:%@", distance);
    _RSSILabel.text = distance;
}

@end
