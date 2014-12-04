//
//  LoginVC.h
//  GroceFridge
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *usr;
@property (nonatomic, strong) IBOutlet UITextField *pwd;

-(IBAction)login:(id)sender;
-(IBAction)signup:(id)sender;
-(BOOL)checkpwd:(NSString *)usrid;
-(void)this;

@end
