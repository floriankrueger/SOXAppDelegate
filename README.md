# SOXAppDelegate

[![Version](http://cocoapod-badges.herokuapp.com/v/SOXAppDelegate/badge.png)](http://cocoadocs.org/docsets/SOXAppDelegate)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SOXAppDelegate/badge.png)](http://cocoadocs.org/docsets/SOXAppDelegate)

This is a small cocoapod of the excellent SOAppDelegate idea by [Nico Hämäläinen](https://twitter.com/clooth "@clooth"). After I used SOAppDelegate in some of my projects I quickly discovered that I didn't want to use Vanilla AppDelegates anymore. This pod should simplify the setup of new iOS projects.

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

See [this blog post](http://sizeof.io/service-oriented-appdelegate/) for a detailed writeup about this topic.

### Step 1

Make your `UIAppDelegate` implementation a subclass of `SOXAppDelegate`.

```Objective-C
#import "SOXAppDelegate.h"

@interface SOXDAppDelegate : SOXAppDelegate

@end
```

### Step 2

Create your Service classes. You can either use a plain `NSObject` subclass for that purpose or a `SOXService` subclass.  
`NSObject` subclasses should at least implement some form of Singleton pattern to prevent multiple instances of your services (there is only one `UIApplicationDelegate` per App and so should your services).  
The `SOXService` implements the default Singleton pattern, the shared instance is available via `sharedInstance`.


### Step 3

Add the `services` method to your `SOXAppDelegate` subclass. We're assuming `MyServiceClass` to be the name of your service in this example:

```Objective-C
#pragma mark - Services

- (NSArray *)services
{
    static NSArray * _services;
    static dispatch_once_t _onceTokenServices;
    dispatch_once(&_onceTokenServices, ^{
        _services = @[[MyServiceClass sharedInstance]];
    });
    return _services;
}
```

### Step 4

Implement all UIAppDelegate methods necessary for your service in the service class. You don't need to declare the `UIApplicationDelegate`. Your `SOXAppDelegate` subclass will call all methods implemented by the service when they are called on the AppDelegate.

### Step 5

Don't forget to call the `super` within all `UIApplicationDelegate` methods inside your delegate. The baseclass will then make sure that all services which implement said method get notified.

## Background Modes

By default, SOXAppDelegate doesn't implement the following methods:

- `- application:didReceiveRemoteNotification:fetchCompletionHandler:`
- `- application:performFetchWithCompletionHandler:`

These methods require additional setup in your Info.plist if you really want to use them. T prevent you from seeing warnings on the console when running the app (see issue #2) or iTunes from sending you E-Mail after you submitted your App (see issue #3) these methods are now excluded by define.

To make use of these methods, use one of the following defines (or both):

- `SOXAPPDELEGATE_BACKGROUNDMODE_FETCH`
- `SOXAPPDELEGATE_BACKGROUNDMODE_REMOTENOTIFICATION` (for `- application:didReceiveRemoteNotification:fetchCompletionHandler:`)

### Enabling Background Modes

To enable one of the background modes you need to make use of the [post install hook](http://guides.cocoapods.org/syntax/podfile.html#post_install) of cocoapods:

```
post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    target.build_configurations.each do |config|
      # enable UIBackgroundMode 'fetch'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'SOXAPPDELEGATE_BACKGROUNDMODE_FETCH=1']

      # enable UIBackgroundMode 'remote-notification'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'SOXAPPDELEGATE_BACKGROUNDMODE_REMOTENOTIFICATION=1']

      # enable both
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'SOXAPPDELEGATE_BACKGROUNDMODE_FETCH=1', 'SOXAPPDELEGATE_BACKGROUNDMODE_REMOTENOTIFICATION=1']
    end
  end
end
```

Remember to run `pod install` afterwards to trigger the post install hook.

Thx to [johndpope](http://stackoverflow.com/users/284895/johndpope) for his [answer](http://stackoverflow.com/a/22549877/766873) demonstrating how to add GCC Preprocessor Definitions to cocoapods.

## Requirements

- iOS >= 6.0

## Installation

SOXAppDelegate is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "SOXAppDelegate"

## Author

Florian Krüger, florian.krueger@projectserver.org

## License

SOXAppDelegate is available under the MIT license. See the LICENSE file for more info.
