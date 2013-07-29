//
//  CharWithDirectionsDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "CharWithDirectionsDelegate.h"

@implementation CharWithDirectionsDelegate

-(BOOL)isCharWithDirections
{
    if (!hasSpokenWithChar) {
        //As soon as the player is asked if he is character with directions, and he is, send the notification to the room so storyline item can be dropped.
        [[NSNotificationCenter defaultCenter]postNotificationName:@"playerDidConverseWithCharacterNotification" object:self userInfo:nil];
    }    
    return YES;
}
-(BOOL)isCharWithReward
{
    return NO;
}
-(BOOL)isMerchant
{
    return NO;
}


-(BOOL)getHasSpokenWithChar
{
    return hasSpokenWithChar;
}
-(void)setHasSpokenWithChar:(BOOL)truth
{
    hasSpokenWithChar = truth;
}

-(NSString *)converseWith
{
   return nil;
}

@end
