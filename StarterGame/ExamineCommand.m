//
//  ExamineCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "ExamineCommand.h"

@implementation ExamineCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"examine";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player examine:secondWord];
	}
	else {
        [player outputMessage:@"\nWhat would you like to examine?"];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to view the description of items that are in the current room or in your inventory.\n\n%@ <item>\n", [self name], [self name]];
}


@end
