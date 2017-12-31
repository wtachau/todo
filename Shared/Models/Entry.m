//
//  Entry.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "Entry.h"
#import "ModelDateHelper.h"

@implementation Entry

#pragma mark - <MTLJSONSerializing>

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             NSStringFromSelector(@selector(entryId)): @"id",
             NSStringFromSelector(@selector(text)): @"text",
             NSStringFromSelector(@selector(type)): @"type",
             NSStringFromSelector(@selector(order)): @"order",
             NSStringFromSelector(@selector(userId)): @"user_id",
             NSStringFromSelector(@selector(entryGeneratorId)): @"entry_generator_id",
             NSStringFromSelector(@selector(showBeforeActive)): @"show_before_active",
             NSStringFromSelector(@selector(activeAfter)): @"active_after",
             NSStringFromSelector(@selector(createdAt)): @"created_at",
             NSStringFromSelector(@selector(updatedAt)): @"updated_at",
             NSStringFromSelector(@selector(completedOn)): @"completed_on",
             NSStringFromSelector(@selector(deletedOn)): @"deleted_on"
             };
}

#pragma mark - MTLModel

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [ModelDateHelper dateTimeTransformer];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [ModelDateHelper dateTimeTransformer];
}

+ (NSValueTransformer *)activeAfterJSONTransformer {
    return [ModelDateHelper dateTimeTransformer];
}

+ (NSValueTransformer *)completedOnJSONTransformer {
    return [ModelDateHelper dateTimeTransformer];
}

+ (NSValueTransformer *)deletedOnJSONTransformer {
    return [ModelDateHelper dateTimeTransformer];
}

@end
