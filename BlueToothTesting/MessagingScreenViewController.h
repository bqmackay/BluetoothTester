//
//  MessagingScreenViewController.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/18/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTDeviceManager.h"

@interface MessagingScreenViewController : UITableViewController
@property (strong, nonatomic) BTDeviceManager *deviceManager;
@end
