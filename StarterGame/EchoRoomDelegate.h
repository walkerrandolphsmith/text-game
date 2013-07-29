//
//  EchoRoomDelegate.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/2/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomDelegate.h"

@class Room;
@interface EchoRoomDelegate : NSObject<RoomDelegate>

-(void)say:(NSString *)word fromRoom:(Room *)room;
-(BOOL)forceField;
-(BOOL)isTradeRoom;
-(BOOL)isExitRoom;

@end
