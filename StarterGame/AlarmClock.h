//
//  AlarmClock.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/16/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Room.h"

@interface AlarmClock : Item<ItemProtocol>{
    Room *room;
}

@property (retain, nonatomic)Room *room;

-(id)initWithRoom:(Room*)aRoom;
-(void)timesUp;

@end
