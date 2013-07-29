//
//  PlaceDelegateCommand.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/9/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
@interface PlaceDelegateCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end
