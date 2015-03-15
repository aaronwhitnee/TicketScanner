//
//  ManualCheckinViewController.m
//  TicketScanner
//
//  Created by Aaron Robinson on 2/26/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ManualCheckinFormViewController.h"
#import "ActivityIndicatorView.h"

@interface ManualCheckinFormViewController ()

@property(nonatomic) DatabaseCommunicator *dbCommunicator;
@property(nonatomic) NSURL *postURL;

@property(nonatomic) UIAlertView *alertView;

@end


@implementation ManualCheckinFormViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    // TODO: create a custom FXForm that is dynamically generated based on the data
    // that the user wants collect from the guests
    
    self.formController.tableView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    
    self.dbCommunicator = [DatabaseCommunicator sharedDatabase];
    self.dbCommunicator.delegate = self;
    
    self.formController.form = [[ManualCheckinForm alloc] init];
    self.formController.tableView = self.tableView;
    self.postURL = [NSURL URLWithString:@"https://docs.google.com/forms/d/1-q7M81pv8Q_c0XazDr-mrhUxWfN5nvub71VH_pA-JJk/formResponse"];
}

-(void) submitManualCheckinForm:(UITableViewCell<FXFormFieldCell> *)cell {
    self.dbCommunicator.delegate = self;

    ManualCheckinForm *form = cell.field.form;
    NSMutableArray *formValues = [[NSMutableArray alloc] init];
    
    for (FXFormField *field in [form fields]) {
        id fieldValue = [form valueForKey: [field valueForKey:@"key"]];
        if (fieldValue) {
            [formValues addObject:fieldValue];
        }
    }
    NSLog(@"%@",formValues);
    [self.dbCommunicator postData:formValues toURL:self.postURL];
}

-(void) studentDataDidFinishUploading {
    if (_alertView) {
        _alertView = nil;
    }
    _alertView = [[UIAlertView alloc] initWithTitle:@"Check In Successful!"
                                            message:nil
                                           delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
    [_alertView show];
}

@end
