//
//  PetTests.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Pet.h"

@interface PetTests : XCTestCase

@property (nonatomic, strong) Pet *testPet;
@end

@implementation PetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testPet = [[Pet alloc] initWithName:@"Spot" type:PetTypeDog];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testPet = nil;
    [super tearDown];
}

- (void)testCanCreatePet {
    
    XCTAssertNotNil(self.testPet, @"Should be able to create pet");
}

- (void)testCanGivePetAName {
    
    XCTAssertEqualObjects(self.testPet.name, @"Spot", @"Should be able to set pet name");
}

- (void)testCanSetPetType {
    
    XCTAssertTrue(self.testPet.type == PetTypeDog, @"Should be able to set pet type");
}


@end
