//
//  Chest.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/23/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "Chest.h"

@implementation Chest

-(id)init
{
    return [self initWithLabel:@"EmptyChest" andDescription:@"Worthless material"];
}

//By default items are capable of being picked up
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription
{
    if(nil != self){
        items = [[NSMutableDictionary alloc]init];
        //Properties from ItemProtocol
        [self setLabel:theLabel];
        [self setItemDescription:theDescription];
        [self setWeight:1.0];
        [self setVolume:1.0];
        [self setIsStationary:YES];
        [self setSellValue:10];
        [self setBuyValue:15];
    }
    return self;
}

-(NSMutableDictionary*)getInventory
{
    return items;
}
-(id<ItemProtocol>)getItem:(NSString *)theLabel
{
    return [items objectForKey:theLabel];
}

-(void)addItem:(id<ItemProtocol>)item
{
     [items setObject:item forKey:[item label]];
}
-(void)removeItem:(id<ItemProtocol>)itemToDrop
{
    [items removeObjectForKey:[itemToDrop label]];
}

-(double)value
{
    double totalValue = sellValue;
    for(id<ItemProtocol> item in items)
    {
        totalValue += [item sellValue];
    }
    return totalValue;
}

-(NSString *)printInventory
{
	return [self description];
}

+(Chest *)defaultChest
{
    Chest *container = [[Chest alloc] initWithLabel:@"chest" andDescription:@"The container may contain items"];
    
    Item *weapon = [[Item alloc]initWithLabel:@"sword" andDescription:@"A long sword used for fighting"];
    [weapon setBuyValue:10];
    [weapon setSellValue:20];
    
    Item *armor = [[Item alloc]initWithLabel:@"armor" andDescription:@"A thick chain mail"];
    [weapon setBuyValue:10];
    [weapon setSellValue:20];
    
    Item *metal = [[Item alloc]initWithLabel:@"metal" andDescription:@"This is a dense material"];
    [weapon setBuyValue:10];
    [weapon setSellValue:20];
    
    Item *can = [[Item alloc]initWithLabel:@"can" andDescription:@"A worthless can"];
    [weapon setBuyValue:10];
    [weapon setSellValue:0];
    
    [container addItem:weapon];
    [container addItem:armor];
    [container addItem:metal];
    [container addItem:can];
    
    return [container autorelease];
}


-(NSString *)description
{
	//NSArray *itemList = [inventory allKeys];
	return [NSString stringWithFormat:@"%@\n%@", itemDescription, [[items allKeys] componentsJoinedByString:@" "]];
}

@end
