//
//  PlaceExit.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/28/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PlaceExitCommand.h"

@implementation PlaceExitCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"placeexit";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player placeExit:secondWord];
	}
	else {
        [player outputMessage:@"\nPlace exit where%@?"];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to add a room to a room's exits.\n\n%@ <room>\n", [self name], [self name]];
}



@end
