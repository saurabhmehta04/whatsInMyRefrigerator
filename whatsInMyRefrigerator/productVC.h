//
//  productVC.h
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/11/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cameraScanner.h"

@interface productVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *productTitle;
@property (weak, nonatomic) IBOutlet UITextField *qty;
@property (weak, nonatomic) IBOutlet UITextField *qtytype;
@property (weak, nonatomic) IBOutlet UITextField *pdate;
@property (weak, nonatomic) IBOutlet UITextField *edate;

@property(nonatomic, retain) NSString *productTitleFromCameraScanner;

-(IBAction)submit:(id)sender;

@end
