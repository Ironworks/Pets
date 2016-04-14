//
//  PetBuilder.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "PetBuilder.h"
#import "Pet.h"

@implementation PetBuilder


- (NSString *)summaryFromDictionary:(NSDictionary *)dict {
    return [dict[@"label"] copy];
}

- (Pet *)petFromDictionary:(NSDictionary *)dictionary {
    
    NSParameterAssert(dictionary != nil);
    
    NSString *name = dictionary[@"name"];
    PetType type = [dictionary[@"type"] integerValue];
 
    Pet *pet = [[Pet alloc] initWithName:name
                                    type:type];
    return pet;
}

@end

