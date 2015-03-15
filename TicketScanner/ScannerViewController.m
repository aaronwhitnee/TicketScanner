//
//  ScannerViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ScannerViewController.h"
#include "ActivityIndicatorView.h"

@interface ScannerViewController ()

@property(nonatomic) NSArray *studentAttributes;

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
    NSString *firstName = @"Aaron";
    NSString *lastName = @"Robinson";
    NSString *enrollmentType = @"Transfer";
    NSString *email = @"test@test.com";
    self.studentAttributes = [[NSArray alloc] initWithObjects: firstName, lastName, email, enrollmentType, nil];
    
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
    
    self.dbCommunicator = [DatabaseCommunicator sharedDatabase];
    self.dbCommunicator.delegate = self;
    
    CGRect scannerViewFrame = CGRectMake(0, 0, window.size.width, window.size.width);
    self.scannerView = [[QRCodeCaptureView alloc] initWithFrame:scannerViewFrame message:@"Tap SCAN Button"];
    self.scannerView.delegate = self;
    [self.view addSubview:self.scannerView];
    
    self.startStopButton.center = CGPointMake(window.size.width / 2, window.size.height - 120);
    self.startStopButton.titleLabel.text = @"SCAN";
    [self.startStopButton addTarget:self action:@selector(startStopReading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startStopButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIButton *) startStopButton {
    if (_startStopButton) {
        return _startStopButton;
    }
    CGRect buttonFrame = CGRectMake(0, 0, 100, 100);
    _startStopButton = [[UIButton alloc] initWithFrame:buttonFrame];
    [_startStopButton setTitle:@"SCAN" forState:UIControlStateNormal];
    _startStopButton.titleLabel.textColor = [UIColor whiteColor];
    _startStopButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _startStopButton.backgroundColor = [UIColor colorWithRed:0 green:100.0/255.0 blue:180.0/255.0 alpha:1.0];
    _startStopButton.clipsToBounds = YES;
    _startStopButton.layer.cornerRadius = buttonFrame.size.width / 2;
    _startStopButton.layer.borderWidth = buttonFrame.size.width * 0.05;
    _startStopButton.layer.borderColor = [UIColor colorWithRed:0 green:136.0/255.0 blue:247.0/255.0 alpha:1.0].CGColor;
    
    return _startStopButton;
}

-(void) startStopReading {
    self.dbCommunicator.delegate = self;

    if (!self.scannerView.isReading) {
        if ([self.scannerView startReading]) {
            self.startStopButton.alpha = 0.2;
            self.startStopButton.userInteractionEnabled = NO;
            // TODO: only display activity indicator AFTER a connection has started
            [self.dbCommunicator postData:self.studentAttributes toURL:self.postURL];
        }
    }
    else {
        [self.scannerView stopReading];
        self.startStopButton.alpha = 1.0;
        self.startStopButton.userInteractionEnabled = YES;
    }
    self.scannerView.isReading = !self.scannerView.isReading;
}

-(void) studentDataDidFinishUploading {
    // this is where you would play an audible sound to confirm successful scan and upload...
    [self startStopReading];
    NSLog(@"Scanned data uploaded to database successfully.");
}

-(void) acceptScannedData:(NSArray *)metadataObjects {
    // Display scanned student's name on screen, and upload student's data to the database...
    NSLog(@"Scanned Data: %@", metadataObjects);
    self.studentAttributes = metadataObjects;
}

@end
