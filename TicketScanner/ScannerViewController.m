//
//  ScannerViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()
@property(nonatomic) NSString *studentId;
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *enrollmentType;
@property(nonatomic) NSMutableArray *studentAttributes;

@property(nonatomic) NSURL *postURL;
@property(nonatomic) QRCodeCaptureView *scannerView;
@property(nonatomic) DatabaseCommunicator *dbCommunicator;

@property(nonatomic) UIButton *startStopButton;
@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect window = [[UIScreen mainScreen] applicationFrame];
    
    // Test post data
    self.studentId = @"12345";
    self.firstName = @"Aaron";
    self.lastName = @"Robinson";
    self.enrollmentType = @"Transfer";
    self.studentAttributes = [[NSMutableArray alloc] initWithObjects:self.studentId, self.firstName, self.lastName, self.enrollmentType, nil];
    
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
    
    self.dbCommunicator = [[DatabaseCommunicator alloc] init];
//    [self.dbCommunicator postData:self.studentAttributes toURL:self.postURL];
    
    CGRect scannerViewFrame = CGRectMake(0, 0, window.size.width, window.size.width);
    self.scannerView = [[QRCodeCaptureView alloc] initWithFrame:scannerViewFrame message:@"Tap SCAN Button"];
    [self.view addSubview:self.scannerView];
    
    self.startStopButton.center = CGPointMake(window.size.width / 2, window.size.height - 90);
    [self.startStopButton addTarget:self action:@selector(startStopReading:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startStopButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *) startStopButton {
    if (_startStopButton) {
        return _startStopButton;
    }
    CGRect buttonFrame = CGRectMake(0, 0, 200, 50);
    _startStopButton = [[UIButton alloc] initWithFrame:buttonFrame];
    [_startStopButton setTitle:@"SCAN" forState:UIControlStateNormal];
    _startStopButton.titleLabel.textColor = [UIColor whiteColor];
    _startStopButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _startStopButton.backgroundColor = [UIColor blueColor];
    _startStopButton.clipsToBounds = YES;
    _startStopButton.layer.cornerRadius = 10.0;
    
    return _startStopButton;
}

-(void) startStopReading:(UIButton *)sender {
    if (!self.scannerView.isReading) {
        if ([self.scannerView startReading]) {
            self.scannerView.scannerMessageLabel.text = @"Scanning QR Code...";
            [self.startStopButton setTitle:@"DONE" forState:UIControlStateNormal];
            self.startStopButton.backgroundColor = [UIColor redColor];
        }
    }
    else {
        [self.scannerView stopReading];
        [self.startStopButton setTitle:@"SCAN" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor blueColor];
    }
    
    self.scannerView.isReading = !self.scannerView.isReading;
}

@end
