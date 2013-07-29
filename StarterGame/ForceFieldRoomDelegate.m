//
//  ForceFieldRoomDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/4/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "ForceFieldRoomDelegate.h"

@implementation ForceFieldRoomDelegate

@synthesize magicWord;

-(id)init
{
    self = [super init];
    if(self != nil){
        state = YES;
        magicWord = nil;
    }
    return self;
}



-(void)say:(NSString *)word fromRoom:(Room *)room
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithCapacity:10];
    [userInfo setObject:word forKey:@"sound"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"soundFromRoomNotification" object:self userInfo:[userInfo autorelease]];
   
}
-(BOOL)forceField
{
    return state;
}

-(void)passcode:(NSString *)word
{
    if([magicWord isEqualToString:word]){
        state = !state;
    }
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
