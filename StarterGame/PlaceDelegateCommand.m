//
//  PlaceDelegateCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/9/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PlaceDelegateCommand.h"

@implementation PlaceDelegateCommand


-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"placedelegate";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player outputMessage:@"\nI cannot place the delegate there"];
	}
	else {
        [player placeDelegate];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used place a delegate into the current room.\n\n%@ <room>\n", [self name], [self name]];
}

@end
