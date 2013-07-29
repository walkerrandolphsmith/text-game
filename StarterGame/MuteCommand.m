//
//  MuteCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/20/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "MuteCommand.h"

@implementation MuteCommand


-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"mute";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player outputMessage:@"There is nothing to mute?"];
	}
	else {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionMuteBecameToggledNotification" object:nil userInfo:nil];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to mute the dictation of the game.\n\n%@\n", [self name], [self name]];
}



@end
