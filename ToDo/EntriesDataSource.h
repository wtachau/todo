//
//  EntriesDataSource.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import UIKit;
#import "TableViewDataSourceDelegate.h"
@class Entry;

@interface EntriesDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, readwrite, strong) NSArray<Entry *> *entries;

@property (nonatomic, readwrite, weak) NSObject<TableViewDataSourceDelegate> *dataSourceDelegate;

@end
