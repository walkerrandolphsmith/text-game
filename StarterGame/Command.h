//
//  Command.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import <Cocoa/Cocoa.h>
#import "Player.h"


@interface Command : NSObject {
    NSString *name;
    NSString *secondWord;
    NSString *thirdWord;
}

@property (readonly, nonatomic)NSString *name;
@property (retain, nonatomic)NSString *secondWord;
@property (retain, nonatomic)NSString *thirdWord;

-(id)init;
-(BOOL)hasSecondWord;
-(BOOL)hasThirdWord;
-(BOOL)execute:(Player *)player;
-(NSString *)description;

@end
