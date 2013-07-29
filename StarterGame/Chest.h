//
//  Chest.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/23/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "InventoryProtocol.h"

@interface Chest : Item<ItemProtocol>{
    NSMutableDictionary *items;
}

@property (retain, nonatomic)NSString *label;
@property (retain, nonatomic)NSString *itemDescription;
@property (assign, nonatomic)double weight;
@property (assign, nonatomic)double volume;
@property (assign, nonatomic)BOOL isStationary;
@property (assign, nonatomic)double sellValue;
@property (assign, nonatomic)double buyValue;

-(id)init;
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription;

-(NSString*)printInventory;
-(NSMutableDictionary*)getInventory;
-(id<ItemProtocol>)getItem:(NSString *)theLabel;
-(void)addItem:(id<ItemProtocol>)item;
-(void)removeItem:(id<ItemProtocol>)itemToDrop;

+(Chest *)defaultChest;

@end
