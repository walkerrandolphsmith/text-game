//
//  ExitRoomDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "ExitRoomDelegate.h"

@implementation ExitRoomDelegate


-(void)say:(NSString *)word fromRoom:(Room *)room
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithCapacity:10];
    [userInfo setObject:@"The southern gate to the castle. This is the route you will use to exit the kings castle. If only you had a key." forKey:@"sound"];
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
    return NO;
}

-(BOOL)isExitRoom
{
    return YES;
}


@end
