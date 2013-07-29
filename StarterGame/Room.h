//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Item.h"
#import "RoomDelegate.h"
@class Player;

@interface Room : NSObject<RoomDelegate> {
	NSMutableDictionary *exits;
    NSMutableDictionary *items;
    NSMutableDictionary *characters;
    id delegate;
}

@property (retain, nonatomic)NSString *tag;
@property (retain, nonatomic)id delegate;

-(id)init;
-(id)initWithTag:(NSString *)newTag;

-(int)length;

//Set and get rooms to/from list of rooms
-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(Room *)getExit:(NSString *)exit;
-(Room *)getAndRemoveExit:(NSString *)theExit;

//Set and get items to/from the list of items
-(void)setItem:(id<ItemProtocol>)item;
-(id<ItemProtocol>)getItem:(NSString *)label;
//Remove an item from the room's list of items
-(id<ItemProtocol>)getAndRemoveItem:(NSString *)label;

//Set and get char to/from list of chars
-(void)setCharacter:(NSString *)name toPlayer:(Player *)character;
-(Player *)getCharacter:(NSString *)character;

-(NSMutableArray *)genPathBetweenNPC:(Room *)start andGuard:(Room *)finish andRooms:(NSMutableDictionary *)rooms;

-(void)say:(NSString *)word;
-(void)passCode:(NSString *)passcode forExit:(NSString *)exit;
-(BOOL)forceField;
-(BOOL)isTradeRoom;

//HELPER METHODS FOR PRINTING
//list of keys for objects such as items, exits, and characters
-(NSArray *)getItems;
-(NSArray *)getExits;
-(NSArray *)getCharacters;

@end
