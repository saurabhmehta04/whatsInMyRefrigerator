//
//  SubmitVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/11/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "SubmitVC.h"

#define USERNAME @"Email"
#define PASSWORD @"Email"
#define CFMPASS @"Email"
#define EMAIL @"Email"

@interface SubmitVC ()

@end



@implementation SubmitVC

-(IBAction)check:(id)sender{
//    UITextField *txt = (UITextField *)sender;
//    if ([txt.placeholder isEqualToString:USERNAME]) {
//        NSLog(@"text");
//    }
//    else if()
    NSLog(@"SEnder: %@",txt.placeholder);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [[NSMutableArray alloc]init];
    
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSArray *dicta = [ml downloadItems:@"http://localhost/login.php"];
    for (id di in dicta){
        NSDictionary *dict = di;
        NSString *name = dict[@"username"];
        [self.array addObject:name];
    }
    NSLog(@"Arr: %@",self.array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkpwd{
    NSString *msg = @"";
    
    NSUInteger count1 = [[[self.pwd.text componentsSeparatedByCharactersInSet:[[NSCharacterSet uppercaseLetterCharacterSet] invertedSet]] componentsJoinedByString:@""] length];
    NSUInteger count2 = [[[self.pwd.text componentsSeparatedByCharactersInSet:[[NSCharacterSet lowercaseLetterCharacterSet] invertedSet]] componentsJoinedByString:@""] length];
    NSUInteger count3 = [[[self.pwd.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""] length];
    
    if (count1==0) {
        msg = [msg stringByAppendingString:@"Must Contain 1 UpperCase\n"];
    }
    
    if (count2==0) {
        msg = [msg stringByAppendingString:@"Must Contain 1 LowerCase\n"];
    }
    if (count3==0) {
        msg = [msg stringByAppendingString:@"Must Contain 1 Integer\n"];
    }
    if (self.pwd.text.length<8) {
        msg = [msg stringByAppendingString:@"Must Contain ateast 8 character\n"];
    }
    
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Invalid Password!!!"
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    
    if (![msg isEqualToString:@""]) {
        [alert show];
        return FALSE;
    }
    else{
        return TRUE;
    }
}

-(BOOL)checkpwds{
    if([self.pwd.text isEqualToString:self.cfmpwd.text]){
        return TRUE;
    }
    else{
        return FALSE;
    }
}
/*
-(BOOL)username{
    
}

-(BOOL)emailid{
    
}
*/

-(void)submit{
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSArray *dicta = [ml downloadItems:@"http://localhost/login.php"];
    //[self downloadItems];
    NSLog(@"DATa: %@",dicta);
//    BOOL success = NO;
//    NSArray *data1 = [[DBManager getSharedInstance]findAll];
//    NSLog(@"Before Adding:%d",data1.count);
//
//    success = [[DBManager getSharedInstance] saveData:self.usr.text password:self.pwd.text email:self.emid.text];
//    NSArray *data2 = [[DBManager getSharedInstance]findAll];
//    NSLog(@"After Adding:%d",data2.count);
//    
//    if (success==NO) {
//        NSLog(@"%id sad",success);
//        return FALSE;
//    }
//    else{
//        NSLog(@"%id asd",success);
//        return TRUE;
//    }
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([self.usr.text isEqualToString:@"ma"]) {
        
    }
    NSLog(@"Seague: %@",[segue identifier]);
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if ([btn.titleLabel.text isEqualToString:@"Cancel"]) {
        return YES;
    }
    else if([btn.titleLabel.text isEqualToString:@"Submit"]){
        
        
        [self submit];
        
        
        //NSLog(@"Segue");
        //[self checkpwd]; [self.usr.text isEqualToString:@"ma"]
        //if ([self submit]) {
        //    return YES;
        //}else{
        //    return NO;
        //}
        return YES;
    }
    else{
        return YES;
    }
}


@end
