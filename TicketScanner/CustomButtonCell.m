//
//  CustomButtonCell.m
//  TicketScanner
//
//  Created by Aaron Robinson on 3/11/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "CustomButtonCell.h"

@interface CustomButtonCell()
@property (nonatomic, strong) UIButton *cellButton;
@property (nonatomic) FXFormField *field;
@end

@implementation CustomButtonCell

-(void) setUp {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:0.2 green:0 blue:0.8 alpha:1.0];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.text = self.field.title;
}

@end
