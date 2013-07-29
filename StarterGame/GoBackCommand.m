//
//  GoBackCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "GoBackCommand.h"

@implementation GoBackCommand


-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"goback";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        [player outputMessage:@"\nThere is only one way back."];
	}
	else {
		[player goBack];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to go to the last room you exited.\n\n%@\n", [self name], [self name]];
}


@end
