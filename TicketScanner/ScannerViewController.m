//
//  ScannerViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()

@property(nonatomic) NSMutableArray *studentAttributes;

@property(nonatomic) NSURL *postURL;
@property(nonatomic) QRCodeCaptureView *scannerView;
@property(nonatomic) DatabaseCommunicator *dbCommunicator;

@property(nonatomic) UIButton *startStopButton;
@property(nonatomic) UIActivityIndicatorView *activityIndicator; // TO DO: Implement activity indicator
@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect window = [[UIScreen mainScreen] applicationFrame];
    
    // Test post data
    NSString *studentId = @"12345";
    NSString *firstName = @"Aaron";
    NSString *lastName = @"Robinson";
    NSString *enrollmentType = @"Transfer";
    NSString *email = @"test@test.com";
    self.studentAttributes = [[NSMutableArray alloc] initWithObjects:studentId, firstName, lastName, enrollmentType, email, nil];
    
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
    
    self.dbCommunicator = [DatabaseCommunicator sharedDatabase];
    self.dbCommunicator.delegate = self;
    
    CGRect scannerViewFrame = CGRectMake(0, window.size.height / 20, window.size.width, window.size.width);
    self.scannerView = [[QRCodeCaptureView alloc] initWithFrame:scannerViewFrame message:@"Tap SCAN Button"];
    self.scannerView.delegate = self;
    [self.view addSubview:self.scannerView];
    
    self.startStopButton.center = CGPointMake(window.size.width / 2, window.size.height - 90);
    [self.startStopButton addTarget:self action:@selector(startStopReading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startStopButton];
    
    [self.view addSubview:self.activityIndicator];
    
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

-(UIActivityIndicatorView *) activityIndicator {
    if(_activityIndicator) {
        return _activityIndicator;
    }
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.frame = self.view.frame;
    _activityIndicator.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    _activityIndicator.hidesWhenStopped = YES;
    return _activityIndicator;
}

-(void) startStopReading {
    if (!self.scannerView.isReading) {
        if ([self.scannerView startReading]) {
            self.scannerView.scannerMessageLabel.text = @"Scanning QR Code...";
            [self.startStopButton setTitle:@"DONE" forState:UIControlStateNormal];
            self.startStopButton.backgroundColor = [UIColor redColor];
            // TO DO: only display activity indicator AFTER a connection has started
            [self.activityIndicator startAnimating];
            [self.dbCommunicator postData:self.studentAttributes toURL:self.postURL];
        }
    }
    else {
        [self.scannerView stopReading];
        [self.startStopButton setTitle:@"SCAN" forState:UIControlStateNormal];
        self.startStopButton.backgroundColor = [UIColor blueColor];
    }
    self.scannerView.isReading = !self.scannerView.isReading;
}

-(void) studentDataDidFinishUploading {
    // this is where you would play an audible sound to confirm successful scan...
    [self.activityIndicator stopAnimating];
    [self startStopReading];
    NSLog(@"Scanned data uploaded to database successfully.");
}

-(void) acceptScannedData:(NSArray *)metadataObjects {
    // Display scanned student's name on screen, and upload student's data to the database...
    NSLog(@"Scanned Data: %@", metadataObjects);
}

@end
