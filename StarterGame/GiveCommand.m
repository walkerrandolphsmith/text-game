//
//  GiveCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/22/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "GiveCommand.h"

@implementation GiveCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"give";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([[player currentRoom]isTradeRoom]) {
        [player outputMessage:@"Trade means buy and sell"];
    }
    else
    {
        if ([self hasThirdWord]) {
            [player give:[self secondWord] theItem:[self thirdWord]];
        }
        else {
            if([self hasSecondWord]){
                [player outputMessage:@"\nWhat would you like to give?"];
            }else{
                [player outputMessage:@"\nWho would you like to give to?"];
            }
        }
    }
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to give a person an item.\n\n%@ <character> <item>\n", [self name], [self name]];
}


@end
