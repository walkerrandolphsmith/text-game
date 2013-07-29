//
//  Player.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "PlayerDelegate.h"
#import "Room.h"
#import "GameIO.h"
#import "PlayerInventory.h"
#import "Chest.h"

@interface Player : NSObject<PlayerDelegate>{
    //Object to wrap inventory;
    PlayerInventory *stash;
    NSMutableArray *goBackHistory;
    id delegate;
}

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;
@property (retain, nonatomic)NSString *name;
//Paths from npc to guard
@property (retain, nonatomic)NSMutableString *dialog;
@property (retain, nonatomic)Room *specialPlace;
@property (retain, nonatomic)id roomDelegate;
@property (retain, nonatomic)Room *thePortal;
@property (assign, nonatomic)double currentValue;
@property (retain, nonatomic)id delegate;

-(id)init;
//init with gameworld entrance and IO
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO;
//Get the inventory wrapper
-(PlayerInventory*)getInventory;
//COMMAND INVENTORY
-(NSString *)printInventory;
//send message to IO
-(void)outputMessage:(NSString *)message;

//COMMAND GO
-(void)walkTo:(NSString *)direction;
//COMMAND GOBACK
-(void)goBack;

//COMMAND EXAMINE
-(void)examine:(NSString *)label;

//YES if an item can be added to inventory, or output why not
-(BOOL)canAddItemToInventory:(id<ItemProtocol>)itemToPickUp;

//COMMAND PICKUP
-(void)pickup:(NSString *)label;
//COMMAND DROP
-(void)drop:(NSString *)label;

//COMMAND GIVE
-(void)give:(NSString*)theCharacter theItem:(NSString*)itemToGive;
//Helper method for give
-(void)giveTo:(Player*)recepient theItem:(id<ItemProtocol>)item;

//COMMAND TAKE
-(void)take:(NSString *)anItem formCharacter:(NSString*)character;
-(void)takeFrom:(Player*)giver theItem:(id<ItemProtocol>)item;

//COMMAND BUY
-(void)buyFrom:(NSString*)character anItem:(NSString*)item;
-(void)buyFrom:(Player*)seller theItem:(id<ItemProtocol>)item;

//COMMAND SELL
-(void)sellTo:(NSString*)buyer anItem:(NSString*)anItem;
-(void)sellTo:(Player*)buyer theItem:(id<ItemProtocol>)item;

//COMMAND PUT
-(void)put:(NSString *)itemToGive inContainer:(NSString *)theContainer;
-(void)put:(id<ItemProtocol>)item into:(id<ItemProtocol>)container;

//COMMAND GET
-(void)getItem:(NSString *)anItem fromContainer:(NSString*)container;
-(void)getAndRemoveItem:(id<ItemProtocol>)item fromContainer:(Chest<ItemProtocol>*)chest;

//COMMAND CONVERSEWITH
-(void)converseWith:(NSString *)character;

-(void)removeExit:(NSString *)theExit;
-(void)placeExit:(NSString *)theExit;

//COMMAND SAY
-(void)say:(NSString *)word;

//COMMAND PASSCODE
-(void)passCode:(NSString *)passcode forExit:(NSString *)exit;

//receive notifications from room
-(void)listen:(NSNotification *)notification;

//removeDelegatre Command
-(void)removeDelegate;
//placeDelegate Command
-(void)placeDelegate;

//COMMAND PORTAL
-(void)portal;

//PlayerDelegate methods
-(BOOL)isCharWithDirections;
-(BOOL)isCharWithReward;
-(BOOL)isMerchant;

-(NSString*)converseWith;

@end
