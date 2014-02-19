//
//  BTPeripherialManager.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/14/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BTPeripherialManager : NSObject <CBPeripheralDelegate, CBPeripheralManagerDelegate>

- (void)readDataFromlastCommand:(CBPeripheral *) peripheral;
- (void)sendCommand:(int)command toPeripheral:(CBPeripheral *)peripheral;
- (void)clearPeripheralData:(CBPeripheral *)peripheral;

@end
