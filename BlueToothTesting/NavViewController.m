//
//  NavViewController.m
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import "NavViewController.h"
#import "Constants.h"
#import "BTDeviceManager.h"

@interface NavViewController ()

@property (strong, nonatomic) BTDeviceManager *deviceManager;

@end

@implementation NavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.deviceManager = [BTDeviceManager new];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSArray *characteristics = [service characteristics];
    for (CBCharacteristic *characteristic in characteristics){
        if([[characteristic UUID] isEqual:self.dataFromUUID]) {
            NSLog(@"   Discovered dataFrom characteristic %@", characteristic.UUID);
//            [peripheral readValueForCharacteristic:characteristic];
        }
        else if ([[characteristic UUID] isEqual:self.dataToUUID]) {
            NSLog(@"   Discovered dataTo characteristic %@", characteristic.UUID);

            const char bytes[] = {*COMMAND_TOP, *COMMAND_NACK};
            size_t length = (sizeof bytes) - 1; //string literals have implicit trailing '\0'
            
            NSData *data = [NSData dataWithBytes:&bytes length:length];
            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Characteristic value is updated: %@", [characteristic.value description]);
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSString *str = [NSString stringWithCharacters:[characteristic.value bytes] length:[characteristic.value length]];
    NSLog(@"Characteristic value was written: %@", str);

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {

}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PeripheralCell"];
    
    CBPeripheral *peripheral = [self.deviceManager.peripherals objectAtIndex:indexPath.row];
    [cell.textLabel setText:peripheral.name];
    
    if([self.deviceManager.selectedPeripherals containsObject:peripheral]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.peripherals count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *selectedPeripheral = [self.peripherals objectAtIndex:indexPath.row];
    if ([self.selectedPeripherals containsObject:selectedPeripheral]) {
        [self.central cancelPeripheralConnection:selectedPeripheral];
        NSLog(@"Canceling connection...");
    } else {
        [self.central connectPeripheral:selectedPeripheral options:nil];
        NSLog(@"Establishing connection...");
    }
}

- (IBAction)scanButtonAction:(id)sender {
    NSLog(@"Log it out");
    if(self.deviceManager.isScanning) {
        [self.central stopScan];
    } else {
        [self.central scanForPeripheralsWithServices:nil options:nil];
    }
    
    [self updateButtonState];

}

- (void)sendMessage:(id)sender {
    NSLog(@"Sending message...");
    for(CBPeripheral *peripheral in self.selectedPeripherals) {
        [peripheral discoverServices:nil];
    }
}

- (void) updateButtonState {
    if(self.isScanning) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"Scan" style:UIBarButtonItemStylePlain target:self action:@selector(scanButtonAction:)];
        [self.scanButton setRightBarButtonItem:button animated:YES];
    } else {
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"Scanning..." style:UIBarButtonItemStylePlain target:self action:@selector(scanButtonAction:)];
        [self.scanButton setRightBarButtonItem:button animated:YES];
    }
    self.isScanning = !self.isScanning;
}

//Device Manager Delegate
- (void)updateUI {
    NSLog(@"Updating UI");
    [self.tableView reloadData];
}

@end
