//
//  Timer.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/18/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer  : NSObject {
    NSDate *start;
    NSDate *end;
}

-(void)startTimer;
-(void)stopTimer;
-(double)timeElapsedInSeconds;

@end
