//
//  PlayerInventory.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/20/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InventoryProtocol.h"
#import "ItemProtocol.h"
#import "ItemInventoryExpansion.h"

@interface PlayerInventory : NSObject<InventoryProtocol>{
    NSMutableDictionary *inventory;
    double carryWeightCapacity;
    double currentWeight;
    double initialCarryVolumeCapacity;
    double currentVolume;
    double carryVolumeCapacity;
    BOOL hasExpansion;
}

@property (assign, nonatomic)double carryWeightCapacity;
@property (assign, nonatomic)double currentWeight;
@property (assign, nonatomic)double initialCarryVolumeCapacity;
@property (assign, nonatomic)double currentVolume;
@property (assign, nonatomic)double carryVolumeCapacity;
@property (assign, nonatomic)BOOL hasExpansion;

-(id)init;
-(double)getVolumeCapacity;
-(NSString*)printInventory;
-(NSMutableDictionary*)getInventory;
-(id<ItemProtocol>)getItem:(NSString *)theLabel;
-(BOOL)canCarry:(id<ItemProtocol>)item;
-(NSMutableString *)wasTooBigOrTooHeavy:(id<ItemProtocol>)item;
//Yes if the given item's volume plus the current volume is <= capacity
//NO otherwise
-(BOOL)isTooBig:(id<ItemProtocol>)item;
//Yes if the given item's weight plus the current weight is <= capacity
//NO otherwise
-(BOOL)isTooHeavy:(id<ItemProtocol>)item;
//if given item is an expansionPack adjust VolumeCapacity
//Add given item's volume and weight to currrent volume and weight repectively
-(void)addItem:(id<ItemProtocol>)item;
//Remove given item from MutableDictionary and
//Subtract given item's volume and weight form current volume and weight respectively
-(void)removeItem:(id<ItemProtocol>)itemToDrop;
//NO If current volume minus expansionPack's volume > initial capacity
///YES otherwise
-(BOOL)canDrop:(id<ItemProtocol>)itemToDrop;

@end
