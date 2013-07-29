//
//  ItemInventoryExpansion.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/21/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemInventoryExpansion : Item<ItemProtocol>

@property (assign, nonatomic)double amtToExtendVolumeCapacity;

@end
