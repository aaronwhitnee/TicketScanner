//
//  ManualCheckinForm.m
//  TicketScanner
//
//  Created by Aaron Robinson on 3/11/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "ManualCheckinForm.h"
#import "CustomButtonCell.h"

@implementation ManualCheckinForm

- (NSArray *) fields {
    
    NSMutableArray *fieldsArray = [[NSMutableArray alloc] init];
    
    [fieldsArray addObject: @{FXFormFieldKey: @"firstName",
                              FXFormFieldPlaceholder: @"First",
                              FXFormFieldTitle: @"",
                              FXFormFieldHeader: @"Student Name"}];
    
    [fieldsArray addObject: @{FXFormFieldKey: @"lastName",
                              FXFormFieldPlaceholder: @"Last",
                              FXFormFieldTitle: @""}];
    
    [fieldsArray addObject: @{FXFormFieldKey: @"enrollmentType",
                              FXFormFieldTitle: @"",
                              FXFormFieldHeader: @"Freshman or Transfer?",
                              FXFormFieldOptions: @[@"Freshman", @"Transfer"],
                              FXFormFieldCell: [FXFormOptionSegmentsCell class]}];
    
    [fieldsArray addObject: @{FXFormFieldKey: @"email",
                              FXFormFieldPlaceholder: @"example@domain.com",
                              FXFormFieldTitle: @"",
                              FXFormFieldHeader: @"Email Address",
                              FXFormFieldType: FXFormFieldTypeEmail}];
    
    return fieldsArray;
}

-(NSArray *) extraFields {
    return @[
             @{FXFormFieldTitle: @"Submit",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitManualCheckinForm"}
             ];
}

@end
