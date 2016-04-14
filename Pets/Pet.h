//
//  Pet.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PetType) {
    PetTypeDog = 1,
    PetTypeCat,
    PetTypeRabbit,
    PetTypeSyrianHamster,
    PetTypeRussianHamster,
    PetTypeGuineaPig,
    PetTypeGoldfish
};

@interface Pet : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) PetType type;

- (instancetype)initWithName:(NSString *)name
                        type:(PetType)type;

- (NSString *)stringForPetType;

@end
