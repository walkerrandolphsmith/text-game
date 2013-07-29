//
//  GetCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/24/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "GetCommand.h"

@implementation GetCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"get";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasThirdWord]) {
        [player getItem:[self secondWord] fromContainer:[self thirdWord]];
    }
	else {
        if([self hasSecondWord]){
            [player outputMessage:@"\nWhat item would you like to take form the chest?"];
        }else{
            [player outputMessage:@"\nWhat would you like to get and where would you like to get it form?"];
        }
	}
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to get an item form a container.\n\n%@ <item> <container>\n", [self name], [self name]];
}

@end
