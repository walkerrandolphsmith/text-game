//
//  SayCommand.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/2/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface SayCommand : Command


-(id)init;
-(BOOL)execute:(Player *)player;

@end
