//
//  ManualCheckinViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ManualCheckinFormViewController.h"

@interface ManualCheckinFormViewController ()

@property(nonatomic) DatabaseCommunicator *dbCommunicator;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;

@end


@implementation ManualCheckinFormViewController

-(id) init {
    if ((self = [super init]) == nil) {
        return nil;
    }
    self.formController.form = [[ManualCheckinForm alloc] init];
    self.formController.delegate = self;
    return self;
}

-(void) submitManualCheckinForm {
    // The form being submitted
    [[[UIAlertView alloc] initWithTitle:@"Student Checked In!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

}

// validate form by checking all fields

-(void) studentDataDidFinishUploading {
    NSLog(@"Student data uploaded to database successfully.");
}

@end
