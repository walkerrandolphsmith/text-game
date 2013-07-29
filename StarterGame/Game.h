//
//  Game.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "Parser.h"
#import "Player.h"
#import "GameIO.h"



@interface Game : NSObject {
    BOOL playing;
}

@property (retain, nonatomic)Parser *parser;
@property (retain, nonatomic)Player *player;

-(id)initWithGameIO:(GameIO *)theIO;

-(void)start;
-(void)end;
-(BOOL)execute:(NSString *)commandString;
-(NSString *)welcome;
-(NSString *)goodbye;

@end
