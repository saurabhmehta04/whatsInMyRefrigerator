//
//  InventoryTVC.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/6/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryItemTVC.h"

@interface InventoryTVC : UITableViewController

@property(nonatomic, strong) NSMutableArray *inventoryarr;

-(IBAction)Adding:(id)sender;

@end
