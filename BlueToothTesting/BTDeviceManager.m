//
//  BTDeviceManager.m
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import "BTDeviceManager.h"
#import "Constants.h"

@interface BTDeviceManager()

@property (strong, nonatomic) NSMutableArray *peripheralUUIDs;

@property (strong, nonatomic) CBCentralManager *central;

@property (strong, nonatomic) CBUUID *dataFromUUID;
@property (strong, nonatomic) CBUUID *dataToUUID;

@end

@implementation BTDeviceManager

- (id)init {
    
    self.peripherals = [NSMutableArray new];
    self.selectedPeripherals = [NSMutableArray new];
    self.peripheralUUIDs = [NSMutableArray new];
    self.dataFromUUID = [CBUUID UUIDWithString:dataFromStringUUID];
    self.dataToUUID = [CBUUID UUIDWithString:dataToStringUUID];
    
    self.central = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    return [super init];
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Discovered Peripheral");
    if(![self.peripheralUUIDs containsObject:peripheral.UUID]){
        NSLog(@"Adding Peripheral");
        [self.peripherals addObject:peripheral];
        [self.peripheralUUIDs addObject:peripheral.UUID];
        [self.managerDelegate updateUI];
//        [self.tableView reloadData];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connected to peripheral %@", peripheral.name);
    
    [self.selectedPeripherals addObject:peripheral];
    
    [self.managerDelegate updateUI];
    
//    NSString *buttonTitle = [NSString stringWithFormat:@"Send Message (%d)", self.selectedPeripherals.count];
//    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage:)];
//    [self.scanButton setRightBarButtonItem:button animated:YES];
//    
//    [peripheral setDelegate:self];
//    
//    [self.tableView reloadData];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Disconnected to peripheral %@", peripheral.name);
    
    [self.selectedPeripherals removeObject:peripheral];
    
    [self.managerDelegate updateUI];
    
//    UIBarButtonItem *button;
//    
//    if(self.selectedPeripherals.count > 0) {
//        NSString *buttonTitle = [NSString stringWithFormat:@"Send Message (%d)", self.selectedPeripherals.count];
//        button = [[UIBarButtonItem alloc]initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage:)];
//    } else {
//        button = [[UIBarButtonItem alloc]initWithTitle:@"Scan" style:UIBarButtonItemStylePlain target:self action:@selector(scanButtonAction:)];
//    }
//    
//    [self.scanButton setRightBarButtonItem:button animated:YES];
//    
//    [self.tableView reloadData];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}


@end
