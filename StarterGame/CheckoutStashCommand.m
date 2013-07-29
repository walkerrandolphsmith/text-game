//
//  CheckoutStashCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/22/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "CheckoutStashCommand.h"

@implementation CheckoutStashCommand


-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"checkout";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
		Player *character = [[player currentRoom]getCharacter:secondWord];
        if(nil != character)
        {
           [player outputMessage:[character printInventory]];
        }
        else
        {
            [player outputMessage:@"There is no character for that name"];
        }
	}
    else{
        [player outputMessage:@"Whose inventory would you like to checkout?"];
    }
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to view the contents of a characters inventory.\n\n%@ <character>\n", [self name], [self name]];
}

@end
