//
//  BTDeviceManagerDelegate.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//
/**
 Callbacks for the UI to implement when using the BTDeviceManager class.
 */

#import <Foundation/Foundation.h>

@protocol BTDeviceManagerDelegate <NSObject>

- (void) updateUIWithConnection;
- (void) updateUIWithDisconnection;
- (void) updateUIWithDiscovery;

@end
