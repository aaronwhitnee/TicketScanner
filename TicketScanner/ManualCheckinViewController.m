//
//  ManualCheckinViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ManualCheckinViewController.h"

@interface ManualCheckinViewController ()

@property(nonatomic) DatabaseCommunicator *dbCommunicator;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation ManualCheckinViewController

- (instancetype) initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style]) == nil) {
        return nil;
    }
    self.dbCommunicator = [DatabaseCommunicator sharedDatabase];
    self.dbCommunicator.delegate = self;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // configure table cells...

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
}

-(void) studentDataDidFinishUploading {
    NSLog(@"Student data uploaded to database successfully.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
