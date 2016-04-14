//
//  NetworkingManagerTests.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"
#import "NetworkManager.h"

@interface NetworkManagerTests : XCTestCase

@property (nonatomic, strong) NetworkManager *sut;
@end

@implementation NetworkManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.sut = [[NetworkManager alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [OHHTTPStubs removeAllStubs];
    self.sut = nil;
    [super tearDown];
}

- (void)testCanCreateNetworkManager {
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    XCTAssertTrue(networkManager, @"Should be able to create a network manager");
}


- (void)testCanRetrieveApplications {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"petsAPI.com"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "applications.json" stub file
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"pets.json",self.class)
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should download applications"];
    
    [self.sut retrieveApplicationsSuccess:^(NSArray *applicationsArray) {
        XCTAssertTrue(applicationsArray, @"Should contain an array of entries");
        XCTAssertTrue(applicationsArray.count == 20, @"Should have 20 entries");
        [expectation fulfill];
    } failure:^(NSString *message, NSUInteger statusCode) {
        //Should not see this
        XCTAssertTrue(NO, @"Should not have an error");
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error occured: %@", error.localizedDescription);
        }
    }];
}

- (void)testnetworkErrorRetrieveingApplications {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:[NSData data] statusCode:404 headers:nil];
    }];
    
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should receive 404 error"];
    [self.sut retrieveApplicationsSuccess:^(NSArray *applicationsArray) {
        //Should not see this
        XCTAssertTrue(NO, @"Should not get receive applications data");
    } failure:^(NSString *message, NSUInteger statusCode) {
        XCTAssertTrue(statusCode == (NSUInteger)404, @"Status code should be 404");
        XCTAssertEqualObjects(message, @"Request failed: not found (404)", @"Should receive 404 error");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error occured: %@", error.localizedDescription);
        }
    }];
    
    
}
@end
