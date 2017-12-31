//
//  EntriesTableView.h
//  ToDo
//
//  Created by William Tachau on 12/29/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import UIKit;
#import "EntriesDataSource.h"
#import "EntriesViewControllerDelegate.h"

@interface EntriesTableView : UITableView

@property (nonatomic, strong, readwrite) EntriesDataSource *entriesDataSource;
@property (nonatomic, weak, readwrite) NSObject<EntriesViewControllerDelegate> *entriesViewControllerDelegate;

@end
