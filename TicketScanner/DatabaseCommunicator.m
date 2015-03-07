//
//  SpreadsheetHandler.m
//  TicketScanner
//
//  Created by Aaron Robinson on 3/5/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "DatabaseCommunicator.h"

@interface DatabaseCommunicator()
@property(nonatomic) NSURL *postURL;
@property(nonatomic) NSMutableURLRequest *request;
@property(nonatomic) NSURLConnection *connection;

@property(nonatomic) NSString *postDataBody;
@property(nonatomic) NSString *postDataTail;
@property(nonatomic) NSMutableData *receivedData;

@property(nonatomic) NSString *studentIdEntry;
@property(nonatomic) NSString *firstNameEntry;
@property(nonatomic) NSString *lastNameEntry;
@property(nonatomic) NSString *enrollmentTypeEntry;
@end

@implementation DatabaseCommunicator
-(void) postData:(NSMutableArray *)data toURL:(NSURL *)url {
    // If there is a connection going on, cancel it
    [self.connection cancel];
    
    // init new mutable data
    self.receivedData = [[NSMutableData alloc] init];
    
    // Create post data with attributes scanned from QR code
    self.studentIdEntry = [NSString stringWithFormat:@"entry.2010109242=%@", data[0]];
    self.firstNameEntry = [NSString stringWithFormat:@"&entry.280111864=%@", data[1]];
    self.lastNameEntry = [NSString stringWithFormat:@"&entry.704921569=%@", data[2]];
    self.enrollmentTypeEntry = [NSString stringWithFormat:@"&entry.213545887=%@", data[3]];
    self.postDataTail = @"&draftResponse=[,,\"0\"]&pageHistory=0&fbzx=0";

    // create POST data string
    self.postDataBody = [NSString stringWithFormat:@"%@%@%@%@%@",
                         self.studentIdEntry, self.firstNameEntry, self.lastNameEntry,
                         self.enrollmentTypeEntry, self.postDataTail];

    NSLog(@"POST DATA: %@", self.postDataBody);
    
    // init POST URL that will be fetched
    self.postURL = url;
    
    // init request from POST URL
    self.request = [NSMutableURLRequest requestWithURL:[self.postURL standardizedURL]];
    
    // set HTTP method
    [self.request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    // set POST data of request
    self.request.HTTPBody = [self.postDataBody dataUsingEncoding:NSUTF8StringEncoding];
    self.request.HTTPMethod = @"POST";
    
    // init a connection from request
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    
    // start the connection
    [self.connection start];
}


@end
