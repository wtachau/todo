//
//  EntriesMacDataSource.m
//  ToDoMac
//
//  Created by William Tachau on 12/31/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesMacDataSource.h"
#import "EntryService.h"
#import "PKFunctional.h"
#import "Type.h"
#import "Entry.h"
#import "ModelHelpers.h"

@implementation EntriesMacDataSource

#pragma mark - Miscellaneous methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    // Return total number of entries and types
    return [ModelHelpers flattenedEntryTypes:self.entryTypes].count;
}

- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    NSArray *flattenedEntries = [ModelHelpers flattenedEntryTypes:self.entryTypes];
    id model = flattenedEntries[row];
    
    if ([model isKindOfClass:Entry.class]) {
        return ((Entry*)model).text;
    } else if ([model isKindOfClass:Type.class]) {
        return ((Type*)model).text;
    }
    return nil;

}

#pragma mark Drag & Drop Delegates
- (BOOL)tableView:(NSTableView *)aTableView
writeRowsWithIndexes:(NSIndexSet *)rowIndexes
     toPasteboard:(NSPasteboard*)pboard
{
    return YES;
}

- (NSDragOperation)tableView:(NSTableView*)tv
                validateDrop:(id )info
                 proposedRow:(NSInteger)row
       proposedDropOperation:(NSTableViewDropOperation)op
{
    return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView*)tv
       acceptDrop:(id )info
              row:(NSInteger)row
    dropOperation:(NSTableViewDropOperation)op
{
    NSData *data = [[info draggingPasteboard] dataForType:NSStringPboardType];
    NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //REORDERING IN THE SAME TABLE VIEW BY DRAG & DROP
    //    if (([info draggingSource] == self.tableView) & (tv == self.tableView))
    //    {
    //        NSArray *tArr = [self.targetDataArray objectsAtIndexes:rowIndexes];
    //        [self.targetDataArray removeObjectsAtIndexes:rowIndexes];
    //        if (row > self.targetDataArray.count)
    //        {
    //            [self.targetDataArray insertObject:[tArr objectAtIndex:0] atIndex:row-1];
    //        }
    //        else
    //        {
    //            [self.targetDataArray insertObject:[tArr objectAtIndex:0] atIndex:row];
    //        }
    //        [self.targetTableView reloadData];
    //        [self.targetTableView deselectAll:nil];
    //    }
    
    return YES;
}


@end
