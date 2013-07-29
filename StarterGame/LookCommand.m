//
//  Party.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "LookCommand.h"

@implementation LookCommand

-(id)init
{
	self = [super init];
    
    if (nil != self) {
        name = @"look";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player outputMessage:@"I can only see inside the current room without the map!"];
	}
	else {
        [player outputMessage:[[player currentRoom]description]];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to display the current room you are in.\n\n%@ \n", [self name], [self name]];
}


@end
