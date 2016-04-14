//
//  NetworkManager.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
typedef void (^success) (NSArray *petsArray);
typedef void (^failure) (NSString *message, NSUInteger statusCode);


- (void)retrievePetsSuccess:(success)success
                            failure:(failure)failure;
@end
