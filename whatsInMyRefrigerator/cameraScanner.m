//
//  cameraScanner.m
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/9/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "cameraScanner.h"
#import "Middlelayer.h"

@interface cameraScanner () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    UIView *_highlightView;
    UILabel *_label;
    BOOL done;
    NSString *testString;
}
@end

@implementation cameraScanner

@synthesize productTitleAndWeight; //NSArray
//@synthesize productTitle; //NSString

//getting the product details from the barcode
-(void)productInfo: (NSString *)productId {
    //testString = @"Some";
    NSString *restAPI = [NSString stringWithFormat:@"http://www.outpan.com/api/get-product.php?apikey='be47fc0d96934ca9004100223e9ba7ba'&barcode='%@'", productId];

    
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSDictionary *arr = (NSDictionary *)[ml downloadItems:restAPI];
    NSLog(@"data:%@",arr);
    if (![arr[@"name"] isEqual:[NSNull null]]) {
        
        NSLog(@"data1:%@",arr[@"name"]);
        NSLog(@"data2:%@",[arr[@"name"] componentsSeparatedByString:@","]);
        //NSLog(@"data3:%@",arr);
        self.productTitle = [[arr[@"name"] componentsSeparatedByString:@","] objectAtIndex:0];
        productVC *view = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"product"];
        
        NSLog(@"product title ===> %@", self.productTitle);
        view.productTitleFromCameraScanner = [self productTitle];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        NSLog(@"Invalid");
    }
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self flashlight];
    done = YES;
    _highlightView = [[UIView alloc] init];
    
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 40);
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _label.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"(none)";
    [self.view addSubview:_label];

    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    
    [_session startRunning];
    
    [self.view bringSubviewToFront:_highlightView];
    [self.view bringSubviewToFront:_label];
    

}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    if(!done){
        //[self dismissViewControllerAnimated:YES completion:nil];
        [_session stopRunning];
        [self productInfo:self.string];
        
//        productVC *view = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"product"];
//        [self.navigationController pushViewController:view animated:YES];
        
    }
    else{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            self.string = detectionString;
           //[self cALLING:detectionString];

                //[self.navigationController popViewControllerAnimated:YES];
            //NSLog(@"Calling Multiple");
//            NSLog(@"NAV PAre:%@",self.parentViewController.title);
            done=NO;
            //[self.navigationController pushViewController:viewController animated:YES];
            
//            productInfo *viewController = [[productInfo alloc]  init];
//            
//            viewController.productTitle.text = _label.text;
            
//            [self.navigationController pushViewController:viewController animated:YES];
            _label.text = self.string;
            NSLog(@"Label is => %@", _label.text);

           break;
        }
        else{
            _label.text = @"(none)";
            NSLog(@"Label is => %@", _label.text);
        }
   }
    
    _highlightView.frame = highlightViewRect;
    }
}



//to toggle flashLight while scanning
- (void) flashlight
{
    NSLog(@"Turning on flashlight...");
    
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [flashLight lockForConfiguration:nil];
        if (success)
        {
            if ([flashLight isTorchActive]) {
                [flashLight setTorchMode:AVCaptureTorchModeOff];
            } else {
                [flashLight setTorchMode:AVCaptureTorchModeOn];
            }
            [flashLight unlockForConfiguration];
        }
    }
    
}


@end
