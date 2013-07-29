//
//  ExitRoomDelegate.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomDelegate.h"

@interface ExitRoomDelegate : NSObject<RoomDelegate>

-(void)say:(NSString *)word fromRoom:(Room *)room;
-(BOOL)forceField;
-(void)passcode:(NSString *)word;
-(BOOL)isTradeRoom;
-(BOOL)isExitRoom;

@end
