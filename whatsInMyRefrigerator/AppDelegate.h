//
//  AppDelegate.h
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/3/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryTVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *store;

-(void)loadstore;

@end

