//
//  SubmitVC.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/11/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Middlelayer.h"

@interface SubmitVC : UIViewController
@property (nonatomic, strong) IBOutlet UITextField *usr;
@property (nonatomic, strong) IBOutlet UITextField *pwd;
@property (nonatomic, strong) IBOutlet UITextField *cfmpwd;
@property (nonatomic, strong) IBOutlet UITextField *emid;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, assign) BOOL usrn;
@property (nonatomic, assign) BOOL pswd;
@property (nonatomic, assign) BOOL cfpswd;
@property (nonatomic, assign) BOOL eid;

-(IBAction)check:(id)sender;
-(IBAction)info:(id)sender;


-(BOOL)submit;
-(void)checkpwd;
-(void)checkpwds;
-(void)username;
-(void)emailid;
//-(void)this;




@end
