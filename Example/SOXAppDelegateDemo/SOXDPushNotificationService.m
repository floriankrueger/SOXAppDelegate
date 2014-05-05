//
//  SOXDPushNotificationService.m
//  SOXAppDelegateDemo
//
//  Created by Florian Krüger on 05/05/14.
//  Copyright (c) 2014 projectserver.org. All rights reserved.
//

#import "SOXDPushNotificationService.h"

@implementation SOXDPushNotificationService

// Singleton initializer
+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

@end
