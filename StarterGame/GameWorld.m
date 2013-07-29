//
//  GameWorld.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "GameWorld.h"
#import "EchoRoomDelegate.h"
#import "ForceFieldRoomDelegate.h"
#import "TradeRoomDelegate.h"
#import "ExitRoomDelegate.h"
#import "MerchantDelegate.h"
#import "CharWithDirectionsDelegate.h"
#import "CharWithRewardDelegate.h"
#import "AlarmClock.h"
#import "Chest.h"

@implementation GameWorld

@synthesize entrance;

static GameWorld *myOnlyInstance = nil;

+(id)sharedInstance
{
    if(!myOnlyInstance){
        //If there is not an instance of gameWorld instantiate one
         myOnlyInstance = [[[self class] alloc] init];
        //Game world generates world
        [myOnlyInstance createWorld];
        //Explicitly set exit in entrance to Alternative world
        [[myOnlyInstance entrance] setExit:@"Village" toRoom:[myOnlyInstance createWorldAlternate]];
        [myOnlyInstance registerForNotification];
    }
    return myOnlyInstance;
}

-(id)init
{
    self = [super init];
    if(nil != self)
    {
        //roomsDictionary = [[NSMutableDictionary alloc]init] ;
        triggerRoom = nil;
        fromRoom = nil;
        toRoom = nil;
    }
    return self;
}

-(Room *)createWorldAlternate
{
    //Creation of rooms
	Room *outside, *boulevard, *theGreen, *schuster, *tradeCenter;
	
	outside = [[[Room alloc] initWithTag:@"outside the main entrance of the university"] autorelease];
	boulevard = [[[Room alloc] initWithTag:@"on the boulevard"] autorelease];
	theGreen = [[[Room alloc] initWithTag:@"in the green in front of Schuster Center"] autorelease];
	schuster = [[[Room alloc] initWithTag:@"in the Schuster Center"] autorelease];
    tradeCenter = [[[Room alloc]initWithTag:@"The Bazaar"]autorelease];
	//End creation of rooms
    
    //Set relationships between rooms
	[outside setExit:@"boulevard" toRoom:boulevard];
    [tradeCenter setExit:@"boulevard" toRoom:boulevard];
	[boulevard setExit:@"outside" toRoom:outside];
    [boulevard setExit:@"tradingCenter" toRoom:tradeCenter];
    [boulevard setExit:@"theGreen" toRoom:theGreen];	
	
	[theGreen setExit:@"schuster" toRoom:schuster];
	[theGreen setExit:@"boulevard" toRoom:boulevard];
    
    [schuster setExit:@"theGreen" toRoom:theGreen];
    //end set relationships between rooms
    
    //Create Room Delegates
    ForceFieldRoomDelegate *fDelegate = [[[ForceFieldRoomDelegate alloc]init]autorelease];
    [fDelegate setMagicWord:@"money"];
    TradeRoomDelegate *tradeRoomDelegate = [[[TradeRoomDelegate alloc]init]autorelease];
    EchoRoomDelegate *echoRoom = [[[EchoRoomDelegate alloc]init]autorelease];
    //end create room delegates
    
    //Give rooms room delegates
    [schuster setDelegate:echoRoom];   
    [theGreen setDelegate:fDelegate];   
    [tradeCenter setDelegate:tradeRoomDelegate];
    
    //Create Merchant delegate
    MerchantDelegate *merchantDelegate = [[MerchantDelegate alloc]init];
    //Create characters in trade room in order to have someone to buy from and sell to
    Player *merchant1 = [[Player alloc]initWithRoom:tradeCenter andIO:nil];
    Player *merchant2 = [[Player alloc]initWithRoom:tradeCenter andIO:nil];
    Player *merchant3 = [[Player alloc]initWithRoom:tradeCenter andIO:nil];
    //Set merchant's delegate
    [merchant1 setDelegate:merchantDelegate];
    [merchant2 setDelegate:merchantDelegate];
    [merchant3 setDelegate:merchantDelegate];
    //Add merchants to trading room
    [tradeCenter setCharacter:@"BlackSmith" toPlayer:merchant1];
    [tradeCenter setCharacter:@"Farmer" toPlayer:merchant2];
    [tradeCenter setCharacter:@"Merchant" toPlayer:merchant3];
    
    //Create Items
    Item *key = [[Item alloc]initWithLabel:@"key" andDescription:@"The key to the southgate and your hope for leaving the king's castle alive!"];
    [key setVolume:2];
    [key setWeight:1];
    [key setBuyValue:1000];
    
    Item *gloves = [[Item alloc]initWithLabel:@"gloves" andDescription:@"leather gloves"];
    [gloves setVolume:1];
    [gloves setWeight:1];
    //End create items
    
    //Give merchants items
    [[merchant1 getInventory]addItem:key];
    [[merchant1 getInventory]addItem:gloves];
    
    AlarmClock *alarm = [[AlarmClock alloc]initWithRoom:boulevard];
    [boulevard setItem:alarm];
    
    triggerRoom = schuster;
    fromRoom = schuster;	
	return outside;
}

