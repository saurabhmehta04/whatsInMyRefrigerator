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

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    cameraScanner *view = [self.storyboard instantiateInitialViewController:@"camera"];
//    productVC *prod = [self.storyboard instantiateViewControllerWithIdentifier:@"product"];
    
    NSLog(@"This is test");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)login{
    NSInteger *cnt;
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSString *str = @"http://localhost/login.php?arg1=";
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"LOGIN"]) {
        if([self login]){
        return YES;
        }
        else{
            
            return FALSE;
        }
    }
    else{
        return YES;
    }
}

@end
