//
//  FirstViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property(nonatomic) NSURL *postURL;
@property(nonatomic) NSMutableURLRequest *request;
@property(nonatomic) NSURLConnection *connection;

@property(nonatomic) NSString *postDataString;
@property(nonatomic) NSMutableData *receivedData;

@property(nonatomic) NSString *studentId;
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *enrollmentType;

@property(nonatomic) NSString *studentIdEntry;
@property(nonatomic) NSString *firstNameEntry;
@property(nonatomic) NSString *lastNameEntry;
@property(nonatomic) NSString *enrollmentTypeEntry;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // If there is a connection going on, cancel it
    [self.connection cancel];
    
    // init new mutable data
    self.receivedData = [[NSMutableData alloc] init];
    
    // test post data
    self.studentId = @"12345";
    self.firstName = @"Aaron";
    self.lastName = @"Robinson";
    self.enrollmentType = @"Transfer";
    self.studentIdEntry = [NSString stringWithFormat:@"entry.2010109242=%@", self.studentId];
    self.firstNameEntry = [NSString stringWithFormat:@"entry.280111864=%@", self.firstName];
    self.lastNameEntry = [NSString stringWithFormat:@"entry.704921569=%@", self.lastName];
    self.enrollmentTypeEntry = [NSString stringWithFormat:@"entry.213545887=%@", self.enrollmentType];
    
    // create POST data string
    self.postDataString = [NSString stringWithFormat:@"%@%@%@%@",
                           self.studentIdEntry, self.firstNameEntry, self.lastNameEntry, self.enrollmentTypeEntry];
    
    // init POST URL that will be fetched
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
    
    // init request from POST URL
    self.request = [NSMutableURLRequest requestWithURL:[self.postURL standardizedURL]];
    
    // set HTTP method
    [self.request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // set POST data of request
    self.request.HTTPBody = [self.postDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    // init a connection from request
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    
    // start the connection
    [self.connection start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
