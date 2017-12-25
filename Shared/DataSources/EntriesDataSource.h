//
//  EntriesDataSource.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import UIKit;
#import "DataSourceDelegate.h"
@class Type;

@interface EntriesDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, readwrite, strong) NSArray<Type *> *entryTypes;

@property (nonatomic, readwrite, weak) NSObject<DataSourceDelegate> *dataSourceDelegate;

- (void)fetchData;

@end
