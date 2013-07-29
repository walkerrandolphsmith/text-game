//
//  Player.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Player.h"

@implementation Player

@synthesize currentRoom;
@synthesize io;
@synthesize name;
@synthesize dialog;
@synthesize roomDelegate;
@synthesize specialPlace;
@synthesize thePortal;
@synthesize currentValue;
@synthesize delegate;

-(id)init
{
	return [self initWithRoom:nil andIO:nil];
}

//init with [GameWorld entrance] and IO from Game
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO
{
	self = [super init];
    
	if (nil != self) {
		[self setCurrentRoom:room];
        [self setIo:theIO];
        stash = [[PlayerInventory alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listen:) name:@"soundFromRoomNotification" object:[self currentRoom]];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePath:) name:@"movementNotification" object:nil];
        [self setRoomDelegate:nil];
        [self setThePortal:nil];
        [self setCurrentValue:0];
        goBackHistory = [[NSMutableArray alloc]init];
        [self setDelegate:nil];
	}    
	return self;
}

-(PlayerInventory*)getInventory
{
    return stash;
}

-(NSString *)printInventory
{
    return [stash printInventory];
}

//GoCommand: Travel between rooms
-(void)walkTo:(NSString *)direction
{
	Room *nextRoom = [currentRoom getExit:direction];
	if (nextRoom)
    {
        if ([nextRoom isExitRoom] && [[self getInventory]getItem:@"key"] != nil) {
            [self outputMessage:@"You have compleleted the game"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEndGameNotification" object:self];
        }
        else
        {
            if([nextRoom forceField])
            {
                [self outputMessage:[NSString stringWithFormat:@"There is a force feild on %@.", direction]];
            }
            else
            {
                //BEFORE ACTION
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playerWillExitRoomNotification" object:self];
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"movementNotification" object:[self currentRoom]];
                //END BEFORE
                
                [goBackHistory addObject:currentRoom];
                
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"soundFromRoomNotification" object:[self currentRoom]];
                //Move player
                [self setCurrentRoom:nextRoom];
                //
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listen:) name:@"soundFromRoomNotification" object:[self currentRoom]];
                
                //AFTER ACTION
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidExitRoomNotification" object:self];
                //END AFTER
            }
        }
	}
	else
    {
        [self outputMessage:[NSString stringWithFormat:@"\nThere is no door on %@!", direction]];
	}
}