-(void)createWorld
{
     int i = 4;
    //number of interior rooms
    //+3 offsets a result of 0
    int c = (arc4random() % i)+3;
    //number of exterior rooms
    int h = (2 * c) + 2;
    
    //
    //NAMES
    //names of interior rooms
    NSMutableArray *itags = [[[NSMutableArray alloc]initWithObjects:@"courtyard", @"bridge",@"walkway", @"road",@"trail", @"path", nil]autorelease];
    //names of exterior rooms
    NSMutableArray *etags = [[[NSMutableArray alloc]initWithObjects:@"inn",@"castle", @"pub", @"stable", @"farm", @"casino", @"auditorium", @"field", @"church", @"temple",@"school", @"alter", @"tower", @"deck", nil]autorelease];
    //END NAMES
    //
    
    if([itags count] < (i+1) && [etags count] < (2*(i+1)+2)){
        //IMPORTANT THAT ITAGS LENGTH is ONE GREATER THAN i
        //IMPORTANT THAT ETAGS LENGTH is 2(i+1)+2
        NSLog(@"You either need more itags or more etags");
    }
    
    //LIST OF I & E ROOMS
    NSMutableArray *iRooms = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray *eRooms = [[[NSMutableArray alloc]init]autorelease];
    
    NSMutableDictionary *rooms = [[[NSMutableDictionary alloc]init]autorelease];   
    //
    //
    
    //
    //CREATE I ROOMS
    //RANDOMLY ADD itags to iRooms
    for(int i = 0;i < c; i++)
    {
        NSString *temp = [itags objectAtIndex: arc4random() % [itags count]];
        [iRooms addObject:[[[Room alloc] initWithTag:temp]autorelease]];
        [itags removeObject:temp];
    }
    //
    //    
    
    //
    //CREATE E ROOMS
    //RANDOMLY ADD etags to eRooms
    for(int i = 0;i < h; i++)
    {
        NSString *temp = [etags objectAtIndex: arc4random() % [etags count]];
        [eRooms addObject:[[[Room alloc] initWithTag:temp]autorelease]];
        [etags removeObject:temp];
    }
    //
    //
    
    //Add exterior and interior rooms to heterogenous array of rooms
    for(Room *interiorRoom in iRooms)
    {
        [rooms setObject:interiorRoom forKey:[interiorRoom tag]];
        //[self addRoom:interiorRoom andLabel:[interiorRoom tag]];
    }
    for(Room *exteriorRoom in eRooms)
    {
        [rooms setObject:exteriorRoom forKey:[exteriorRoom tag]];
        //[self addRoom:exteriorRoom andLabel:[exteriorRoom tag]];
    }
    //
    
    
    //
    //SET RELATIONSHIPS BETWEEN INTERIOR CHAIN
    for (int k = 0; k < [iRooms count]-1; k++) {
        Room *current = [iRooms objectAtIndex:k];
        Room *next = [iRooms objectAtIndex:k+1];
        
        [current setExit:[next tag] toRoom:next];
        [next setExit:[current tag] toRoom:current];
    }
    //END SET RELATIONS BETWEEN INTERIOR CHAIN
    //
    
    
    //
    //CREATE DICTIONARY TO STORE PAIRS (LABEL,DESCRIPTION) OF ITEMS
    //
    //IMPORTANT LENGTH OF GAMEITEMS MUST BE AT LEAST (i + 4)
    NSMutableDictionary *gameItems = [[[NSMutableDictionary alloc] init]autorelease];
    [gameItems setObject:@"noodles!" forKey:@"food"];
    [gameItems setObject:@"This will do" forKey:@"carpet"];
    [gameItems setObject:@"Used with a bow" forKey:@"arrows"];
    [gameItems setObject:@"Used for protection" forKey:@"sheild"];
    [gameItems setObject:@"Precious material!" forKey:@"gold"];
    [gameItems setObject:@"Dark Matter" forKey:@"rock"];
    [gameItems setObject:@"A manuscript" forKey:@"scroll"];
    [gameItems setObject:@"Money" forKey:@"coins"];
    [gameItems setObject:@"Cheap jewelry" forKey:@"ring"];
      [gameItems setObject:@"Nice jewelry" forKey:@"amulet"];
    
    //CREATE LIST OF KEYS
    NSArray *tempKeys = [gameItems allKeys];
    NSMutableArray *keys = [[[NSMutableArray alloc]init]autorelease];
    for(id label in tempKeys)
    {
        [keys addObject:label];
    }
    
    //RANDOMLY CREATE ITEMS IN RANDOMLY SELECTED ROOMS
    for (int m = 0; m < (h+6)/2; m++) {
        NSString *itemByName = [keys objectAtIndex:arc4random()% [keys count]];
        
        [[eRooms objectAtIndex: arc4random() % [eRooms count]] setItem:[[Item alloc] initWithLabel:itemByName andDescription:[[gameItems objectForKey:itemByName]autorelease]]];
        [keys removeObject:itemByName];
    }
	//END CREATE ITEMS
    //

    
    //
    //CREATE GUARD CHARACTERS
    Player *charToGiveReward;
    Room *eRoom = [eRooms objectAtIndex:arc4random()%[eRooms count]];
    //eRoom is the location of character that gives reward at runtime
    charToGiveReward = [[[Player alloc]initWithRoom:eRoom andIO:nil]autorelease];
    [charToGiveReward setName:@"Walker"];
    //Capacity must be larger than volume of heirloom (which is bigger than intial capacity)
    [[charToGiveReward getInventory]setCarryVolumeCapacity:10];
    [eRoom setCharacter:[charToGiveReward name] toPlayer:charToGiveReward];
    CharWithRewardDelegate *rewardDelegate = [[[CharWithRewardDelegate alloc]init]autorelease];
    [charToGiveReward setDelegate:rewardDelegate];
    
    
    //END CREATE CHARACTERS
    //
    
    //
    //CREATE NPC CHARACTERS
    Player *npc;
    Room *iRoom = [iRooms objectAtIndex:arc4random()%[iRooms count]];
    
    npc = [[[Player alloc]initWithRoom:iRoom andIO:nil]autorelease];
    [npc setName:@"john"];
    [iRoom setCharacter:[npc name] toPlayer:npc];
    CharWithDirectionsDelegate *directionsDelegate = [[[CharWithDirectionsDelegate alloc]init]autorelease];
    [directionsDelegate setHasSpokenWithChar:NO];
    [npc setDelegate:directionsDelegate];
    
    
    //END CREATE CHARACTERS
    //
    
    
    //
    //SET RELATIONSHIP BETWEEN EACH I ROOM WITH E ROOMS
    for(int j = 0; j < [iRooms count]; j++)
        {
            Room *interior = [iRooms objectAtIndex:j];
            while([interior length] < 4){
                
                Room *exterior = [eRooms objectAtIndex:arc4random() % [eRooms count]];
                
                [interior setExit:[exterior tag] toRoom:exterior];
                [exterior setExit:[interior tag] toRoom:interior];
                
                [eRooms removeObject:exterior];
            }
        }
    //END SET RELATIONSHIP BETWEEN EACH I ROOM WITH E ROOMS
    //
    
    
    //
    //----AT THIS POINT IN EXECUTION eROOMS IS EMPTY----
    //    
    
    
    //
    //
    //GENERATE PATH BETWEEN GUARD AND NPC
    NSMutableArray *path = [eRoom genPathBetweenNPC:iRoom andGuard:eRoom andRooms:rooms];
    NSMutableArray *reversePath = [iRoom genPathBetweenNPC:eRoom andGuard:iRoom andRooms:rooms];
    //Resulting path
    NSMutableArray *result = [[[NSMutableArray alloc]init]autorelease];
    //Intersection of paths is the resulting directions
    for(id obj in path)
        if([reversePath containsObject:obj]){
            [result addObject:obj];
        }
    
    //Construct string from array containing path
    NSMutableString *directions = [[[NSMutableString alloc]init]autorelease];
    [directions appendString:@"There is a man looking for his family heirloom. He may have a reward for the person to return it to him! Go ask him yourself he is "];
    for(id roomTag in result)
    {
        [directions appendString:roomTag];
        [directions appendString:@" "];
    }
    //Set NPC dialog to constructed string
    [npc setDialog:directions];
    //END GENERATE PATH
    //
    //
    //
    
    //[roomsDictionary addEntriesFromDictionary:rooms];
    
   entrance = [iRooms objectAtIndex:arc4random()%[iRooms count]];
   toRoom = entrance;
    
    
    //SECIALTY ITEMS THAT ARE LIMITED IN THE NUMBER TO ADD TO GAME
    Item *expansion = [[ItemInventoryExpansion alloc]initWithLabel:@"bag" andDescription:@"expansion pack"];
    [expansion setSellValue:100];
    
    Chest *chest = [Chest defaultChest];
    [entrance setItem:expansion];
    [entrance setItem:chest];
    //end specialty items
    
    
    //Set exit to entrance room
    ExitRoomDelegate *endGameRoom = [[ExitRoomDelegate alloc]init];
    [entrance setDelegate:endGameRoom];
}

