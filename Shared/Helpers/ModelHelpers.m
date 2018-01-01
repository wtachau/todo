//
//  ModelHelpers.m
//  ToDo
//
//  Created by William Tachau on 1/1/18.
//  Copyright © 2018 Tachau. All rights reserved.
//

#import "ModelHelpers.h"
#import "PKFunctional.h"
#import "Type.h"
#import "Entry.h"

@implementation ModelHelpers

+ (NSArray *)flattenedEntryTypes:(NSArray *)entryTypes
{
    return [[entryTypes pk_map:^id(Type *type) {
        NSMutableArray *typeAndEntries = [@[type] mutableCopy];
        [typeAndEntries addObjectsFromArray:type.entries];
        return typeAndEntries;
    }] pk_flatten];
}

@end
