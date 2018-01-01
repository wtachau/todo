//
//  EntriesDataSource.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesDataSource.h"
#import "PKFunctional.h"

@implementation EntriesDataSource

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self fetchData];
    }
    return self;
}



#pragma mark - Miscellaneous methods

- (void)fetchData
{
    [EntryService fetchAllTypesWithSuccess:^(NSArray<Type *> *entryTypes) {
        self.entryTypes = [entryTypes pk_map:^Type *(Type *type) {
            // Omit entries that have been completed, and sort by order
            type.entries = [[type.entries pk_filter:^BOOL(Entry *entry) {
                return !entry.completedOn;
            }] sortedArrayUsingComparator:^NSComparisonResult(Entry *e1, Entry *e2) {
                return [e1.order compare:e2.order];
            }];
            return type;
        }];
        if (self.dataSourceDelegate && [self.dataSourceDelegate respondsToSelector:@selector(dataDidLoad)]) {
            [self.dataSourceDelegate dataDidLoad];
        }
    } failure:^(NSString *error) {
        NSLog(@"ERROR: > %@", error);
    }];
}


@end
