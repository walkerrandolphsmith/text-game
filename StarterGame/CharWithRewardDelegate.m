//
//  CharWithRewardDelegate.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "CharWithRewardDelegate.h"

@implementation CharWithRewardDelegate

-(BOOL)isCharWithDirections
{
     return NO;
}
-(BOOL)isCharWithReward
{
    return YES;
}
-(BOOL)isMerchant
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
    return @"I have lost my precious family heirloom. I can't imaine life without it! I would have a handsome reward for anyone who would bring it to me...";
}

@end
