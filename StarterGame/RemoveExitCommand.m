//
//  RemoveExit.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/28/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "RemoveExitCommand.h"

@implementation RemoveExitCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"removeexit";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player removeExit:secondWord];
	}
	else {
        [player outputMessage:@"\nWhich exit would you like to remove%@?"];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to remove a room from a room's exits.\n\n%@ <room>\n", [self name], [self name]];
}



@end
