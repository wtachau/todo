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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])
                                                                    forIndexPath:indexPath];
    Entry *entry = self.entries[indexPath.row];
    [cell.textLabel setText:entry.text];
    return cell;
}

#pragma mark - Miscellaneous methods

- (void)fetchData
{
    [EntryService fetchAllGamesWithSuccess:^(NSArray<Entry *> *entries) {
        self.entries = entries;
        NSLog(@"TEXT");
        if (self.dataSourceDelegate && [self.dataSourceDelegate respondsToSelector:@selector(dataDidLoad)]) {
            [self.dataSourceDelegate dataDidLoad];
        }
    } failure:^(NSString *error) {
        NSLog(@"ERROR: > %@", error);
    }];
//    [GameService fetchAllEntriesWithSuccess:^(NSArray<Game *> *games) {
//
//        // Keep track of whether the cells at that index have already been loaded (in order that they only fade in once)
//        self.cellFirstLoadedRecords = [@[] mutableCopy];
//        for (int i = 0; i < games.count; i++) {
//            [self.cellFirstLoadedRecords addObject:[NSNumber numberWithBool:fade]];
//        }
//
//        // Filter out games that don't have a prize, have not started, or already ended
//        self.games = [games pk_filter:^BOOL(Game *game) {
//            NSDate *now = [NSDate date];
//            return game.prize != nil &&
//            [game.startTime compare:now] == NSOrderedAscending &&
//            [game.endTime compare:now] == NSOrderedDescending;
//        }];
//        // And sort them based on which have already been won
//        self.games = [self.games sortedArrayUsingComparator:^NSComparisonResult(Game *game1, Game *game2) {
//            if ((game1.userId && game2.userId) || (!game1.userId && !game2.userId)) {
//                return NSOrderedSame;
//            } else {
//                return (game1.userId != nil) ? NSOrderedDescending: NSOrderedAscending;
//            }
//        }];
//        if (self.dataSourceDelegate && [self.dataSourceDelegate respondsToSelector:@selector(dataDidLoad)]) {
//            [self.dataSourceDelegate dataDidLoad];
//        }
//    } failure:^(NSString *error) {
//        NSLog(@"ERROR: > %@", error);
//    }];
}


@end
