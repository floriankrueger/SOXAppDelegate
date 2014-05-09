//
//  SOXAppDelegateDemoTests.m
//  SOXAppDelegateDemoTests
//
//  Created by Florian Krüger on 05/05/14.
//  Copyright (c) 2014 projectserver.org. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SOXDFooService.h"
#import "SOXDBarService.h"

@interface SOXAppDelegateDemoTests : XCTestCase

@end

@implementation SOXAppDelegateDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testService
{
    SOXDFooService *fooService = [SOXDFooService sharedInstance];
    XCTAssertTrue([fooService isKindOfClass:[SOXDFooService class]],
                  @"expected instance of 'SOXDFooService', got instance of '%@'",
                  NSStringFromClass([fooService class]));
    
    SOXDBarService *barService = [SOXDBarService sharedInstance];
    XCTAssertTrue([barService isKindOfClass:[SOXDBarService class]],
                  @"expected instance of 'SOXDBarService', got instance of '%@'",
                  NSStringFromClass([fooService class]));
    
    SOXService *fooService2 = [SOXDFooService sharedInstance];
    XCTAssertEqual(fooService, fooService2,
                   @"");
}

@end
