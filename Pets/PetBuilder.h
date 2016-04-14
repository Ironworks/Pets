//
//  PetBuilder.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Pet;
@interface PetBuilder : NSObject
- (Pet *)petFromDictionary:(NSDictionary *)dictionary;
@end
