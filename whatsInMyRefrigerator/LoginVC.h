//
//  LoginVC.h
//  GroceFridge
//
//  Created by Student on 12/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Middlelayer.h"

@interface LoginVC : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *usr;
@property (nonatomic, strong) IBOutlet UITextField *pwd;
@property (nonatomic, strong) NSMutableArray *array;

-(BOOL)login;
-(BOOL)checkpwd:(NSString *)usrid;
-(void)this;

@end
