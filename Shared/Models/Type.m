//
//  Type.m
//  ToDo
//
//  Created by William Tachau on 12/24/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "Type.h"
#import "ModelDateHelper.h"
#import "Entry.h"

@implementation Type

#pragma mark - <MTLJSONSerializing>

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             NSStringFromSelector(@selector(typeId)): @"id",
             NSStringFromSelector(@selector(text)): @"text",
             NSStringFromSelector(@selector(order)): @"order",
             NSStringFromSelector(@selector(createdAt)): @"created_at",
             NSStringFromSelector(@selector(updatedAt)): @"updated_at",
             NSStringFromSelector(@selector(entries)): @"entries",
             };
}

#pragma mark - MTLModel

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [ModelDateHelper dateTransformer];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [ModelDateHelper dateTransformer];
}

+ (NSValueTransformer *)entriesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Entry.class];
}

@end
