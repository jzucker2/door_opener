//
//  BeaconManager.h
//  DoorOpener
//
//  Created by Jordan Zucker on 9/30/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BeaconManager, CLRegion;

@protocol BeaconManagerDelegate <NSObject>

@optional

- (void)discoveredBeacon:(NSString *)beaconKey distance:(NSString *)distance;

@end

@interface BeaconManager : NSObject

+ (instancetype)sharedBeaconManager;

@property (nonatomic) id <BeaconManagerDelegate> delegate;

- (void)startMonitoringForRegion:(CLRegion *)region;

@end
