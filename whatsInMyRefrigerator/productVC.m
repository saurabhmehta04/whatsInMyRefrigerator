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

@synthesize productTitle;
@synthesize productTitleFromCameraScanner;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"String value %@", productTitleFromCameraScanner);
    
        productTitle.text = productTitleFromCameraScanner;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submit:(id)sender {
    NSLog(@"Submit button clicked");
}

//-(id)initWithCoder:(NSCoder *)aDecoder {
//    cameraScanner *controller = [[cameraScanner alloc]init];
//    NSLog(@"in productVC => %@", controller.productTitle);
//    productTitle.text = controller.productTitle;
//
//}


//- (id)initWithCoder:(NSCoder *)inCoder {
//    if (self = [super initWithCoder:inCoder]) {
//        
//        productTitle.text = @"This is from initWithCoder";
//        NSLog(@"I am here");
//        
//    }
//    return self;
//}

@end
