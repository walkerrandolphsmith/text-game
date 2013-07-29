//
//  AlarmClock.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/16/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "AlarmClock.h"


@implementation AlarmClock

@synthesize room;

-(id)init
{
    return [self initWithRoom:nil];
}
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription
{
    return [self initWithRoom:nil];
}

-(id)initWithRoom:(Room *)aRoom
{
    self = [super initWithLabel:@"letter" andDescription:@"The word money is written on this document... "];
    
    if(nil != self)
    {
        [self setWeight:0.0];
        [self setVolume:10.0];
        [self setIsStationary:YES];
        [self setRoom:aRoom];
    }
    return self;
}

-(void)timesUp
{
    if(room){
        [room say:@"ring ring ring" fromRoom:room];
    }
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"\n%@", itemDescription];
}

@end
