//
//  TradeRoomDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/24/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "TradeRoomDelegate.h"

@implementation TradeRoomDelegate

-(void)say:(NSString *)word fromRoom:(Room *)room
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithCapacity:10];
    [userInfo setObject:@"The noise from the trading posts is drowning out your voice" forKey:@"sound"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"soundFromRoomNotification" object:self userInfo:[userInfo autorelease]];
}
-(BOOL)forceField
{
    return NO;
}
-(void)passcode:(NSString *)word
{
    
}
-(BOOL)isTradeRoom
{
    return YES;
}

-(BOOL)isExitRoom
{
    return NO;
}

@end
