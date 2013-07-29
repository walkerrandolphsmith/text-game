//
//  ConverseWithCommand.h
//  StarterGame
//
//  Created by Jacob Bernett on 3/26/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface ConverseWithCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end
