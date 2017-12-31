//
//  EntriesDataSource.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesDataSource.h"
#import "EntryService.h"
#import "Entry.h"
#import "Type.h"
#import "EntryTableViewCell.h"
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

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.entryTypes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryTypes[section].entries.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EntryTableViewCell class])
                                                                    forIndexPath:indexPath];
    
    Type *type = self.entryTypes[indexPath.section];
    Entry *entry = type.entries[indexPath.row];

    [cell.textLabel setText:entry.text];
    cell.showsReorderControl = YES;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.entryTypes[section].text;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath
{
    if (fromIndexPath.section == toIndexPath.section) {
        // Within the same section
        NSMutableArray *entries = [self.entryTypes[toIndexPath.section].entries mutableCopy];
        
        Entry *movedEntry = [entries objectAtIndex:fromIndexPath.row];
        [entries removeObjectAtIndex:fromIndexPath.row];
        [entries insertObject:movedEntry atIndex:toIndexPath.row];
        
        self.entryTypes[toIndexPath.section].entries = entries;
        
        [EntryService saveOrder:entries withSuccess:nil failure:nil];
    } else {
        // Entry is moved across Types
        NSMutableArray *fromEntries = [self.entryTypes[fromIndexPath.section].entries mutableCopy];
        NSMutableArray *toEntries = [self.entryTypes[toIndexPath.section].entries mutableCopy];
        
        Entry *movedEntry = [fromEntries objectAtIndex:fromIndexPath.row];
        movedEntry.type = self.entryTypes[toIndexPath.section].typeId;
        [fromEntries removeObjectAtIndex:fromIndexPath.row];
        [toEntries insertObject:movedEntry atIndex:toIndexPath.row];
        
        self.entryTypes[fromIndexPath.section].entries = fromEntries;
        self.entryTypes[toIndexPath.section].entries = toEntries;
        
        [EntryService saveOrder:fromEntries withSuccess:nil failure:nil];
        [EntryService saveOrder:toEntries withSuccess:nil failure:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
