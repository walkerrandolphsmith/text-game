//
//  PutCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/24/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PutCommand.h"

@implementation PutCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"put";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasThirdWord]) {
		[player put:[self secondWord] inContainer:[self thirdWord]];
	}
	else {
        if([self hasSecondWord]){
            [player outputMessage:@"\nWhat would you like to put in the container?"];
        }else{
            [player outputMessage:@"\nWhat container would you like to put stuff into?"];
        }
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to give a person an item.\n\n%@ <character> <item>\n", [self name], [self name]];
}

@end
