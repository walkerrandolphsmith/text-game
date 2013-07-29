//
//  Room.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//

#import "Room.h"

@implementation Room

@synthesize tag;
@synthesize delegate;

-(id)init
{
	return [self initWithTag:@"No Tag"];
}

-(id)initWithTag:(NSString *)newTag
{
	self = [super init];
    
	if (nil != self) {
		[self setTag:newTag];
		exits = [[NSMutableDictionary alloc] initWithCapacity:10];
        items = [[NSMutableDictionary alloc] initWithCapacity:10];
        characters = [[NSMutableDictionary alloc] initWithCapacity:10];
        [self setDelegate:nil];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidConverseWithCharacter) name:@"playerDidConverseWithCharacterNotification" object:nil];
	}
	return self;
}

-(void)playerDidConverseWithCharacter
{
    if([self tag] == @"outside the main entrance of the university")
    {
        Item *storyLineItem = [[Item alloc]initWithLabel:@"heirloom" andDescription:@"Family heirloom. This must be valuable to someone"];
        [storyLineItem setSellValue:1000];
        [storyLineItem setBuyValue:100000];
        [storyLineItem setVolume:6];
        [self setItem:storyLineItem];
    }
}

//Number of exits a given room contains
-(int)length
{
    return (int)[exits count];
}

//Add an exit to a room's list of exits
-(void)setExit:(NSString *)exit toRoom:(Room *)room
{
	[exits setObject:room forKey:exit];
}
//Retrieve an exit from the room's lists of exits
-(Room *)getExit:(NSString *)exit
{
	return [exits objectForKey:exit];
}

//Retrieve an exit from the room's list of exits and remove it form the list of exits
-(Room *)getAndRemoveExit:(NSString *)theExit{
    Room *tempRoom = [exits objectForKey:theExit];
    if(tempRoom){
        [tempRoom retain];
        [exits removeObjectForKey:theExit];
    }
    return [tempRoom autorelease];
}


//Helper for printing all exits in room
-(NSArray *)getExits
{
	NSArray *exitNames = [exits allKeys];
	return exitNames;
}

//Drop Item
//Add an item to the room's list of items.
-(void)setItem:(id<ItemProtocol>)item
{
	[items setObject:item forKey:[item label]];
}

//Retrieve an item from the room's list of items
-(id<ItemProtocol>)getItem:(NSString *)label
{
	return [items objectForKey:label];
}

//Pickup Item
//Remove an item from the room's list of items and return that item
-(id<ItemProtocol>)getAndRemoveItem:(NSString *)label
{
	id<ItemProtocol> selectedItem = [items objectForKey:label];
    if(selectedItem){
        [selectedItem retain];
        [items removeObjectForKey:label];
    }
    return selectedItem;
}

//Helper for printing all items in room
-(NSArray *)getItems
{
	NSArray *itemList = [items allKeys];
	return itemList;
}

//Add character to the room' list of characters
-(void)setCharacter:(NSString *)name toPlayer:(Player *)character
{
    [characters setObject:character forKey:name];
}

//Retrieve character from the room's list of characters
-(Player *)getCharacter:(NSString *)name
{
    return [characters objectForKey:name];
}

//Helper for printing all characters in room
-(NSArray *)getCharacters
{
    NSArray *charList = [characters allKeys];
	return charList;
}

//Breadth depth search to generate path between npc and guard
-(NSMutableArray *)genPathBetweenNPC:(Room *)start andGuard:(Room *)finish andRooms:(NSMutableDictionary *)rooms
{
    NSMutableArray *path = [[NSMutableArray alloc]init];
    
    NSMutableArray *L = [[NSMutableArray alloc]init];
    [L addObject:[start tag]];
    [path addObject:[start tag]];
    
    while ([L count] > 0) {
        NSString *cRoomTag = [L objectAtIndex:0];
        [L removeObject:[L objectAtIndex:0]];
        
        Room *cRoom = [rooms objectForKey:cRoomTag];
        NSArray *cExits = [cRoom getExits];
        
        if([cExits containsObject:[finish tag]])
        {
            [path addObject:[finish tag]];
            break;
        }
        else{
            
            for(id exit in cExits)
            {
                if(![L containsObject:exit])
                {
                    if (![path containsObject:exit]) {
                        Room *nextRoom = [rooms objectForKey:exit];
                        NSArray *nextExits = [nextRoom getExits];
                        if([nextExits count]>2)
                        {
                            [path addObject:exit];
                        }
                    }                
                    [L addObject:exit];
                }
            }
        }        
    }
    return path;
}


-(void)say:(NSString *)word
{
    //Unimplemented on purpose
}
//If the echo delegate exists in the given room then pass responisbility to saying to the delgate
//Otherwise send as notification
-(void)say:(NSString *)word fromRoom:(Room *)room
{
    if(delegate)
    {
        [delegate say:word fromRoom:room];
    }
    else{
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithCapacity:10];
        [userInfo setObject:word forKey:@"sound"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"soundFromRoomNotification" object:self userInfo:[userInfo autorelease]];
    }
}

//Used to remove a force feild if the room has a force field delegate
-(void)passcode:(NSString *)word
{
   if(delegate)
   {
       [delegate passcode:word];
   }
}

//If the current room contains the given exit, then the room calls pascode with the given passcode
-(void)passCode:(NSString *)passcode forExit:(NSString *)exit
{
    Room *room = [self getExit:exit];
    if(room){
        [room passcode:passcode];
    }
}

//Does the room contain the force feild rooom delegate
-(BOOL)forceField
{
    BOOL answer = NO;
    if(delegate){
        answer = [delegate forceField];
    }
    return answer;
}

//Does the room contain the trade room delegate
-(BOOL)isTradeRoom
{
    BOOL answer = NO;
    if(delegate){
        answer = [delegate isTradeRoom];
    }
    return answer;
}

//Does the room contain the exit room delegate
-(BOOL)isExitRoom
{
    BOOL answer = NO;
    if(delegate){
        answer = [delegate isExitRoom];
    }
    return answer;
}

//Print a room
-(NSString *)description
{
    NSString *roomChars = [NSString stringWithFormat:@"NPCs: %@", [[self getCharacters] componentsJoinedByString:@" "]];
    
    NSString *roomExits = [NSString stringWithFormat:@"Exits: %@", [[self getExits] componentsJoinedByString:@" "]];
    
    NSString *roomItems = [NSString stringWithFormat:@"Items: %@", [[self getItems] componentsJoinedByString:@" "]];
    
	return [NSString stringWithFormat:@"You are %@.\n \t %@\n \t %@\n \t %@\n", tag, roomExits, roomItems,roomChars];
}

-(void)dealloc
{
	[tag release];
	[exits release];
	[items release];
    [characters release];
    [delegate release];
    
	[super dealloc];
}

@end
