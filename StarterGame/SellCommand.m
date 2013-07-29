//
//  SellCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/24/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "SellCommand.h"

@implementation SellCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"sellTo";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([[player currentRoom]isTradeRoom]) {
        if ([self hasThirdWord]) {
            [player sellTo:[self secondWord] anItem:[self thirdWord]];
        }
        else {
            if([self hasSecondWord]){
                [player outputMessage:@"\nWhat would you like to sell?"];
            }else{
                [player outputMessage:@"\nWho would you like to sell to?"];
            }
        }
    }
    else
    {
        [player outputMessage:@"You must abide by the rules here. The king does not condone trading."];
    }
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to sell an item fto a merchant in the trading center.\n\n%@ <character> <item>\n", [self name], [self name]];
}

@end
