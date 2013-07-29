//
//  PassCodeCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/4/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PassCodeCommand.h"

@implementation PassCodeCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"passcode";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasThirdWord]) {
		[player passCode:[self thirdWord] forExit:[self secondWord]];
	}
	else {
        if([self hasSecondWord]){
            [player outputMessage:@"\nYou forgot the passcode."];
        }else{
            [player outputMessage:@"\nGo where?PassCode for which exit"];
        }
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to remove the forceField from an exit.\n\n%@ <exit>\n", [self name], [self name]];
}


@end
