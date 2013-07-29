//
//  ForceFieldRoomDelegate.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/4/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomDelegate.h"
@interface ForceFieldRoomDelegate : NSObject<RoomDelegate> {
    BOOL state;
    NSString *magicWord;
}

@property (retain, nonatomic)NSString *magicWord;

-(void)say:(NSString *)word fromRoom:(Room *)room;
-(BOOL)forceField;
-(void)passcode:(NSString *)word;
-(BOOL)isTradeRoom;
-(BOOL)isExitRoom;

@end
