//
//  Command.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Command.h"


@implementation Command

@synthesize name;
@synthesize secondWord;
@synthesize thirdWord;

-(id)init
{
	self = [super init];
	if (nil != self) {
        name = @"";
		secondWord = nil;
	}
	return self;
}

-(void)playerDidEndGame
{
}

-(BOOL)hasSecondWord
{
	return (secondWord != nil);
}

-(BOOL)hasThirdWord
{
    return (thirdWord != nil);
}



-(BOOL)execute:(Player *)player
{
	return NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"There is no help for this command"];
}


-(void)dealloc
{
	[secondWord release];
    [thirdWord release];
	
	[super dealloc];
}

@end