-(void)goBack
{
    if([goBackHistory count]>0){
        
        currentRoom = [goBackHistory lastObject];        
        [goBackHistory removeLastObject];
        [self outputMessage:[[self currentRoom]description]];
        if ([currentRoom isExitRoom] && [[self getInventory]getItem:@"key"] != nil) {
            [self outputMessage:@"You have compleleted the game"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerDidEndGameNotification" object:self];
        }
        
    }
    else{
        [self outputMessage:@"We are were we started sir."];
    }
}

//Examine Command: Retreive the descirption of an item
-(void)examine:(NSString *)label
{
    id<ItemProtocol> itemInstash = [[stash getInventory] objectForKey:label];
    id<ItemProtocol> itemInroom = [[self currentRoom]getItem:label];
    
    //if the item is not in the room or in your inventory
    if (nil == itemInstash && nil == itemInroom) {
        [self outputMessage:[NSString stringWithFormat:@"Try looking somewhere else for %@",label]];
    }
    else
    {
        if (nil != itemInstash) {
            [self outputMessage:[itemInstash description]];
        }
        if (nil != itemInroom) {
            [self outputMessage:[itemInroom description]];
        }
    }
}

//Determines if the given item can be picked up and if not outputs why the item cannot be added to the inventory
-(BOOL)canAddItemToInventory:(id<ItemProtocol>)itemToPickUp
{
    BOOL result = NO;
    if (nil != itemToPickUp)
    {
        //The item is capable of being picked up
        if(![itemToPickUp isStationary])
        {
            if(!([stash hasExpansion]==YES && [itemToPickUp isKindOfClass:[ItemInventoryExpansion class]]))
            {
                if([stash canCarry:itemToPickUp])
                {
                    result = YES;
                }
                else//The items weight + stash's current weight is greater than capacity
                {
                    [self outputMessage:[stash wasTooBigOrTooHeavy:itemToPickUp]];
                }
            }
            else//The stash already contains an expansion pack
            {
                [self outputMessage:@"Only one expansion can be carried at a time"];
            }
        }
        else//The item is not capable of being picked up
        {
            [self outputMessage:@"The object will not budge"];
        }
    }
    else//There is no item for this label
    {
        [self outputMessage:@"There is no such item to pick up."];
    }
    return result;

}
//COMMAND PICKUP Remove item from current room and add item to inventory
-(void)pickup:(NSString *)label
{
    Item *itemToPickUp = [currentRoom getItem:label];
    if ([self canAddItemToInventory:itemToPickUp])
    {
        [stash addItem:itemToPickUp];
        [currentRoom getAndRemoveItem:label];
        [self outputMessage:@"The item was pickup up"];
    }
    else
    {
        //Appropriate message was served after addItemToInventory returns if the item could not be added to the players inventory
    }
}

//COMMAND DROP Remove item from inventory and add item to current room
-(void)drop:(NSString *)label
{
    id<ItemProtocol> itemToDrop = [stash getItem:label];
    
    if(nil != itemToDrop)
    {
        if(![stash canDrop:itemToDrop])
        {
            [self outputMessage:@"You rely on the bag to hold your items. Drop items before dropping the bag."];
        }
        else
        {
            [stash removeItem:itemToDrop];
            [currentRoom setItem:itemToDrop];
            [self outputMessage:@"You dropped the item"];
        }
    }
    else//Item was nil
    {
        [self outputMessage:@"No such item in your inventory"];
    }
}

//COMMAND GIVE 
-(void)give:(NSString *)theCharacter theItem:(NSString *)itemToGive
{  
    Player *recepient = [[self currentRoom]getCharacter:theCharacter];
    if(nil != recepient)
    {
        id<ItemProtocol> item = [stash getItem:itemToGive];
        
        if(nil !=item)
        {
            [self giveTo:recepient theItem:item];
        }
        else//The item is nil
        {
            [self outputMessage:@"There is no item in your stash of that name"];
        }
    }
    else//The character is nil
    {
        [self outputMessage:@"This character is not in the current room"];
    }
}
//give command helper
-(void)giveTo:(Player*)recepient theItem:(id<ItemProtocol>)item
{
    //Determine if the item can be dropped from your inventory
    if([stash canDrop:item])
    {
        if ([[recepient getInventory]canCarry:item])
        {
            [stash removeItem:item];
            [[recepient getInventory]addItem:item];
            [self outputMessage:@"The item was exchanged"];
            if ([[recepient delegate]isCharWithReward] && [item label]==@"heirloom") {
                [self setCurrentValue:1000];
            }
        }
        else//Item cannot be picked up by character
        {
            [self outputMessage:@"The character cannot take the item"];
        }
    }
    else//Item cannot be dropped from your inventory
    {
        [self outputMessage:@"You rely on the bag to hold your items. Drop some items first"];
    }

}

//COMMAND TAKE
-(void)take:(NSString *)anItem formCharacter:(NSString*)character
{
    Player *giver = [[self currentRoom]getCharacter:character];
    if(nil != giver)
    {
        id<ItemProtocol> item = [[giver getInventory] getItem:anItem];
        
        if(nil != item)
        {
            [self takeFrom:giver theItem:item];
        }
        else//The item is nil
        {
            [self outputMessage:@"The character does not have an item of that name"];
        }
    }
    else//The character is nil
    {
        [self outputMessage:@"This character is not in the current room"];
    }   
}
//take command helper
-(void)takeFrom:(Player*)giver theItem:(id<ItemProtocol>)item
{
    //Determine if the item can be dropped from your inventory
    if([[giver getInventory] canDrop:item])
    {
        if ([self canAddItemToInventory:item])
        {
            [[giver getInventory] removeItem:item];
            [stash addItem:item];
            [self outputMessage:@"The item was exchanged"];
        }
        else//Item cannot be picked up by character
        {
             //Appropriate message was served after addItemToInventory returns if the item could not be added to the players inventory
        }
    }
    else//Item cannot be dropped from your inventory
    {
        [self outputMessage:@"The character relies on the bag to hold items."];
    }
}

//COMMAND BUYFROM
-(void)buyFrom:(NSString*)character anItem:(NSString*)anItem
{
    Player *merchant = [[self currentRoom]getCharacter:character];
    if(nil != merchant)
    {
        id<ItemProtocol> item = [[merchant getInventory] getItem:anItem];
        
        if(nil != item)
        {
            [self buyFrom:merchant theItem:item];
        }
        else//The item is nil
        {
            [self outputMessage:@"The character does not have an item of that name"];
        }
    }
    else//The character is nil
    {
        [self outputMessage:@"None of the merchants will respond to that name."];
    }
}
//buyFrom helper method
-(void)buyFrom:(Player*)seller theItem:(id<ItemProtocol>)item
{
    //Determine if the item can be dropped from your inventory
    if([[seller getInventory] canDrop:item])
    {
        if ([self canAddItemToInventory:item])
        {
            if ([self currentValue] < [item buyValue]) {
                [self outputMessage:@"You do not have enough money"];
            }
            else
            {
                [[seller getInventory] removeItem:item];
                [seller setCurrentValue:[seller currentValue]+[item sellValue]];
                [stash addItem:item];
                [self setCurrentValue:[self currentValue]-[item buyValue]];
                [self outputMessage:@"The item was purchased"];
            }
        }
        else//Item cannot be picked up by character
        {
             //Appropriate message was served after addItemToInventory returns if the item could not be added to the players inventory
        }
    }
    else//Item cannot be dropped from your inventory
    {
        [self outputMessage:@"The character relies on the bag to hold items."];
    }
}

//COMMAND SELLTO
-(void)sellTo:(NSString*)buyer anItem:(NSString*)anItem
{
    Player *merchant = [[self currentRoom]getCharacter:buyer];
    if(nil != merchant)
    {
        id<ItemProtocol> item = [stash getItem:anItem];
        
        if(nil != item)
        {
            [self sellTo:merchant theItem:item];
        }
        else//The item is nil
        {
            [self outputMessage:@"The character does not have an item of that name"];
        }
    }
    else//The character is nil
    {
        [self outputMessage:@"None of the merchants will respond to that name."];
    }

}
//sellTo helper method
-(void)sellTo:(Player*)buyer theItem:(id<ItemProtocol>)item
{
    if ([stash canDrop:item]) {
        [stash removeItem:item];
        [self setCurrentValue:[self currentValue] + [item sellValue]];
        [[buyer getInventory]addItem:item];
        [self outputMessage:@"The exachange was made"];
    }
    else
    {
        [self outputMessage:@"You cannot sell an item that you depend on to hold other items"];
    }
}

//COMMAND PUT
-(void)put:(NSString *)itemToGive inContainer:(NSString *)theContainer
{
    Item<ItemProtocol> *chest = [[self currentRoom]getItem:theContainer];
    if (nil != chest)
    {
        if ([chest respondsToSelector:@selector(getInventory)])
        {
            id<ItemProtocol> item = [stash getItem:itemToGive];
            if (nil != item)
            {
                [self put:item into:chest];
            }
            else
            {
                [self outputMessage:@"There is no item to put in the chest"];
            }
        }
        else//The item is not the chest
        {
            [self outputMessage:@"This object cannot container items"];
        }
    }
    else//The Container is nil
    {
        [self outputMessage:@"The container is not in the room"];
    }
}
//put helper method
-(void)put:(id<ItemProtocol>)item into:(id<ItemProtocol>)container
{
    Chest<ItemProtocol> *chest = container;
    //Determine if the item can be dropped from your inventory
    if([stash canDrop:item])
    {
            [stash removeItem:item];
            [chest addItem:item];
            [self outputMessage:@"The item was put in the container"];
    }
    else//Item cannot be dropped from your inventory
    {
        [self outputMessage:@"You rely on the bag to hold your items. Drop some items first"];
    }
}

//COMMAND GETITEM get items from container items
-(void)getItem:(NSString *)anItem fromContainer:(NSString*)container
{
    Chest<ItemProtocol> *chest = [[self currentRoom]getItem:container];
    if(nil != chest)
    {
        id<ItemProtocol> item = [chest getItem:anItem];
        
        if(nil != item)
        {
            [self getAndRemoveItem:item fromContainer:chest];
        }
        else//The item is nil
        {
            [self outputMessage:@"The container does not have an item of that name"];
        }
    }
    else//The character is nil
    {
        [self outputMessage:@"This character is not in the current room"];
    }
    
}
//getItem helper method
-(void)getAndRemoveItem:(id<ItemProtocol>)item fromContainer:(Chest<ItemProtocol>*)chest
{
        if ([self canAddItemToInventory:item])
        {
            [chest removeItem:item];
            [stash addItem:item];
            [self outputMessage:@"The item was exchanged"];
        }
        else//Item cannot be picked up by character
        {
            //Appropriate message was served after addItemToInventory returns if the item could not be added to the players inventory
        }
}

//COMMAND CONVERSEWITH : Retrieve the dialog property from a character in the current room
-(void)converseWith:(NSString *)character
{
    Player *npc = [currentRoom getCharacter:character];
    if (npc != nil)
    {
        if ([npc delegate])
        {
            if ([[npc delegate]isCharWithDirections]) {
                   [self outputMessage:[npc dialog]];
                [[npc delegate]setHasSpokenWithChar:YES];
            }
            else
            {
                [self outputMessage:[[npc delegate] converseWith]];
            }
        }
    }
    else
    {
        [self outputMessage:@"There is not a person to talk to of that name"];
    }
  
}

//Remove an exit from a room's list of exits
-(void)removeExit:(NSString *)theExit
{
    if(![self specialPlace]){
        Room *theOne = [[self currentRoom] getAndRemoveExit:theExit];
        if(theOne){
            [self setSpecialPlace:theOne];
        }
        else{
            [self outputMessage:[NSString stringWithFormat:@"There is no exit at %@", theExit]];
        }
    }
}

//Add an exit to a room's list of exits
-(void)placeExit:(NSString *)theExit
{
    if([self specialPlace]){
        [[self currentRoom]setExit:theExit toRoom:[self specialPlace]];
        [self setSpecialPlace:nil];
    }
}

//COMMAND SAY send a string to the current room
-(void)say:(NSString *)word
{
    [currentRoom say:word fromRoom:[self currentRoom]];
}

//COMMAND PASSCODE send a passcode and exit to the current room
-(void)passCode:(NSString *)passcode forExit:(NSString *)exit
{
    [currentRoom passCode:passcode forExit:exit];
}

//Recieve a notification about a sound
-(void)listen:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *sound = [userInfo objectForKey:@"sound"];
    if(sound){
        [self outputMessage:sound];
    }
}
//

