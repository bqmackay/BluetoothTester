//
//  BTDeviceManager.m
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

/**
 The main responsibility of the BTDeviceManager is to manager the connections to the bluetooth devices (peripherals). It also acts as the mediator by which a view controller communicates with the devices. The view controller should instantiate (directly or indirectly) the BTDeviceManagerDelegate to receive callbacks.
 */

#import "BTDeviceManager.h"
#import "BTPeripherialManager.h"
#import "Constants.h"

@interface BTDeviceManager()

@property (strong, nonatomic) NSMutableArray *peripheralUUIDs;
@property (strong, nonatomic) CBCentralManager *central;
@property (strong, nonatomic) BTPeripherialManager *peripheralManager;

@end

@implementation BTDeviceManager

- (id)init {
    
    self.peripherals = [NSMutableArray new];
    self.selectedPeripherals = [NSMutableArray new];
    self.peripheralUUIDs = [NSMutableArray new];
    
    self.central = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.peripheralManager = [BTPeripherialManager new];
    
    return [super init];
    
}

- (void)scanForAllPeripherals {
    [self.central scanForPeripheralsWithServices:nil options:nil];
}

- (void)scanForMyLifterPeripherals {
    NSLog(@"Scanning for saved peripherals");
    NSArray *services = [NSArray arrayWithObject:[CBUUID UUIDWithString:myLifterServiceUUID]];
    [self.central scanForPeripheralsWithServices:services options:nil];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Discovered Peripheral");
    if(![self.peripheralUUIDs containsObject:peripheral.UUID]){
        NSLog(@"Adding Peripheral");
        [peripheral setDelegate:self.peripheralManager];
        [self.peripherals addObject:peripheral];
        [self.peripheralUUIDs addObject:peripheral.UUID];
        
        [self.managerDelegate updateUIWithDiscovery];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connected to peripheral %@", peripheral.name);
    [self.selectedPeripherals addObject:peripheral];
    NSArray *services = [NSArray arrayWithObject:[CBUUID UUIDWithString:myLifterServiceUUID]];
    [peripheral discoverServices:services];
    
    [self.managerDelegate updateUIWithConnection];
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Disconnected to peripheral %@", peripheral.name);
    [self.selectedPeripherals removeObject:peripheral];
    if(error != nil){
        NSLog(@"Error occured: %@", error);
        NSLog(@"Reconnection...");
        [self.central connectPeripheral:peripheral options:nil];
    }
    [self.peripheralManager clearPeripheralData:peripheral];
    
    [self.managerDelegate updateUIWithDisconnection];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"State was updated");
}

- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral {
    [self.central cancelPeripheralConnection:peripheral];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options {
    [self.central connectPeripheral:peripheral options:options];
}

- (void)stopScanning {
    [self.central stopScan];
}

- (void)sendCommandToSelectedPeripherals:(int)command {
    for(CBPeripheral *peripheral in self.selectedPeripherals) {
         [self.peripheralManager sendCommand:command toPeripheral:peripheral];
    }
    
}

- (void)removePeripherals {
    for(CBPeripheral *peripheral in self.peripherals) {
        [self.peripheralManager clearPeripheralData:peripheral];
    }
    [self.peripherals removeAllObjects];
    [self.peripheralUUIDs removeAllObjects];
    [self.managerDelegate updateUIWithConnection];
}

@end
