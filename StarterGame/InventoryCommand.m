//
//  InventoryCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "InventoryCommand.h"

@implementation InventoryCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"inventory";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player outputMessage:@"Did you want to check out your stash?\n"];
	}
	else {
        [player outputMessage: [player printInventory]];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to display your stored treasures.\n\n%@\n", [self name], [self name]];
}

@end
