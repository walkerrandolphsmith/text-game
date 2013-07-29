//
//  MerchantDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "MerchantDelegate.h"

@implementation MerchantDelegate

-(BOOL)isCharWithDirections
{
    return NO;
}
-(BOOL)isCharWithReward
{
    return NO;
}
-(BOOL)isMerchant
{
    return YES;
}

-(BOOL)hasSpokenWithChar
{
    return NO;
}

-(BOOL)getHasSpokenWithChar
{
    return NO;
}
-(void)setHasSpokenWithChar:(BOOL)truth
{
    ;
}

-(NSString *)converseWith
{
    return @"What would you like to buy today?";
}

@end
