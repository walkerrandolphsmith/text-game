//
//  RemoveExit.h
//  StarterGame
//
//  Created by Jacob Bernett on 3/28/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface RemoveExitCommand : Command


-(id)init;
-(BOOL)execute:(Player *)player;

@end
