//
//  PlayerDelegate.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/25/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PlayerDelegate <NSObject>

-(BOOL)isCharWithDirections;
-(BOOL)isCharWithReward;
-(BOOL)isMerchant;

-(BOOL)getHasSpokenWithChar;
-(void)setHasSpokenWithChar:(BOOL)truth;

-(NSString*)converseWith;

@end
