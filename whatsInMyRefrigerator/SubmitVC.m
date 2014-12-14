//
//  SubmitVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/11/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "SubmitVC.h"

#define USERNAME @"Username"
#define PASSWORD @"Password"
#define CFMPASS @"Confirm Password"
#define EMAIL @"Email"

@interface SubmitVC ()

@end



@implementation SubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usrn=FALSE;
    self.pswd=FALSE;
    self.cfpswd=FALSE;
    self.eid=FALSE;
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


-(void)username{
    for(NSString *name in self.array){
        //NSLog(@"Initial: %@ and Writing: %@",name,self.usr.text);
        if([name isEqualToString:self.usr.text]){
            self.usrn=FALSE;
            //NSLog(@"USR1: %d",self.usrn);
            break;
        }
        else{
            self.usrn=TRUE;
            //NSLog(@"USR2: %d",self.usrn);
            
        }
    }
}


-(void)checkpwd{
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
        self.pswd=FALSE;
    }
    else{
        self.pswd=TRUE;
    }
    //NSLog(@"%d PWD:%@",self.pswd,self.pwd.text);
}

-(void)checkpwds{
    if([self.pwd.text isEqualToString:self.cfmpwd.text]){
        self.cfpswd=TRUE;
    }
    else{
        self.cfpswd=FALSE;
    }
    //NSLog(@"cfmpwd:%@",self.cfmpwd.text);
}

//Reference: http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/

-(void)emailid{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\.[A-Za-z-]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    self.eid = [emailTest evaluateWithObject:self.emid.text] ? TRUE : FALSE;
}

-(IBAction)check:(id)sender{
    UITextField *txt = (UITextField *)sender;
    if ([txt.placeholder isEqualToString:USERNAME]) {
        [self username];
        //         NSLog(@"USR: %d",self.usrn);
    }
    else if([txt.placeholder isEqualToString:PASSWORD]){
        [self checkpwd];
        //        NSLog(@"USR: %d",self.pswd);
    }
    else if([txt.placeholder isEqualToString:CFMPASS]){
        [self checkpwds];
        //        NSLog(@"USR: %d",self.cfpswd);
    }
    else if([txt.placeholder isEqualToString:EMAIL]){
        [self emailid];
        //NSLog(@"USR ema: %d",self.eid);
    }
    
}


-(BOOL)submit{
    NSLog(@"Usr: %d and Pass: %d and Email: %d",self.usrn,self.pswd,self.eid);
    if (self.usrn && self.pswd && self.cfpswd && self.eid) {
        Middlelayer *ml = [[Middlelayer alloc]init];
        NSString *str = @"http://localhost/loginupdate.php?name=";
        str = [str stringByAppendingString:self.usr.text];
        str = [str stringByAppendingString:@"&pwd="];
        str = [str stringByAppendingString:self.pwd.text];
        str = [str stringByAppendingString:@"&email="];
        str = [str stringByAppendingString:self.emid.text];
        NSArray *dicta = [ml downloadItems:str];

        return TRUE;
    }
    else{
        NSString *msg;
        if (!self.usrn) {
            msg = @"Username Already Exists";
        }
        else if (!self.cfpswd){
            msg = [msg stringByAppendingString:@"\nBoth Password do not Match\n"];
        }
        else if(!self.eid){
            msg = [msg stringByAppendingString:@"\nEmail Id Invalid\n"];
        }
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Invalid Password!!!"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                            otherButtonTitles: nil];
        [alert show];
        return FALSE;
    }
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
        if ([self submit]) {
            Middlelayer *ml = [[Middlelayer alloc]init];
            NSString *str = @"http://localhost/login.php?arg1=";
            str = [str stringByAppendingString:self.usr.text];
            str = [str stringByAppendingString:@"&arg2="];
            str = [str stringByAppendingString:self.pwd.text];
            str = [str stringByAppendingString:@"&arg3="];
            str = [str stringByAppendingString:self.emid.text];
            return YES;
        }
        else{
        return NO;
        }
    }
    else{
        return YES;
    }
}

@end
