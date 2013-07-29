//
//  PortalCommand.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/11/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "PortalCommand.h"

@implementation PortalCommand


-(id)init
{
	self = [super init];
    
    if (nil != self) {
        name = @"portal";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player
{
	if ([self hasSecondWord]) {
        [player outputMessage:[NSString stringWithFormat:@"\nI cannot portal %@", secondWord]];
	}
    else{
        [player portal];
    }
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nThe %@ command is used to save a referrence to the room or return to the room.\n\n%@\n", [self name], [self name]];
}

@end
