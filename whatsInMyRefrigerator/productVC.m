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
  
}

- (IBAction)updateTime:(id)sender {
    if([self.edate isFirstResponder]){ 
        UIDatePicker *picker = (UIDatePicker*)self.edate.inputView;
        dateTime = picker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *myDateString = [dateFormatter stringFromDate: [picker date]];
        
        self.edate.text = myDateString;
    }
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldShouldReturn:self.productTitle];
    [self textFieldShouldReturn:self.qty];
    [self textFieldShouldReturn:self.category];
    [self textFieldShouldReturn:self.edate];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
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
    NSString *msg=@"";
    BOOL f1=true,f2=true;
    if([self.productTitle.text isEqualToString:@""]){
        msg = [msg stringByAppendingString:@"Product Titile cannot be left blank"];
        f1 = false;
    }else if ([self.edate.text isEqualToString:@""]){
        msg = [msg stringByAppendingString:@"Expiraton Date cannot be Blank"];
        f2 = false;
    }
    if (f1==true && f2 == true) {
        Middlelayer *ml = [[Middlelayer alloc]init];
        NSString *str = @"http://wtf.lokesh-cherukuri.com/inventoryitemsupdate.php?arg1=";
        str = [str stringByAppendingString:self.username];
        str = [str stringByAppendingString:@"&arg2="];
        str = [str stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"fridge"]];
        str = [str stringByAppendingString:@"&arg3="];
        if (self.productTitleFromCameraScanner.length!=0) {
            NSLog(@"PRd:%@",self.productTitleFromCameraScanner);
            if ([self.productTitle.text isEqualToString:self.productTitleFromCameraScanner]) {
                str = [str stringByAppendingString:self.productTitle.text];
            }else{
                str = [str stringByAppendingString:self.productTitleFromCameraScanner];
            }
        }else{
             str = [str stringByAppendingString:self.productTitle.text];
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
        if (!self.productTitleFromCameraScanner.length!=0) {
            if (![self.productTitle.text isEqualToString:self.productTitleFromCameraScanner]) {
                str = [str stringByAppendingString:@"&arg8="];
                str = [str stringByAppendingString:self.productTitle.text];
            }
        }
        NSArray *dicta = [ml downloadItems:str];
        if([self addToFav]){
            Middlelayer *ml = [[Middlelayer alloc]init];
            NSString *str = @"http://wtf.lokesh-cherukuri.com/inventoryitemsupdate.php?arg1=";
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
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }else{
        
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Product Detail Invalid!!!"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    
}

- (IBAction)setNotification:(UIButton *)sender {
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = dateTime;
    localNotification.alertBody = [NSString stringWithFormat:@"%@ is going to expire on %@", self.productTitle.text, dateTime];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (BOOL)addToFav {
    return self.favval.isOn;
}
@end
