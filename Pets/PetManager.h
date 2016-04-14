//
//  PetManager.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkManager;
@interface PetManager : NSObject

typedef void (^successBlock) (NSArray *petArray);
typedef void (^failureBlock) (NSString *message);

@property (nonatomic, strong, readonly) NetworkManager *networkManager;

-(instancetype) initWithNetworkManager:(NetworkManager *)networkManager;

- (void)getPetsWithSuccessBlock:(successBlock)successBlock
                           failureBlock:(failureBlock)failureBlock;

@end
