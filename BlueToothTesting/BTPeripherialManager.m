//
//  BTPeripherialManager.m
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/14/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

/**
 This class should not be implemented by any other class except the BTDeviceManager. The BTPeripheralManager manages communications with the bluetooth devices (peripherals).
 */

#import "BTPeripherialManager.h"
#import "Constants.h"

@interface BTPeripherialManager()


@property (strong, nonatomic) CBUUID *dataFromUUID;
@property (strong, nonatomic) CBUUID *dataToUUID;
@property (strong, nonatomic) NSMutableDictionary *dataFromCharacteristics;
@property (strong, nonatomic) NSMutableDictionary *dataToCharacteristics;

@end

@implementation BTPeripherialManager

- (id)init {
    
    self.dataFromUUID = [CBUUID UUIDWithString:dataFromStringUUID];
    self.dataToUUID = [CBUUID UUIDWithString:dataToStringUUID];
    
    self.dataFromCharacteristics = [NSMutableDictionary new];
    self.dataToCharacteristics = [NSMutableDictionary new];
    
    return [super init];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"Discovered peripheral %@", peripheral.UUID);
    for (CBService *service in peripheral.services) {
        if([service.UUID isEqual:[CBUUID UUIDWithString:myLifterServiceUUID]]) {
            NSLog(@"  Searching for characteristics in service %@", service.UUID);
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {

    NSArray *characteristics = [service characteristics];
    for (CBCharacteristic *characteristic in characteristics){
        if([[characteristic UUID] isEqual:self.dataFromUUID] && ![[self.dataFromCharacteristics allKeys] containsObject:[self getUUID:peripheral.UUID]]) {
            NSLog(@"Adding peripheral for name %@", peripheral.UUID);
            [self.dataFromCharacteristics setObject:characteristic forKey:[self getUUID:peripheral.UUID]];
        }
        else if ([[characteristic UUID] isEqual:self.dataToUUID] && ![[self.dataToCharacteristics allKeys] containsObject:[self getUUID:peripheral.UUID]]) {
            [self.dataToCharacteristics setObject:characteristic forKey:[self getUUID:peripheral.UUID]];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {

    NSLog(@"Characteristic value is updated: %@", [characteristic.value description]);
    
    if (error) {
        NSLog(@"Error updating characterist value: %@", [error localizedDescription]);
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {

    NSLog(@"Characteristic value was written: %@", [characteristic.value description]);
    
    if (error) {
        NSLog(@"Error writing characterist value: %@", [error localizedDescription]);
    }
    
    [self readDataFromlastCommand:peripheral];
    
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {}


- (void)readDataFromlastCommand:(CBPeripheral *)peripheral {
    [peripheral readValueForCharacteristic:[self.dataFromCharacteristics objectForKey:[self getUUID:peripheral.UUID]]];
}

- (void)sendCommand:(int)command toPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Sending command");
    const char bytes[] = {*[self getCharForMessage:command], *COMMAND_NACK};
    size_t length = (sizeof bytes) - 1; //string literals have implicit trailing '\0'
    NSData *data = [NSData dataWithBytes:&bytes length:length];
    
    [peripheral writeValue:data forCharacteristic:[self.dataToCharacteristics objectForKey:[self getUUID:peripheral.UUID]] type:CBCharacteristicWriteWithResponse];
}

- (void)clearPeripheralData:(CBPeripheral *)peripheral {
    [self.dataFromCharacteristics removeObjectForKey:[self getUUID:peripheral.UUID]];
    [self.dataToCharacteristics removeObjectForKey:[self getUUID:peripheral.UUID]];
}


- (const char *) getCharForMessage:(int)command {
    switch (command) {
        case PERIPHERAL_COMMAND_STOP:
            return COMMAND_STOP;
        case PERIPHERAL_COMMAND_TOP:
            return COMMAND_TOP;
        case PERIPHERAL_COMMAND_BOTTOM:
            return COMMAND_BOTTOM;
        case PERIPHERAL_COMMAND_ZERO:
            return COMMAND_ZERO;
        case PERIPHERAL_COMMAND_UP:
            return COMMAND_UP;
        case PERIPHERAL_COMMAND_DOWN:
            return COMMAND_DOWN;
        case PERIPHERAL_COMMAND_SYNC:
            return COMMAND_SYNC;
        case PERIPHERAL_COMMAND_ERROR:
            return COMMAND_ERROR;
        case PERIPHERAL_COMMAND_DEBUG:
            return COMMAND_DEBUG;
        case PERIPHERAL_COMMAND_CAL_TOP:
            return COMMAND_CAL_TOP;
        case PERIPHERAL_COMMAND_CAL_BOTTOM:
            return COMMAND_CAL_BOTTOM;
        case PERIPHERAL_COMMAND_GET_LINK_ITEM:
            return COMMAND_LINK_ITEM_GET;
        case PERIPHERAL_COMMAND_SET_LINK_ITEM:
            return COMMAND_LINK_ITEM_SET;
        case PERIPHERAL_COMMAND_GET_LINK_INFO:
            return COMMAND_LINK_INFO_GET;
        case PERIPHERAL_COMMAND_SET_LINK_INFO:
            return COMMAND_LINK_INFO_SET;
        case PERIPHERAL_COMMAND_LIFE_CYCLE:
            return COMMAND_LIFT_CYCLE;
        case PERIPHERAL_COMMAND_PING:
            return COMMAND_PING;
        default:
            return nil;
    }
}

- (NSString *)getUUID:(CFUUIDRef)uuid
{
    CFUUIDRef theUUID = uuid;
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
//    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

@end
