//
//  NavViewController.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BTDeviceManagerDelegate.h"

@interface NavViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, BTDeviceManagerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *scanButton;

- (IBAction)groupButtonAction:(id)sender;

@end
