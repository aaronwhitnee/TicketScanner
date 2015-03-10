//
//  QRCodeCaptureView.m
//  TicketScanner
//
//  Created by Aaron Robinson on 3/7/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "QRCodeCaptureView.h"

@implementation QRCodeCaptureView

-(instancetype) initWithFrame:(CGRect)frame message:(NSString *)message{
    if ((self = [super init]) == nil) {
        return nil;
    }
    
    self.frame = frame;
    self.backgroundColor = [UIColor blackColor];
    
    CGRect messageFrame = CGRectMake(0, 0, frame.size.width * 0.8, 20.0);
    self.scannerMessageLabel = [[UILabel alloc] initWithFrame:messageFrame];
    self.scannerMessageLabel.text = message;
    self.scannerMessageLabel.textColor = [UIColor whiteColor];
    self.scannerMessageLabel.textAlignment = NSTextAlignmentCenter;
    self.scannerMessageLabel.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
    
    [self addSubview:self.scannerMessageLabel];
    
    self.isReading = NO;
    self.videoCaptureSession = [[AVCaptureSession alloc] init];
    
    return self;
}

-(BOOL) startReading {
//    NSError *readingError = [[NSError alloc] init];
//    
//    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&readingError];
//    
//    if (!input) {
//        NSLog(@"%@", [readingError localizedDescription]);
//        return NO;
//    }
//    
//    [self.videoCaptureSession addInput:input];
//    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
//    [self.videoCaptureSession addOutput:captureMetadataOutput];
//    
//    dispatch_queue_t dispatchQueue;
//    dispatchQueue = dispatch_queue_create("videoQueue", NULL);
//    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
//    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
//    
//    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.videoCaptureSession];
//    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    [self.videoPreviewLayer setFrame:self.layer.bounds];
//    [self.layer addSublayer:self.videoPreviewLayer];
//    
//    [self.videoCaptureSession startRunning];
    self.backgroundColor = [UIColor grayColor];
    
    return YES;
}

-(void) stopReading {
    self.backgroundColor = [UIColor blackColor];
    self.scannerMessageLabel.text = @"Tap SCAN Button";
}

-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects && [metadataObjects count]) {
        // pass scanned metadata back to the main ScannerViewController
        if ([self.delegate respondsToSelector:@selector(acceptScannedData:)]) {
            [self.delegate acceptScannedData:metadataObjects];
        }
    }
}

@end
