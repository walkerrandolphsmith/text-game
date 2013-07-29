//
//  Timer.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/18/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "Timer.h"

@implementation Timer

-(id) init
{
    self = [super init];
    if(self != nil)
    {
        start = nil;
        end = nil;
    }
    return self;
}

-(void)startTimer {
    start = [NSDate date];
}

-(void)stopTimer{
    end = [NSDate date];
}

-(double)timeElapsedInSeconds{
    [self stopTimer];
    return [ end timeIntervalSinceDate:start];
}
@end
