//
//  MyLifterDevice.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/19/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MyLifterDevice : NSObject

@property (strong, nonatomic) CBPeripheral *peripheral;
@property int status;

- (void) connect;
//goUp, goDown, etc


@end
