//
//  SOXDAppDelegate.m
//  SOXAppDelegateDemo
//
//  Created by Florian Krüger on 05/05/14.
//  Copyright (c) 2014 projectserver.org. All rights reserved.
//

#import "SOXDAppDelegate.h"

#import "SOXDPushNotificationService.h"

@implementation SOXDAppDelegate

#pragma mark - Services

- (NSArray *)services
{
    static NSArray * _services;
    static dispatch_once_t _onceTokenServices;
    dispatch_once(&_onceTokenServices, ^{
        _services = @[[SOXDPushNotificationService sharedInstance]];
    });
    return _services;
}

@end
