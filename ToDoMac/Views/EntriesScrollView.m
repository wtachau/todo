//
//  EntriesScrollView.m
//  ToDoMac
//
//  Created by William Tachau on 12/31/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesScrollView.h"
#import "EntriesMacDataSource.h"
#import "ModelHelpers.h"

@interface EntriesScrollView () <NSTableViewDelegate, DataSourceDelegate>

@property (nonatomic, strong, readwrite) NSTableView *tableView;
@property (nonatomic, strong, readwrite) EntriesMacDataSource *entriesDataSource;

@end

@implementation EntriesScrollView

#pragma mark - Properties

- (NSTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[NSTableView alloc] initWithFrame:[self bounds]];
        _tableView.delegate = self;
        _tableView.dataSource = self.entriesDataSource;
        
        [_tableView setDraggingSourceOperationMask:NSDragOperationLink forLocal:NO];
        [_tableView setDraggingSourceOperationMask:NSDragOperationMove forLocal:YES];
        [_tableView registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];
        
        NSTableColumn *columnOne = [[NSTableColumn alloc] initWithIdentifier:@"columnOne"];
        [columnOne setWidth:200];
        [_tableView addTableColumn:columnOne];
    }
    return _tableView;
}

- (EntriesMacDataSource *)entriesDataSource
{
    if (!_entriesDataSource) {
        _entriesDataSource = [[EntriesMacDataSource alloc] init];
        _entriesDataSource.dataSourceDelegate = self;
    }
    return _entriesDataSource;
}

#pragma mark - Lifecycle

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setDocumentView:self.tableView];
        [self setHasVerticalScroller:YES];
    }
    return self;
}

- (void)dataDidLoad
{
    [self.tableView reloadData];
}

//- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
//{
//    static NSString* const kRowIdentifier = @"RowView";
//    NSTableRowView* rowView = [tableView makeViewWithIdentifier:kRowIdentifier owner:self];
//    if (!rowView) {
//        // Size doesn't matter, the table will set it
//        rowView = [[NSTableRowView alloc] initWithFrame:NSZeroRect];
//
//        // This seemingly magical line enables your view to be found
//        // next time "makeViewWithIdentifier" is called.
//        rowView.identifier = kRowIdentifier;
//    }
//
//    // Can customize properties here. Note that customizing
//    // 'backgroundColor' isn't going to work at this point since the table
//    // will reset it later. Use 'didAddRow' to customize if desired.
//    rowView.backgroundColor = [NSColor greenColor];
//
//    return rowView;
//}


//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//
//
//    // Get an existing cell with the MyView identifier if it exists
//    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
//
//    // There is no existing cell to reuse so create a new one
//    if (!result) {
//        // Create the new NSTextField with a frame of the {0,0} with the width of the table.
//        // Note that the height of the frame is not really relevant, because the row height will modify the height.
//        result = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
//
//        // The identifier of the NSTextField instance is set to MyView.
//        // This allows the cell to be reused.
//        result.identifier = @"MyView";
//    }
//
//    NSArray *flattenedEntries = [ModelHelpers flattenedEntryTypes:self.entriesDataSource.entryTypes];
//    id model = flattenedEntries[row];
//
//    if ([model isKindOfClass:Entry.class]) {
//        result.stringValue = ((Entry*)model).text;
//    } else if ([model isKindOfClass:Type.class]) {
//        result.stringValue = ((Type*)model).text;
//    }
//    return result;
//}

@end
