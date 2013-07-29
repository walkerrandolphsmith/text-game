//
//  ItemInventoryExpansion.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "ItemInventoryExpansion.h"

@implementation ItemInventoryExpansion


//By default items are capable of being picked up
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription
{
    if(nil != self){
        [self setLabel:theLabel];
        [self setItemDescription:theDescription];
        [self setWeight:1.0];
        [self setVolume:2.0];
        [self setIsStationary:NO];
        [self setAmtToExtendVolumeCapacity:2*[self volume]];
        [self setSellValue:100];
        [self setBuyValue:15];
        
    }
    return self;
}

-(double)getSellValue
{
    return sellValue;
}

@end
