//
//  SOXService.m
//  Pods
//
//  Created by Florian Krüger on 05/05/14.
//
//

#import "SOXService.h"

@implementation SOXService

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
