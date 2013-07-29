//
//  DropCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "DropCommand.h"

@implementation DropCommand

-(id)init
{
	self = [super init];
    
    if (nil != self) {
        name = @"drop";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player drop: secondWord];
	}
	else {
        [player outputMessage:@"\n You have no items to drop."];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to remove an item from your inventory.\n\n%@ <item>\n", [self name], [self name]];
}


@end
