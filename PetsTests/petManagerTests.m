//
//  petManagerTests.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OcMock.h>
#import "PetManager.h"
#import "Pet.h"
#import "NetworkManager.h"


@interface petManagerTests : XCTestCase

@property (nonatomic, strong) PetManager *mgr;
@end

@implementation petManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    self.mgr = [[PetManager alloc] initWithNetworkManager:networkManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.mgr = nil;
    [super tearDown];
}

- (NSArray *)stubResults {
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:20];
    Pet *pet = [[Pet alloc] initWithName:@"Eric" type:PetTypeGoldfish];
    for (int i = 0; i < 20; i++) {
        [results addObject:pet];
    }
    
    return results;
}

- (void)testCanCreateAnApplicationManagerObject {
    
    XCTAssertNotNil(self.mgr, @"Should be able to create an applications manager");
}

- (void)testCanSetNetworkManager {
    
    XCTAssertNotNil(self.mgr.networkManager, @"Should be able to set newtwork manager");
}

- (void)testCanGetListOfApplications {
    
    id sut = [OCMockObject mockForClass:[PetManager class]];
    [[[sut stub] andDo:^(NSInvocation *invocation) {
        //Our stubbed results
        NSArray *pets = [self stubResults];
        successBlock blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:2];
        
        blockToExecute(pets);
    }] getPetsWithSuccessBlock:[OCMArg any]
     failureBlock:[OCMArg any]];
    
    
    [sut getPetsWithSuccessBlock:^(NSArray *petsArray) {
        XCTAssertTrue(petsArray.count == 20, @"Array should have data");
    } failureBlock:^(NSString *message) {
        //Should not see this in our test
        XCTAssertTrue(NO, @"Should not have an error");
    }];
}

@end
