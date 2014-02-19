//
//  NavViewController.m
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//
/**
 Home screen for the app. Allows the user to scan for devices and select which ones the user would like to connect to.
*/
#import "NavViewController.h"
#import "BTDeviceManager.h"
#import "MessagingScreenViewController.h"

@interface NavViewController ()
@property (strong, nonatomic) BTDeviceManager *deviceManager;
@end

@implementation NavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.deviceManager = [BTDeviceManager new];
    [self.deviceManager setManagerDelegate:self];}

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
    return [self.deviceManager.peripherals count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *selectedPeripheral = [self.deviceManager.peripherals objectAtIndex:indexPath.row];
    if ([self.deviceManager.selectedPeripherals containsObject:selectedPeripheral]) {
        [self.deviceManager cancelPeripheralConnection:selectedPeripheral];
        NSLog(@"Canceling connection...");
    } else {
        [self.deviceManager connectPeripheral:selectedPeripheral options:nil];
        NSLog(@"Establishing connection to %@...", selectedPeripheral.UUID);
    }
}

- (IBAction)scanButtonAction:(id)sender {
    NSLog(@"Log it out");
    if(self.deviceManager.isScanning) {
        [self.deviceManager stopScanning];
    } else {
        [self.deviceManager scanForMyLifterPeripherals];
    }
    
    [self updateButtonState];

}

- (void)groupButtonAction:(id)sender {
    NSLog(@"Grouping objects");
}

- (void) updateButtonState {
    if(self.deviceManager.isScanning) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"Scan" style:UIBarButtonItemStylePlain target:self action:@selector(scanButtonAction:)];
        [self.scanButton setRightBarButtonItem:button animated:YES];
    } else {
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:@"Stop Scanning" style:UIBarButtonItemStylePlain target:self action:@selector(scanButtonAction:)];
        [self.scanButton setRightBarButtonItem:button animated:YES];
    }
    self.deviceManager.isScanning = !self.deviceManager.isScanning;
}

//Device Manager Delegate
- (void)updateUIWithDiscovery {
    [self.tableView reloadData];
}

- (void)updateUIWithConnection {
    //TODO Update button state
    
    [self.tableView reloadData];
}

- (void)updateUIWithDisconnection {
    //TODO Update button state
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Prepping for Segue");
    MessagingScreenViewController *vc = segue.destinationViewController;
    vc.deviceManager = self.deviceManager;
}


@end
