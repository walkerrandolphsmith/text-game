//
//  CharWithRewardDelegate.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerDelegate.h"

@interface CharWithRewardDelegate : NSObject<PlayerDelegate>

-(BOOL)isCharWithDirections;
-(BOOL)isCharWithReward;
-(BOOL)isMerchant;
-(NSString*)converseWith;

-(BOOL)getHasSpokenWithChar;
-(void)setHasSpokenWithChar:(BOOL)truth;

@end
