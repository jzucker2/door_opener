//
//  BLEInfo.h
//  DoorOpener
//
//  Created by Jordan Zucker on 9/30/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#ifndef DoorOpener_BLEInfo_h
#define DoorOpener_BLEInfo_h

#define BEACON_PROXIMITY_UUID   [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]

// Local notifications for our app
#define NOTIF_KEY               @"BOYD CROWDER IS AWESOME"

// Beacons are hardcoded into our app so we can easily filter for them in a noisy environment
// The Id below is major+minor
//#define BEACON_0                @"1507110507"
//#define BEACON_1                @"4556564072"
//#define BEACON_2                @"6046356367"
//#define BEACON_3                @"4967229621"
//#define BEACON_4                @"54450962"
//#define BEACON_5                @"236807349"

#define BEACON_MAJOR            @85
#define BEACON_MINOR            @12794

// Alternative beacon ids to use with CoreBluetooth, which is much more responsive in the akcgroun
#define BEACON_0_ID             @"5A47AB5D-186C-4FD2-BEE0-D3D5F675109F"
#define BEACON_1_ID             @"0B6ADD2C-12B8-A1FA-AC6C-089A79F9B141"
#define BEACON_2_ID             @"2D6668D7-D464-B8A3-8FE6-DE87756FA020"
#define BEACON_3_ID             @"D53043D8-3F91-7DBD-DF64-7F7C4F738904"
#define BEACON_4_ID             @"358DF9DD-D0B6-0D04-0E8A-483CE397679D"
#define BEACON_5_ID             @"F76C345E-C7B1-5581-66C7-EA6589B9C6E4"

#endif
