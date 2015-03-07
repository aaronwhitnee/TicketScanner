//
//  SpreadsheetHandler.h
//  TicketScanner
//
//  Created by Aaron Robinson on 3/5/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseCommunicator : NSObject
-(void) postData:(NSMutableArray *)data toURL:(NSURL *)url;

@end
