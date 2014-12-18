//
//  LoginVC.m
//  GroceFridge
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "LoginVC.h"
#import "productVC.h"
#import "cameraScanner.h"
#import "Middlelayer.h"
#import "InventoryTVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //[self performSegueWithIdentifier:@"tab" sender:nil];
    // Do any additional setup after loading the view.
//    cameraScanner *view = [self.storyboard instantiateInitialViewController:@"camera"];
//    productVC *prod = [self.storyboard instantiateViewControllerWithIdentifier:@"product"];
   
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldShouldReturn:self.usr];
     [self textFieldShouldReturn:self.pwd];
    // NSLog(@"Called");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)login{
    
    NSInteger *cnt;
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSString *str = @"http://wtf.lokesh-cherukuri.com/login.php?arg1=";
    str = [str stringByAppendingString:self.usr.text];
    str = [str stringByAppendingString:@"&arg2="];
    str = [str stringByAppendingString:self.pwd.text];
    NSArray *dicta = [ml downloadItems:str];
    NSDictionary *dict = (NSDictionary *)dicta[0];
    cnt = [dict[@"count(*)"] intValue];
    if(cnt==1) {
        return TRUE;
    }else{
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Invalid Login!!!"
                                                        message:@"Either Username or password does not match with the account details."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return FALSE;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewDidDisappear {
[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"Login"]) {
        if([self login]){
        [[NSUserDefaults standardUserDefaults] setObject:self.usr.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
        }
        else{
            
            return FALSE;
        }
    }
    else{
        return TRUE;
    }
}

@end
