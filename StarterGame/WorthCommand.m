//
//  WorthCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/24/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "WorthCommand.h"

@implementation WorthCommand

-(id)init
{
	self = [super init];
    if (nil != self) {
        name = @"worth";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player outputMessage:[NSString stringWithFormat:@"%f",[player currentValue]]];
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command, by itself is used to display your current supply of money.\n\n%@\nAlternatively it can be followed with inventory to apraise the trading value of your inventory", [self name], [self name]];
}

@end
