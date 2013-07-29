//
//  GiveCommand.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/22/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface GiveCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end
