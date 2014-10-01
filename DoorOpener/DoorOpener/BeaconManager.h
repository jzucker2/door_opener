//
//  BeaconManager.h
//  DoorOpener
//
//  Created by Jordan Zucker on 9/30/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BeaconManager, CLRegion;

@protocol BeaconManagerDelegate <NSObject>

@end

@interface BeaconManager : NSObject

+ (instancetype)sharedBeaconManager;

@property (nonatomic) id <BeaconManagerDelegate> delegate;

- (void)startMonitoringForRegion:(CLRegion *)region;

@end
