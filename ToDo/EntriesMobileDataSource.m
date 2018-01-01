//
//  EntriesMobileDataSource.m
//  ToDo
//
//  Created by William Tachau on 1/1/18.
//  Copyright © 2018 Tachau. All rights reserved.
//

#import "EntriesMobileDataSource.h"
#import "EntryTableViewCell.h"

@implementation EntriesMobileDataSource

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.entryTypes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryTypes[section].entries.count;
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

@end
