//
//  CharWithDirectionsDelegate.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerDelegate.h"

@interface CharWithDirectionsDelegate : NSObject<PlayerDelegate>{
    BOOL hasSpokenWithChar;
}


-(BOOL)isCharWithDirections;
-(BOOL)isCharWithReward;
-(BOOL)isMerchant;
-(NSString*)converseWith;

-(BOOL)getHasSpokenWithChar;
-(void)setHasSpokenWithChar:(BOOL)truth;

@end
