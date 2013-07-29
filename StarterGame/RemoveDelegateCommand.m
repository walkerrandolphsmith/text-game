//
//  RemoveDelegateCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/9/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "RemoveDelegateCommand.h"

@implementation RemoveDelegateCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"removedelegate";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player outputMessage:@"\nI cannot remove that delegate"];
	}
	else {
        [player removeDelegate];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used remove a delegate from a room's exits.\n\n%@ <room>\n", [self name], [self name]];
}


@end
