//
//  GameWorld.h
//  StarterGame
//
//  Created by Jacob Bernett on 3/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Item.h"
#import "Player.h"

@interface GameWorld : NSObject {
    Room *entrance;
    Room *triggerRoom, *fromRoom, *toRoom;
}

@property (readonly, nonatomic) Room *entrance;

+(id)sharedInstance;

-(void)createWorld;
-(Room *)createWorldAlternate;

//
//NOTIFICATIONS
//Make GameWorld an observer
-(void)registerForNotification;
//Notification center will call this method on GameWorld to tell it the event will happen
-(void)playerWillExitRoom:(NSNotification *)notification;
-(void)playerDidExitRoom:(NSNotification *)notification;
//END NOTIFICATIONS
//
@end