/*
-(void)updatePath:(NSNotification *)notification
{
    if (delegate) {
        if ([delegate isCharWithDirections]) {
            Room *oldRoom = (Room *)[notification object];
            NSArray *possibleNewRooms = [oldRoom getExits];
            Room *newRoom = [oldRoom getExit:[possibleNewRooms objectAtIndex:(arc4random() % [possibleNewRooms count])]];
            if (![newRoom forceField]) {
                [self setCurrentRoom:newRoom];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"npcDidExitRoomNotification" object:self];
        }
    }
}
 */

//remove a delegate form a current room
-(void)removeDelegate
{
    if(!roomDelegate){
        [self setRoomDelegate :[currentRoom delegate]];
        [currentRoom setDelegate:nil];
    }
    else{
        [self outputMessage:@"I already have a room delegate."];
    }
}

//place a delegate in a current room
-(void)placeDelegate
{
    if(![currentRoom delegate]){
        [currentRoom setDelegate:roomDelegate];
        [self setRoomDelegate:nil];
    }
    else{
        [self outputMessage:@"The room already has a delegate."];
    }
}

//COMMAND PORTAL
-(void)portal
{
    if (thePortal) {
        [[self currentRoom] setExit:@"portal" toRoom:thePortal];
        Room *theOldRoom = [self currentRoom];
        [self outputMessage:@"Whooosh using the portal"];
        [self walkTo:@"portal"];
        [theOldRoom getAndRemoveExit:@"portal"];
    }
    else{
        [self setThePortal:[self currentRoom]];
        [self outputMessage:@"You set the target room for the portal"];
    }
}

//Print to console
-(void)outputMessage:(NSString *)message
{
    NSMutableString *tempMessage = [[[NSMutableString alloc]init]autorelease];
    [tempMessage appendString:message];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithCapacity:10];
    [userInfo setObject: tempMessage forKey:@"wordsToBeSpoken"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionBecameActiveNotification" object:self userInfo:userInfo];    
    
    [io sendLines:tempMessage];
}

//Implemented PlayerDelegate methods

-(BOOL)isCharWithDirections
{
    return NO;
}
-(BOOL)isCharWithReward
{
    return NO;
}
-(BOOL)isMerchant
{
    return NO;
}

-(BOOL)getHasSpokenWithChar
{
    return NO;
}

-(void)setHasSpokenWithChar:(BOOL)truth
{
    ;
}

-(NSString*)converseWith
{
    return @"";
}

-(void)dealloc
{
	[currentRoom release];
    [io release];
    [stash release];
    [delegate release];
    [goBackHistory release];
	
	[super dealloc];
}

@end
