//
//  Game.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "Game.h"
#import "GameWorld.h"

@implementation Game

@synthesize parser;
@synthesize player;

//init with IO from AppDelegate
-(id)initWithGameIO:(GameIO *)theIO
{
	self = [super init];
	if (nil != self) {
		[self setParser:[[[Parser alloc] init] autorelease]];
		[self setPlayer:[[[Player alloc] initWithRoom:[[GameWorld sharedInstance] entrance] andIO:theIO] autorelease]];
        [player setCurrentValue:30.0];
        playing = NO;
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(end) name:@"playerDidEndGameNotification" object:nil];
	}
	return self;
}

-(void)start
{
    playing = YES;
    [player outputMessage:[self welcome]];
}

-(void)end
{
    [player outputMessage:[self goodbye]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionBecameInactiveNotification" object:nil userInfo:nil];
    
    playing = NO;    
}

-(BOOL)execute:(NSString *)commandString
{
	BOOL finished = NO;
    if (playing) {
        [player outputMessage:[NSString stringWithFormat:@">%@",commandString]];
        Command *command = [parser parseCommand:commandString];
        if (command) {
            finished = [command execute:player];
        }
        else {
            [player outputMessage:@"\nI dont' understand..."];
        }
    }
    return finished;
}

-(NSString *)welcome
{
	NSString *message = @"\n\nGame's welcome message.\nType 'help' if you need help.";
	return [NSString stringWithFormat:@"%@\n%@", message, [player currentRoom]];
}

-(NSString *)goodbye
{
    return @"\nThank you for playing, Goodbye.\n";
}

-(void)dealloc
{
	[parser release];
	[player release];
	
	[super dealloc];
}

@end
