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
    
    NSArray *typesArray = [kPetTypes componentsSeparatedByString:@","];
    switch (self.type) {
        case PetTypeDog:
            return typesArray[PetTypeDog];
            break;
            
        case PetTypeCat:
            return typesArray[PetTypeCat];
            break;
            
        case PetTypeRabbit:
            return typesArray[PetTypeRabbit];
            break;
            
        case PetTypeGoldfish:
            return typesArray[PetTypeGoldfish];
            break;
        
        case PetTypeGuineaPig:
            return typesArray[PetTypeGuineaPig];
            break;
            
        case PetTypeSyrianHamster:
            return typesArray[PetTypeSyrianHamster];
            break;
            
        case PetTypeRussianHamster:
            return typesArray[PetTypeRussianHamster];
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

@end
