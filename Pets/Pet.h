//
//  Pet.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PetType) {
    PetTypeDog = 0,
    PetTypeCat,
    PetTypeRabbit,
    PetTypeSyrianHamster,
    PetTypeRussianHamster,
    PetTypeGuineaPig,
    PetTypeGoldfish
};

static NSString *const kPetTypes = @"Dog,Cat,Rabbit,Syrian Hamster,Russian Hamster,Guinea Pig,Goldfish";

@interface Pet : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) PetType type;

- (instancetype)initWithName:(NSString *)name
                        type:(PetType)type;

- (NSString *)stringForPetType;

@end
