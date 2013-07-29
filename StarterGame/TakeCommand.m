//
//  TakeCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/22/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "TakeCommand.h"

@implementation TakeCommand


-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"take";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([[player currentRoom]isTradeRoom]) {
        [player outputMessage:@"You must abide by the rules here. Trade means buy and sell"];
    }
    else
    {
        if ([self hasThirdWord]) {
            [player take:[self secondWord] formCharacter:[self thirdWord]];
        }
        else {
            if([self hasSecondWord]){
                [player outputMessage:@"\nWho would you like to take form?"];
            }else{
                [player outputMessage:@"\nWhat would you like to take?"];
            }
        }
    }
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to take an item form a person.\n\n%@ <character> <item>\n", [self name], [self name]];
}



@end
