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
@property(nonatomic) NSString *studentId;
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *enrollmentType;

@property(nonatomic) DatabaseCommunicator *dbCommunicator;
@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.title = @"Scan Ticket";
    
    // Test post data
    self.studentId = @"12345";
    self.firstName = @"Aaron";
    self.lastName = @"Robinson";
    self.enrollmentType = @"Transfer";
    self.studentAttributes = [[NSMutableArray alloc] initWithObjects:self.studentId, self.firstName, self.lastName, self.enrollmentType, nil];
    
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
    
    self.dbCommunicator = [[DatabaseCommunicator alloc] init];
    [self.dbCommunicator postData:self.studentAttributes toURL:self.postURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
