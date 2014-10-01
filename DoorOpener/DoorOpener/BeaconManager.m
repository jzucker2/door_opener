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
        
        //_registeredBeacons = [[NSMutableSet alloc] initWithArray:@[BEACON_0, BEACON_1]];
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

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [_locationManager requestStateForRegion:_region];
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    switch (state) {
        case CLRegionStateInside:
        {
            NSLog(@"CLRegionStateInside");
            [_locationManager startRangingBeaconsInRegion:_region];
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
    [_locationManager startRangingBeaconsInRegion:_region];
    [self sendNotification:@"didEnterRegion"];
    
    if ([UIApplication sharedApplication].applicationState==UIApplicationStateBackground) {
        [self.locationManager startRangingBeaconsInRegion:self.region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [_locationManager stopRangingBeaconsInRegion:_region];
    
    NSLog(@"didExitRegion");
    [self sendNotification:@"didExitRegion"];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"LM didRangeBeacons");
    
    // print out all beacons
    for (CLBeacon *beacon in beacons)
    {
        //NSString *uuid = beacon.proximityUUID.UUIDString;
        NSString *major = [NSString stringWithFormat:@"%@", beacon.major];
        NSString *minor = [NSString stringWithFormat:@"%@", beacon.minor];
        
        // HACK ALERT: We use major + minor as key
//        if ([self.registeredBeacons containsObject:[NSString stringWithFormat:@"%@%@", major, minor]])
        if ([beacon.major isEqualToNumber:BEACON_MAJOR] && [beacon.minor isEqualToNumber:BEACON_MINOR]) {
            NSString *beaconKey = [NSString stringWithFormat:@"%@%@", major, minor];
            
            if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive)
            {
                
                NSString *distance;
                if(beacon.proximity == CLProximityUnknown) {
                    distance = @"Unknown Proximity";
                } else if (beacon.proximity == CLProximityImmediate) {
                    distance = @"Immediate";
                } else if (beacon.proximity == CLProximityNear) {
                    distance = @"Near";
                } else if (beacon.proximity == CLProximityFar) {
                    distance = @"Far";
                } else {
                    return;
                }
                
                // Fire delegate
                NSLog(@"LM major:%@ minor:%@ distance:%@", major, minor, distance);
                if ([_delegate respondsToSelector:@selector(discoveredBeacon:distance:)]) {
                    [_delegate discoveredBeacon:beaconKey distance:distance];
                }
                //[_delegate discoveredBeacon:beaconKey distance:distance];
            }
            else if ([UIApplication sharedApplication].applicationState==UIApplicationStateBackground)
            {
                [self sendNotification:beaconKey];
            }
        }
    }
}

#pragma mark - Local Notifications

-(void)sendNotification:(NSString*)message
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date];
    NSTimeZone* timezone = [NSTimeZone defaultTimeZone];
    notification.timeZone = timezone;
    notification.alertBody = message;
    notification.alertAction = @"Show";  //creates button that launches app
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber=[[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
    
    // to pass information with notification
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:message forKey:NOTIF_KEY];
    notification.userInfo = userDict;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
