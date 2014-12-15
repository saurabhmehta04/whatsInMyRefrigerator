//
//  productVC.m
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/11/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "productVC.h"

@interface productVC ()

@end

@implementation productVC

@synthesize productTitle;
@synthesize productTitleFromCameraScanner;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSLog(@"username: %@",self.username);
    NSLog(@"String value %@", productTitleFromCameraScanner);
    
        productTitle.text = productTitleFromCameraScanner;
    
    
    
    NSDateFormatter *obj_date_formatter = [[NSDateFormatter alloc] init];
    [obj_date_formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    NSDateFormatter *my_date_formatter = [[NSDateFormatter alloc] init];
    [my_date_formatter setDateFormat:@"dd/MM/yy"];
    
    IBOutlet UIDatePicker *myDatePicker;
    myDatePicker.date = [my_date_formatter dateFromString:[obj_date_formatter stringFromDate:[NSDate date]]];
    
}


-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.edate.inputView;
    self.edate.text = [NSString stringWithFormat:@"%@",picker.date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submit:(id)sender {
    NSLog(@"Submit button clicked");
}


@end
