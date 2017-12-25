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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])
                                                                    forIndexPath:indexPath];
    
    Type *type = self.entryTypes[indexPath.section];
    Entry *entry = type.entries[indexPath.row];

    [cell.textLabel setText:entry.text];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.entryTypes[section].text;
}


#pragma mark - Miscellaneous methods

- (void)fetchData
{
    [EntryService fetchAllTypesWithSuccess:^(NSArray<Type *> *entryTypes) {
        self.entryTypes = entryTypes;
        if (self.dataSourceDelegate && [self.dataSourceDelegate respondsToSelector:@selector(dataDidLoad)]) {
            [self.dataSourceDelegate dataDidLoad];
        }
    } failure:^(NSString *error) {
        NSLog(@"ERROR: > %@", error);
    }];
}


@end
