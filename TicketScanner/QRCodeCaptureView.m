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
    self.scannerMessageString = message;
    
    CGRect messageFrame = CGRectMake(0, 0, frame.size.width * 0.8, 20.0);
    self.scannerMessageLabel = [[UILabel alloc] initWithFrame:messageFrame];
    self.scannerMessageLabel.text = self.scannerMessageString;
    self.scannerMessageLabel.textColor = [UIColor whiteColor];
    self.scannerMessageLabel.textAlignment = NSTextAlignmentCenter;
    self.scannerMessageLabel.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
    
    [self addSubview:self.scannerMessageLabel];
    
    self.isReading = NO;
    
    return self;
}



@end
