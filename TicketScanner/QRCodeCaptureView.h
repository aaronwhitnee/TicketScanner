//
//  QRCodeCaptureView.h
//  TicketScanner
//
//  Created by Aaron Robinson on 3/7/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRCodeCaptureView : UIView <AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic) BOOL isReading;

@property(nonatomic) UILabel *scannerMessageLabel;
@property(nonatomic) NSString *scannerMessageString;
@property(nonatomic) AVCaptureSession *videoCaptureSession;
@property(nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

-(instancetype) initWithFrame:(CGRect)frame message:(NSString *)message;

-(BOOL) startReading;
-(void) stopReading;
@end
