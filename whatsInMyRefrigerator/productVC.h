//
//  productVC.h
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/11/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cameraScanner.h"
#import "Middlelayer.h"


@interface productVC : UIViewController

@property(nonatomic, strong) NSString *username;
@property (weak, nonatomic) IBOutlet UITextField *productTitle;
@property (weak, nonatomic) IBOutlet UITextField *qty;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *edate;
@property (weak, nonatomic) IBOutlet UISwitch *favval;

//- (IBAction)addToFav:(id)sender;

@property(nonatomic, retain) NSString *productTitleFromCameraScanner;
@property(nonatomic, retain) NSString *qtyFromInvent;
@property(nonatomic, retain) NSString *qtytypeFromInvent;
@property(nonatomic, retain) NSString *edateFromInvent;
@property(nonatomic, assign) NSString *favfromInvent;


- (IBAction)updateTime:(id)sender;
-(IBAction)submit:(id)sender;

@end

