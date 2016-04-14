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


- (NSString *)stringForPetType
{
    switch (self.type) {
        case PetTypeDog:
            return @"Dog";
            break;
            
        case PetTypeCat:
            return @"Cat";
            break;
            
        case PetTypeRabbit:
            return @"Rabbit";
            break;
            
        case PetTypeGoldfish:
            return @"Goldfish";
            break;
        
        case PetTypeGuineaPig:
            return @"Guinea Pig";
            break;
            
        case PetTypeSyrianHamster:
            return @"Syrian Hamster";
            break;
            
        case PetTypeRussianHamster:
            return @"Russian Hamster";
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

@end
