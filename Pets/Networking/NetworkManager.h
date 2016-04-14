//
//  NetworkManager.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
typedef void (^success) (NSArray *applicationsArray);
typedef void (^failure) (NSString *message, NSUInteger statusCode);


- (void)retrieveApplicationsSuccess:(success)success
                            failure:(failure)failure;
@end
