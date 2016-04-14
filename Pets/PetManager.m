//
//  PetManager.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "PetManager.h"
#import "NetworkManager.h"
#import "Pet.h"
#import "PetBuilder.h"

@interface PetManager ()

@property (nonatomic, strong) NSMutableArray *petsArray;
@end

@implementation PetManager

-(instancetype) initWithNetworkManager:(NetworkManager *)networkManager {
    
    if (self = [super init]) {
        _networkManager = networkManager;
    }
    
    return self;
}

- (NSArray *)petArrayFromPetsArray:(NSArray *)petsArray {
    
    PetBuilder *petBuilder = [[PetBuilder alloc] init];
    
    for (NSDictionary *pet in petsArray) {
        Pet *newPet = [petBuilder petFromDictionary:pet];
        [self.petsArray addObject:newPet];
    }
    
    return [self.petsArray copy];
}

- (void)getPetsWithSuccessBlock:(successBlock)successBlock
                           failureBlock:(failureBlock)failureBlock
{
    
    __weak typeof (self)weakSelf = self;
    [self.networkManager retrieveApplicationsSuccess:^(NSArray *petsArray) {
        
        PetManager *blockSelf = weakSelf;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                NSArray *petArray = [blockSelf petArrayFromPetsArray:petsArray];
                successBlock(petArray);
            }
        });
        
    } failure:^(NSString *message, NSUInteger statusCode) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failureBlock) {
                failureBlock(message);
            }
        });
    }];
}

#pragma mark - Accessor Methods
- (NSMutableArray *)petsArray {
    
    if (_petsArray == nil) {
        _petsArray = [NSMutableArray array];
    }
    
    return _petsArray;
}

@end

