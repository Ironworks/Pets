//
//  Pet.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "Pet.h"

@implementation Pet

- (instancetype)initWithName:(NSString *)name
                        type:(PetType)type
{
    if (self = [super init]) {
        _name = [name copy];
        _type = type;
    }
    
    return self;
}
@end
