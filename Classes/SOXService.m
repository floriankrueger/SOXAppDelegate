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
    NSMutableDictionary *sharedInstances = [self sharedInstances];
    
    Class serviceClass = [self class];
    NSString *serviceClassName = NSStringFromClass(serviceClass);
    
    SOXService *sharedInstance = [sharedInstances objectForKey:serviceClassName];
    
    @synchronized(serviceClass)
    {
        if (nil == sharedInstance) {
            sharedInstance = [[serviceClass alloc] init];
            sharedInstances[serviceClassName] = sharedInstance;
        }
    }
    
    return sharedInstance;
}

+ (NSMutableDictionary *)sharedInstances
{
    static NSMutableDictionary *_sharedInstances = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstances = [NSMutableDictionary dictionary];
    });
    return _sharedInstances;
}

@end
