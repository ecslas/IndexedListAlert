//
//  PluginHelper.m
//  ABCplugin
//
//  Created by Ecsedi László on 2014.03.20..
//  Copyright (c) 2014 Ecsedi László. All rights reserved.
//

#import "PluginHelper.h"
#import "IndexedListAlert.h"

@implementation PluginHelper

- (void) showTableAlertView:(CDVInvokedUrlCommand*)command
{
    NSLog(@"TABLE ALERT SHOWED");
    callbackId = command.callbackId;
    NSArray* tempArray = [command.arguments objectAtIndex:0];
    BOOL hasSectionText = YES;//[command.arguments objectAtIndex:1];
    
    IndexedListAlert *alertView = [[IndexedListAlert alloc] initWithTitle:@"Névjegyzék" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView setContentAndShow:tempArray withSectionTitle:hasSectionText];
}

//[self successWithMessage:[NSString stringWithFormat:@"initGA: accountID = %@; Interval = %d seconds",accountID, dispatchPeriod] toID:callbackId];

@end
