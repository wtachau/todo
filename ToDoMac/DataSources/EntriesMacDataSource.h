//
//  EntriesMacDataSource.h
//  ToDoMac
//
//  Created by William Tachau on 12/31/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Cocoa;
#import "EntriesDataSource.h"

@interface EntriesMacDataSource : EntriesDataSource <NSTableViewDataSource>

@property (nonatomic, strong, readwrite) NSArray *rowModels;

@end
