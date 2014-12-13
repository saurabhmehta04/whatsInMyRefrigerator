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

-(IBAction)check:(id)sender;

-(void)submit;
-(BOOL)checkpwd;
-(BOOL)checkpwds;
-(BOOL)username;
-(BOOL)emailid;
//-(void)this;




@end
