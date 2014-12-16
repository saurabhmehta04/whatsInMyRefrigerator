//
//  InventoryItemTVC.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/6/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Middlelayer.h"
#import "FavouiteTVC.h"

@interface InventoryItemTVC : UITableViewController

@property(nonatomic, strong) NSMutableArray *inventoryItemarr;
@property(nonatomic, strong) NSString *username;

-(IBAction)AddingItem:(id)sender;

-(void) setupScanner;

@end
