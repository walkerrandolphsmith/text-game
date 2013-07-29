//
//  ItemProtocol.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/16/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemProtocol <NSObject>

@property (readonly, nonatomic) NSString *label;
@property (readonly, nonatomic) NSString *itemDescription;
@property (readonly, nonatomic) double weight;
@property (readonly, nonatomic) double volume;
@property (assign, nonatomic)double sellValue;
@property (assign, nonatomic)double buyValue;

-(id)init;
-(id)initWithLabel:(NSString*)theLabel andDescription:(NSString *)theDescription;

-(NSString *)label;
-(NSString *)itemDescription;
-(double)weight;
-(double)volume;
-(BOOL)isStationary;
-(double)getSellValue;

@end
