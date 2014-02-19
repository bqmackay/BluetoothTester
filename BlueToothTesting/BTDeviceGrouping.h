//
//  BTGrouping.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/14/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTDeviceGrouping : NSObject

@property (strong, nonatomic) NSString *groupName;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSMutableArray *myLifterDevices;
@property int numberOfConnectedDevices;
@property int status;

@end
