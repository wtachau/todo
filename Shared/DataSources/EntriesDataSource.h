//
//  EntriesDataSource.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
#import "DataSourceDelegate.h"
#import "EntryService.h"
#import "Type.h"
#import "Entry.h"

@interface EntriesDataSource : NSObject 

@property (nonatomic, readwrite, strong) NSArray<Type *> *entryTypes;

@property (nonatomic, readwrite, weak) NSObject<DataSourceDelegate> *dataSourceDelegate;

- (void)fetchData;

@end
