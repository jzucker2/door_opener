//
//  BeaconManager.m
//  DoorOpener
//
//  Created by Jordan Zucker on 9/30/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import "BeaconManager.h"
@import CoreLocation;
#import "BLEInfo.h"

@interface BeaconManager () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSMutableSet *registeredBeacons;
@property (nonatomic) CLBeaconRegion *region;

@end

@implementation BeaconManager

+ (instancetype)sharedBeaconManager
{
    static dispatch_once_t once = 0;
    __strong static id _sharedBeaconManager = nil;
    dispatch_once(&once, ^{
        _sharedBeaconManager = [[self alloc] init];
    });
    return _sharedBeaconManager;
}

- (id)init
{
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        [_locationManager requestAlwaysAuthorization];
        
        _registeredBeacons = [[NSMutableSet alloc] initWithArray:@[BEACON_0, BEACON_1]];
        _region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_PROXIMITY_UUID identifier:@"Estimote Region"];
        
        //[_locationManager startMonitoringForRegion:_region];
        
    }
    return self;
}

#pragma mark - Public Methods

- (void)startMonitoringForRegion:(CLRegion *)region
{
    CLRegion *monitoringRegion = region;
    if (!monitoringRegion) {
        monitoringRegion = _region;
    }
    [_locationManager startMonitoringForRegion:monitoringRegion];
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"didChangeAuthorizationStatus");
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside:
        {
            NSLog(@"CLRegionStateInside");
        }
            break;
        case CLRegionStateOutside:
        {
            NSLog(@"CLRegionStateOutside");
        }
            break;
        case CLRegionStateUnknown:
        {
            NSLog(@"CLRegionStateUnknown");
        }
            break;
        default:
            NSLog(@"CLRegion is in unknown state");
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"didEnterRegion");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"didExitRegion");
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"LM didRangeBeacons");
}

@end
