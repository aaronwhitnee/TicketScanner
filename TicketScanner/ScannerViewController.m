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
@property(nonatomic, strong, readwrite) AVAudioPlayer *whistleSound;
// TODO: add two UILabels for first name and last name, just below scannerView

@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect window = [[UIScreen mainScreen] applicationFrame];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
    
    self.dbCommunicator = [DatabaseCommunicator sharedDatabase];
    self.dbCommunicator.delegate = self;
    
    // TODO: push down scannerView (and its ActivityIndicator) 20px to compensate for status bar at top
    CGRect scannerViewFrame = CGRectMake(0, 0, window.size.width, window.size.width);
    self.scannerView = [[QRCodeCaptureView alloc] initWithFrame:scannerViewFrame message:@"Tap SCAN Button"];
    self.scannerView.delegate = self;
    [self.view addSubview:self.scannerView];
    
    self.startStopButton.center = CGPointMake(window.size.width / 2, window.size.height - 120);
    [self.startStopButton addTarget:self action:@selector(startStopReading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startStopButton];
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
    _startStopButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:1.5];
    _startStopButton.backgroundColor = [UIColor colorWithRed:0 green:100.0/255.0 blue:180.0/255.0 alpha:1.0];
    _startStopButton.clipsToBounds = YES;
    _startStopButton.layer.cornerRadius = buttonFrame.size.width / 2;
    _startStopButton.layer.borderWidth = buttonFrame.size.width * 0.03;
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
    [self startStopReading];
    NSLog(@"Scanned data uploaded to database successfully.");
}

-(void) acceptScannedData:(NSArray *)metadataObjects {
    // TODO: Display scanned student's name on screen
    [self playSuccessAudio];
    self.studentAttributes = metadataObjects;

    NSLog(@"Scanned Data: %@", metadataObjects);
    NSLog(@"Scanned: %@, %@", metadataObjects[1], metadataObjects[0]);
}

- (AVAudioPlayer *)whistleSound {
    if (!_whistleSound) {
        // Prepare audio files to play
        
        NSString *audioFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"whistle.wav"];
        
        
        //[NSString stringWithFormat:@"%@/whistle.wav", [NSBundle mainBundle]];
        NSURL *whistleUrl = [NSURL fileURLWithPath:audioFilePath];
        NSError *error;
        _whistleSound = [[AVAudioPlayer alloc] initWithContentsOfURL:whistleUrl error:&error];
        NSLog(@"%@", error);
    }
    return _whistleSound;
}

-(void) playSuccessAudio {
    NSLog(@"Are we playing any audio???");
    
    [self.whistleSound prepareToPlay];
    [self.whistleSound play];
}

@end
