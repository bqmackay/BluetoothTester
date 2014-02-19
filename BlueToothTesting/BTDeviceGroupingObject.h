//
//  BTDeviceGroupingObject.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/14/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTDeviceGroupingObject : NSObject

@property (strong, nonatomic) NSUUID *uuid;
@property BOOL isConnected;

@end
