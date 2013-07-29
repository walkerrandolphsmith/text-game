//
//  PickupCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PickupCommand.h"

@implementation PickupCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"pickup";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player pickup:secondWord];
	}
	else {
        [player outputMessage:@"There is nothing to pick up Sir.\n"];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to add items to your inventory.\n\n%@ <item>\n", [self name], [self name]];
}

@end
