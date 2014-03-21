//
//  PluginHelper.h
//  ABCplugin
//
//  Created by Ecsedi László on 2014.03.20..
//  Copyright (c) 2014 Ecsedi László. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>

@interface PluginHelper : CDVPlugin <UIAlertViewDelegate>
{
    NSString* callbackId;
}

- (void) showTableAlertView:(CDVInvokedUrlCommand*)command;

@end
