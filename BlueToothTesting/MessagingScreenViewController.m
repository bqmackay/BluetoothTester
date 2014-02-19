//
//  MessagingScreenViewController.m
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/18/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//
/**
 Displays a list of commands that user can send to the connected bluetooth devices
 */

#import "MessagingScreenViewController.h"
#import "Constants.h"
#import "BTDeviceManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface MessagingScreenViewController ()
@end

@implementation MessagingScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *cellTitle = [NSString new];
    
    switch(indexPath.row) {
        case PERIPHERAL_COMMAND_STOP:
            cellTitle = @"Stop";
            break;
        case PERIPHERAL_COMMAND_TOP:
            cellTitle = @"Top";
            break;
        case PERIPHERAL_COMMAND_BOTTOM:
            cellTitle = @"Bottom";
            break;
        case PERIPHERAL_COMMAND_ZERO:
            cellTitle = @"Zero";
            break;
        case PERIPHERAL_COMMAND_UP:
            cellTitle = @"Up";
            break;
        case PERIPHERAL_COMMAND_DOWN:
            cellTitle = @"Down";
            break;
        case PERIPHERAL_COMMAND_SYNC:
            cellTitle = @"Sync";
            break;
        case PERIPHERAL_COMMAND_ERROR:
            cellTitle = @"Error";
            break;
        case PERIPHERAL_COMMAND_DEBUG:
            cellTitle = @"Debug";
            break;
        case PERIPHERAL_COMMAND_CAL_TOP:
            cellTitle = @"Calebrate Top";
            break;
        case PERIPHERAL_COMMAND_CAL_BOTTOM:
            cellTitle = @"Calebrate Bottom";
            break;
        case PERIPHERAL_COMMAND_GET_LINK_ITEM:
            cellTitle = @"Get Link Item";
            break;
        case PERIPHERAL_COMMAND_SET_LINK_ITEM:
            cellTitle = @"Set Link Item";
            break;
        case PERIPHERAL_COMMAND_GET_LINK_INFO:
            cellTitle = @"Get Link Info";
            break;
        case PERIPHERAL_COMMAND_SET_LINK_INFO:
            cellTitle = @"Set Link Info";
            break;
        case PERIPHERAL_COMMAND_LIFE_CYCLE:
            cellTitle = @"Life Cycle";
            break;
        case PERIPHERAL_COMMAND_PING:
            cellTitle = @"Ping";
        default:
            cellTitle = @"No title set";
            break;
    }
    
    [cell.textLabel setText:cellTitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [self.deviceManager sendCommandToSelectedPeripherals:indexPath.row];
}

@end
