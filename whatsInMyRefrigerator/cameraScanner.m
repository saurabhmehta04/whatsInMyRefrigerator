//
//  cameraScanner.m
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/9/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "cameraScanner.h"

@interface cameraScanner () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    UIView *_highlightView;
    UILabel *_label;
}
@end

@implementation cameraScanner


//getting the product details from the barcode
-(void)productInfo: (NSString *)productId {
    
//    responseData = [[NSMutableData alloc]init];
    NSString *restAPI = [NSString stringWithFormat:@"http://www.outpan.com/api/get-product.php?apikey='be47fc0d96934ca9004100223e9ba7ba'&barcode='%@'", productId];
    
    NSLog(@"%@", restAPI);
//    
//    NSURL *url = [[NSURL alloc] initWithString:@"http://www.outpan.com/api/get-product.php?apikey='be47fc0d96934ca9004100223e9ba7ba'&barcode="0028400005753""];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    (void)[NSURLConnection connectionWithRequest:req delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
            _label.text = detectionString;
//            to test: munchies 0028400005753
            http://www.outpan.com/api/get-product.php?apikey="be47fc0d96934ca9004100223e9ba7ba"&barcode="0028400005753"
            
            [self productInfo:_label.text];
            
            
//            if ([_label.text  isEqual: @"0850006000012"]) {
//                _label.text = @"Cookie";
//            }
            break;
        }
        else
            _label.text = @"(none)";
            NSLog(@"Label is => %@", _label.text);
    }
    
    _highlightView.frame = highlightViewRect;
}





@end
