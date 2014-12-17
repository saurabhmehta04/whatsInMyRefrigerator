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

NSDate *dateTime;

@synthesize productTitle;
@synthesize productTitleFromCameraScanner;


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    //NSLog(@"username: %@",self.username);
    //NSLog(@"String value %@", productTitleFromCameraScanner);
    productTitle.text = productTitleFromCameraScanner;
    self.qty.text = self.qtyFromInvent;
     self.category.text = self.qtytypeFromInvent;
     self.edate.text = self.edateFromInvent;
     if ([self.favfromInvent integerValue]==1) {
         //NSLog(@"ATHV: %@",self.favfromInvent);
     [self.favval setOn:YES];
     }else{
        // NSLog(@"ATHV: %@",self.favfromInvent);
     [self.favval setOn:NO];
     }


    UIDatePicker *pickerDate = [[UIDatePicker alloc]init];
//    pickerDate.datePickerMode = UIDatePickerModeDate;
    [pickerDate setMinimumDate: [NSDate date]];
    [self.edate setInputView:pickerDate];
    
    [pickerDate setDate:[NSDate date]];
    [pickerDate addTarget:self action:@selector(updateTime:) forControlEvents:UIControlEventValueChanged];
    [self.edate setInputView:pickerDate];

    //    tap to dismiss
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    

    
}

- (IBAction)updateTime:(id)sender {
    if([self.edate isFirstResponder]){ 
        UIDatePicker *picker = (UIDatePicker*)self.edate.inputView;
        dateTime = picker.date;
        NSLog(@"updated date is ====> %@", dateTime);

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *myDateString = [dateFormatter stringFromDate: [picker date]];
        
        self.edate.text = myDateString;
    }
    
}

-(void)dismissKeyboard {
    [self.qty resignFirstResponder];
    [self.category resignFirstResponder];
    [self.productTitle resignFirstResponder];
    [self.edate resignFirstResponder];
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
    NSString *msg=@"";
    BOOL f1=true,f2=true;
    if(self.productTitle.text==@""){
        msg = [msg stringByAppendingString:@"Product Titile cannot be left blank"];
        f1 = false;
    }else if (self.edate.text==@""){
        msg = [msg stringByAppendingString:@"Expiraton Date cannot be Blank"];
        f2 = false;
    }
    if (f1==true && f2 == true) {
        Middlelayer *ml = [[Middlelayer alloc]init];
        NSString *str = @"http://localhost/inventoryitemsupdate.php?arg1=";
        str = [str stringByAppendingString:self.username];
        str = [str stringByAppendingString:@"&arg2="];
        str = [str stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"fridge"]];
        str = [str stringByAppendingString:@"&arg3="];
        if ([self.productTitle.text isEqualToString:self.productTitleFromCameraScanner]) {
            str = [str stringByAppendingString:self.productTitle.text];
        }else{
            str = [str stringByAppendingString:self.productTitleFromCameraScanner];
        }
        str = [str stringByAppendingString:@"&arg4="];
        str = [str stringByAppendingString:self.qty.text];
        str = [str stringByAppendingString:@"&arg5="];
        str = [str stringByAppendingString:self.category.text];
        str = [str stringByAppendingString:@"&arg6="];
        str = [str stringByAppendingString:self.edate.text];
        str = [str stringByAppendingString:@"&arg7="];
        NSString *bol = self.favval.isOn ? @"1" : @"0";
        str = [str stringByAppendingString:bol];
        if (![self.productTitle.text isEqualToString:self.productTitleFromCameraScanner]) {
            str = [str stringByAppendingString:@"&arg8="];
            str = [str stringByAppendingString:self.productTitle.text];
        }
        //NSLog(@"STRing: %@",str);
        
        NSArray *dicta = [ml downloadItems:str];
     
        if([self addToFav]){
            Middlelayer *ml = [[Middlelayer alloc]init];
            NSString *str = @"http://localhost:8888/inventoryitemsupdate.php?arg1=";
            str = [str stringByAppendingString:self.username];
            str = [str stringByAppendingString:@"&arg2="];
            str = [str stringByAppendingString:self.productTitle.text];
            str = [str stringByAppendingString:@"&arg3="];
            str = [str stringByAppendingString:self.category.text];
            NSArray *dicta = [ml downloadItems:str];
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Favourites!!!"
                                                            message:@"Added to Favourites"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];

        }
        //NSLog(@"Name: %@",dicta);
        //NSDictionary *dict = (NSDictionary *)dicta[0];
    }else{
        
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Product Detail Invalid!!!"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (IBAction)setNotification:(UIButton *)sender {
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    NSLog(@"Date time set is  ================ > %@", dateTime);
    localNotification.fireDate = dateTime;
    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", dateTime];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (BOOL)addToFav {
    //NSLog(@"Val: %d",self.favval.isOn);
    return self.favval.isOn;
}
@end
