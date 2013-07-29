//
//  ConverseWithCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/26/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "ConverseWithCommand.h"

@implementation ConverseWithCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"converseWith";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player converseWith:secondWord];
	}
	else {
        [player outputMessage:@"\nWho would you like to converse with?"];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to talk to NPCs to get clues as to which rooms contain guards.\n\n%@ <item>\n", [self name], [self name]];
}




@end
