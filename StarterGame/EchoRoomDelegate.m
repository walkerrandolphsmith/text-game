//
//  EchoRoomDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/2/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "EchoRoomDelegate.h"

@implementation EchoRoomDelegate

-(void)say:(NSString *)word fromRoom:(Room *)room
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithCapacity:10];
    NSString *echoedWord = [NSString stringWithFormat:@"%@ %@ %@",word,word,word];
    [userInfo setObject:echoedWord forKey:@"sound"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"soundFromRoomNotification" object:room userInfo:[userInfo autorelease]];
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
    return NO;
}

-(BOOL)isExitRoom
{
    return NO;
}

@end
