//
//  SayCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/2/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "SayCommand.h"

@implementation SayCommand

-(id)init
{
	self = [super init];
    
    if (nil != self) {
        name = @"say";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		[player say:secondWord];
	}
	else {
        [player outputMessage:[[player currentRoom]description]];
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to in echo rooms to help find the exit.\n\n%@ \n", [self name], [self name]];
}

@end
