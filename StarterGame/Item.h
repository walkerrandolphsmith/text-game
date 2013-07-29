//
//  Item.h
//  StarterGame
//
//  Created by Jacob Bernett on 3/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemProtocol.h"

@interface Item : NSObject<ItemProtocol>{
    NSString *label;
    NSString *itemDescription;
    double weight;
    double volume;
    BOOL isStationary;
    double sellValue;
    double buyValue;
}

@property (retain, nonatomic)NSString *label;
@property (retain, nonatomic)NSString *itemDescription;
@property (assign, nonatomic)double weight;
@property (assign, nonatomic)double volume;
@property (assign, nonatomic)BOOL isStationary;
@property (assign, nonatomic)double sellValue;
@property (assign, nonatomic)double buyValue;

-(id)init;
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription;

@end
