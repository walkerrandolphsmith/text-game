//
//  PlayerInventory.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/20/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PlayerInventory.h"

@implementation PlayerInventory

@synthesize carryWeightCapacity;
@synthesize currentWeight;
@synthesize initialCarryVolumeCapacity;
@synthesize currentVolume;
@synthesize carryVolumeCapacity;
@synthesize hasExpansion;

-(id)init
{
    self = [super init];
    
    if (nil != self) {
        [self setCarryWeightCapacity:10];
        [self setCurrentWeight:0.0];
        [self setInitialCarryVolumeCapacity:4];
        [self setCurrentVolume:0.0];
        [self setCarryVolumeCapacity: initialCarryVolumeCapacity];
        inventory = [[NSMutableDictionary alloc]init];
        hasExpansion = NO;
    }
    return self;
}

-(double)getVolumeCapacity
{
    return carryVolumeCapacity;
}

-(NSMutableDictionary*)getInventory
{
    return inventory;
}


-(BOOL)hasExpansion
{
    return hasExpansion;
}

 
-(id<ItemProtocol>)getItem:(NSString *)theLabel
{
	return [inventory objectForKey:theLabel];
}


-(NSMutableString *)wasTooBigOrTooHeavy:(id<ItemProtocol>)item
{
    NSMutableString *YouCanNotCarryItemMessage = [[NSMutableString alloc]initWithString:@""];
    
    if ([self isTooBig:item]) {
        [YouCanNotCarryItemMessage appendString:@"The item is too big. consider using an expansion pack to increase your inventory's capacity"];
    }
    else
    {
        [YouCanNotCarryItemMessage appendString:@"The item is too heavy."];
    }
    return YouCanNotCarryItemMessage;
}

-(BOOL)canCarry:(id<ItemProtocol>)item
{
    BOOL result = NO;
   if(![self isTooBig:item] && ![self isTooHeavy:item])
   {
       result = YES;
   }
    return result;
}

-(BOOL)isTooBig:(id<ItemProtocol>)item
{
    BOOL result = YES;
    if([item volume] + currentVolume <= carryVolumeCapacity){
        result = NO;
    }
    return result;
}

-(BOOL)isTooHeavy:(id<ItemProtocol>)item
{
    BOOL result = YES;
    if([item weight]+currentWeight <= carryWeightCapacity){
        result = NO;
    }
    return result;
}

-(void)addItem:(id<ItemProtocol>)item
{
    if([item isKindOfClass:[ItemInventoryExpansion class]])
    {
       ItemInventoryExpansion *expansionPack = item;
        carryVolumeCapacity += [expansionPack amtToExtendVolumeCapacity];
        hasExpansion = YES;
    }
    [inventory setObject:item forKey:[item label]];
    //adjust weight and volume
    currentWeight += [item weight];
    currentVolume += [item volume];
}

-(void)removeItem:(id<ItemProtocol>)itemToDrop
{
    if ([itemToDrop isKindOfClass:[ItemInventoryExpansion class]]) {
        ItemInventoryExpansion *expansionPack = itemToDrop;
        carryVolumeCapacity -= [expansionPack amtToExtendVolumeCapacity];
        hasExpansion = NO;
    }
        [inventory removeObjectForKey:[itemToDrop label]];
        currentVolume -= [itemToDrop volume];
        currentWeight -= [itemToDrop weight];
}

-(BOOL)canDrop:(id<ItemProtocol>)itemToDrop
{
    BOOL result = YES;
    if ([itemToDrop isKindOfClass:[ItemInventoryExpansion class]] && (currentVolume - [itemToDrop volume]> initialCarryVolumeCapacity))
        {
            result = NO;
        }        
    return result;
}

//Inventory Command: Helper print inventory
-(NSString *)printInventory
{
	//NSArray *itemList = [inventory allKeys];
	return [NSString stringWithFormat:@"Current Load: %f / %f \nCurrent Space: %f / %f \nItems: %@", currentWeight, carryWeightCapacity, currentVolume, carryVolumeCapacity, [[inventory allKeys] componentsJoinedByString:@" "]];
}

- (void)dealloc
{
    [inventory release];
    
    [super dealloc];
}
@end
