//  SOXAppDelegate.m
//  SOXAppDelegate
//
//  Copyright (c) 2013 Florian Krueger <florian.krueger@projectserver.org>
//  Created on 05/05/2014.
//
//  Inspired by Nico Hämäläinen's Blogpost "Service Oriented AppDelegate"
//  http://sizeof.io/2014/02/08/service-oriented-appdelegate/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "SOXAppDelegate.h"

@implementation SOXAppDelegate

// By default, we'll have no services in the delegate
- (NSArray *)services 
{
    return nil;
}

#pragma mark - Monitoring App State Changes

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    id<UIApplicationDelegate> service;
    // Loop through the current services and proxy the delegate call
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]){
            [service application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    id<UIApplicationDelegate> service;
    // Loop through the current services and proxy the delegate call
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]){
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationDidBecomeActive:)]){
            [service applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application 
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationWillResignActive:)]){
            [service applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application 
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationDidEnterBackground:)]){
            [service applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application 
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationWillEnterForeground:)]){
            [service applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationWillTerminate:)]){
            [service applicationWillTerminate:application];
        }
    }
}

#pragma mark - Downloading Data in the Background

#ifdef SOXAPPDELEGATE_BACKGROUNDMODE_FETCH

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]){
            [service application:application performFetchWithCompletionHandler:completionHandler];
        }
    }
}

#endif

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]){
            [service application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

#pragma mark - Handling Remote Notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]){
            [service application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]){
            [service application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

#ifdef SOXAPPDELEGATE_BACKGROUNDMODE_REMOTENOTIFICATION

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]){
            [service application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

#endif

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)]){
            [service application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didReceiveRemoteNotification:)]){
            [service application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

#pragma mark - Handling Local Notifications

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didReceiveLocalNotification:)]){
            [service application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)]){
            [service application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}

#pragma mark - Processing the User Notification Settings

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]){
            [service application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

#pragma mark - Responding to System Notifications

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]){
            [service applicationDidReceiveMemoryWarning:application];
        }
    }
}

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationSignificantTimeChange:)]){
            [service applicationSignificantTimeChange:application];
        }
    }
}

#pragma mark - Managing App State Restoration

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    BOOL should = YES;
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:shouldSaveApplicationState:)]){
            should &= [service application:application shouldSaveApplicationState:coder];
        }
    }
    return should;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    BOOL should = YES;
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:shouldRestoreApplicationState:)]){
            should &= [service application:application shouldRestoreApplicationState:coder];
        }
    }
    return should;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController *controller = nil;
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:viewControllerWithRestorationIdentifierPath:coder:)]){
            UIViewController *ctrl = [service application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder];
            controller = (nil == ctrl) ? controller : ctrl;
        }
    }
    return controller;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:willEncodeRestorableStateWithCoder:)]){
            [service application:application willEncodeRestorableStateWithCoder:coder];
        }
    }
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didDecodeRestorableStateWithCoder:)]){
            [service application:application didDecodeRestorableStateWithCoder:coder];
        }
    }
}

#pragma mark - Opening a URL Resource

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    id<UIApplicationDelegate> service;
    BOOL result = NO;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]){
            result |= [service application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return result;
}

#pragma mark - Continuing User Activities

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    id<UIApplicationDelegate> service;
    BOOL result = NO;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:willContinueUserActivityWithType:)]){
            result |= [service application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler
{
    id<UIApplicationDelegate> service;
    BOOL result = NO;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)]){
            result |= [service application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return result;
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didUpdateUserActivity:)]){
            [service application:application didUpdateUserActivity:userActivity];
        }
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didFailToContinueUserActivityWithType:error:)]){
            [service application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

#pragma mark - Disallowing Use of Specified App Extension Types

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    id<UIApplicationDelegate> service;
    BOOL should = NO;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:shouldAllowExtensionPointIdentifier:)]){
            should |= [service application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
        }
    }
    return should;
}

#pragma mark - Managing Status Bar Changes

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:willChangeStatusBarOrientation:duration:)]){
            [service application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
        }
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didChangeStatusBarOrientation:)]){
            [service application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
        }
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:willChangeStatusBarFrame:)]){
            [service application:application willChangeStatusBarFrame:newStatusBarFrame];
        }
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:didChangeStatusBarFrame:)]){
            [service application:application didChangeStatusBarFrame:oldStatusBarFrame];
        }
    }
}

#pragma mark - Responding to Data Protection Changes

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationProtectedDataWillBecomeUnavailable:)]){
            [service applicationProtectedDataWillBecomeUnavailable:application];
        }
    }
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)]){
            [service applicationProtectedDataDidBecomeAvailable:application];
        }
    }
}

#pragma mark - Managing the Default Interface Orientations

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    id<UIApplicationDelegate> service;
    NSUInteger orientations = NO;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)]){
            orientations = [service application:application supportedInterfaceOrientationsForWindow:window];
        }
    }
    return orientations;
}

#pragma mark - Deprecated Methods

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    id<UIApplicationDelegate> service;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(applicationDidFinishLaunching:)]){
            [service applicationDidFinishLaunching:application];
        }
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
    id<UIApplicationDelegate> service;
    BOOL result = NO;
    for (service in self.services) {
        if ([service respondsToSelector:@selector(application:handleOpenURL:)]){
            result |= [service application:application handleOpenURL:url];
        }
    }
    return result;
}

@end
