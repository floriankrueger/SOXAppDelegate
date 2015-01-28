# SOXAppDelegate

[![Version](http://cocoapod-badges.herokuapp.com/v/SOXAppDelegate/badge.png)](http://cocoadocs.org/docsets/SOXAppDelegate)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SOXAppDelegate/badge.png)](http://cocoadocs.org/docsets/SOXAppDelegate)

This is a small cocoapod of the excellent SOAppDelegate idea by [Nico Hämäläinen](https://twitter.com/clooth "@clooth"). After I used SOAppDelegate in some of my projects I quickly discovered that I didn't want to use Vanilla AppDelegates anymore. 

This pod should simplify the setup of new iOS projects and keep me away from copying the same code over and over again. Additionally, I'm thinking for a possibility to collect and handle the return values of the used services somehow. If anybody has ideas on this topic, please get in touch.

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

