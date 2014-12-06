//
//  InventoryItemTVC.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/6/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryItemTVC : UITableViewController

@property(nonatomic, strong) NSMutableArray *inventoryItemarr;

-(IBAction)AddingItem:(id)sender;

@end
