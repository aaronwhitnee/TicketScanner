//
//  QRCodeCaptureView.h
//  TicketScanner
//
//  Created by Aaron Robinson on 3/7/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeCaptureView : UIView
@property(nonatomic) UILabel *scannerMessageLabel;
@property(nonatomic) NSString *scannerMessageString;
@property(nonatomic) BOOL isReading;

-(instancetype) initWithFrame:(CGRect)frame message:(NSString *)message;
-(void) startReading;
-(void) stopReading;
@end