//
//NOTIFICATIONS
-(void)registerForNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillExitRoom:) name:@"playerWillExitRoomNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidExitRoom:) name:@"playerDidExitRoomNotification" object:nil];
     //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(npcDidExitRoom:) name:@"npcDidExitRoomNotification" object:nil];
}

-(void)playerWillExitRoom:(NSNotification *)notification{
    Player *player = (Player *)[notification object];
    if([player currentRoom] == triggerRoom){
        [fromRoom setExit:@"redpill" toRoom:toRoom];
    }
    [player outputMessage:[NSString stringWithFormat:@"The player will exit room %@",[[player currentRoom]tag]]];
}

-(void)playerDidExitRoom:(NSNotification *)notification{
    Player *player = (Player *)[notification object];
    [player outputMessage:[NSString stringWithFormat:@"The player did exit room. %@",[player currentRoom]]];
}

/*Attempt at dynamically updating path between charWithDirections and CharWithReward
-(void)npcDidExitRoom:(NSNotification *)notification{
    Player *player = (Player *)[notification object];
    NSString *oldPath = [player dialog];
    NSArray *roomsInPath = [oldPath componentsSeparatedByString:@" "];
    Room *eRoom = [player currentRoom];
    Room *iRoom = [roomsDictionary objectForKey:[roomsInPath objectAtIndex:[roomsInPath count]-2]];
    
      NSMutableArray *newPath = [iRoom genPathBetweenNPC:eRoom andGuard:iRoom andRooms:roomsDictionary];
    
    NSMutableArray *reversePath = [eRoom genPathBetweenNPC:iRoom andGuard:eRoom andRooms:roomsDictionary];
  
    //Resulting path
    NSMutableArray *result = [[[NSMutableArray alloc]init]autorelease];
    //Intersection of paths is the resulting directions
    for(id obj in newPath)
        if([reversePath containsObject:obj]){
            [result addObject:obj];
        }
    
    //Construct string from array containing path
    NSMutableString *directions = [[[NSMutableString alloc]init]autorelease];
    [directions appendString:@"There is a man looking for his family heirloom. He may have a reward for the person to return it to him! Go ask him yourself he is "];
    for(id roomTag in result)
    {
        [directions appendString:roomTag];
        [directions appendString:@" "];
    }
    //Set NPC dialog to constructed string
    [player setDialog:directions];
}
 */

//END NOTIFICATIONS
//


@end
