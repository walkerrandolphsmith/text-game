//
//  Item.m
//  StarterGame
//
//  Created by Jacob Bernett on 3/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import "Item.h"

@implementation Item


@synthesize label;
@synthesize itemDescription;
@synthesize weight;
@synthesize volume;
@synthesize isStationary;
@synthesize sellValue;
@synthesize buyValue;

-(id)init
{
    return [self initWithLabel:@"Fools Gold" andDescription:@"Worthless material"];
}

//By default items are capable of being picked up
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription
{
    if(nil != self){
        [self setLabel:theLabel];
        [self setItemDescription:theDescription];
        [self setWeight:1.0];
        [self setVolume:1.0];
        [self setIsStationary:NO];
        [self setSellValue:10];
        [self setBuyValue:15];
    }
    return self;
}

-(double)getSellValue
{
    return sellValue;
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"%@.\n *** %@\n Weight:%f  ||  Volume:%f\n Sell Value:%f  ||  Buy Value:%f", label, itemDescription, weight, volume, sellValue, buyValue];
}

-(void)dealloc
{
	[label release];
	[itemDescription release];
	
	[super dealloc];
}


@end
