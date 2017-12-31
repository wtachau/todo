//
//  EntriesViewControllerDelegate.h
//  ToDo
//
//  Created by William Tachau on 12/29/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
@class Entry;

@protocol EntriesViewControllerDelegate <NSObject>

- (void)showCompleteEntryActionSheet:(Entry *)entry;
- (void)showAddEntryController:(UIButton *)sender;

@end



