//
//  BTDeviceManager.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BTDeviceManagerDelegate.h"

@interface BTDeviceManager : NSObject <CBCentralManagerDelegate>

@property (strong, nonatomic) id<BTDeviceManagerDelegate> managerDelegate;

@property (strong, nonatomic) NSMutableArray *peripherals;
@property (strong, nonatomic) NSMutableArray *selectedPeripherals;


@end
