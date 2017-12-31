//
//  EntriesTableView.m
//  ToDo
//
//  Created by William Tachau on 12/29/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesTableView.h"
#import "EntryTableViewCell.h"
#import "EntriesViewController.h"
#import "SVProgressHUD.h"
#import "Entry.h"
#import "Type.h"
#import "EntryService.h"

@interface EntriesTableView () <UITableViewDelegate, DataSourceDelegate>

@property (nonatomic, strong, readwrite) UIRefreshControl *refreshEntriesControl;

@end

int const HEADER_HEIGHT = 80;

@implementation EntriesTableView

- (EntriesDataSource *)entriesDataSource {
    if (!_entriesDataSource) {
        _entriesDataSource = [[EntriesDataSource alloc] init];
        _entriesDataSource.dataSourceDelegate = self;
    }
    return _entriesDataSource;
}

- (UIRefreshControl *)refreshControl
{
    if (!_refreshEntriesControl) {
        _refreshEntriesControl = [[UIRefreshControl alloc] init];
        [_refreshEntriesControl addTarget:self
                                   action:@selector(refreshData)
                         forControlEvents:UIControlEventValueChanged];
    }
    return _refreshEntriesControl;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = self.entriesDataSource;
        self.delegate = self;
        [self setEditing:YES animated:YES];
        self.refreshControl = self.refreshControl;
        [self registerClass:[EntryTableViewCell class]
                  forCellReuseIdentifier:NSStringFromClass([EntryTableViewCell class])];
    }
    return self;
}

#pragma mark - UIRefreshControl

- (void)refreshData
{
    [self.entriesDataSource fetchData];
}

#pragma mark - <DataSourceDelegate>

- (void)dataDidLoad
{
    [self reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = tableView.frame;
    
    CGFloat addButtonWidth = 50;
    CGFloat headerPadding = 10;
    CGRect addButtonRect = CGRectMake(frame.size.width - addButtonWidth - headerPadding,
                                      headerPadding,
                                      addButtonWidth,
                                      HEADER_HEIGHT - 2 * headerPadding
                                      );
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:addButtonRect];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor redColor];
    
    Type *type = self.entriesDataSource.entryTypes[section];
    addButton.tag = [type.typeId intValue];
    [addButton addTarget:self.entriesViewControllerDelegate
                  action:@selector(showAddEntryController:)
        forControlEvents:UIControlEventTouchUpInside];
    
    CGRect headerLabelRect= CGRectMake(
                                       headerPadding,
                                       headerPadding,
                                       frame.size.width - 3 * headerPadding - addButtonWidth,
                                       HEADER_HEIGHT - (2 * headerPadding)
                                       );
    UILabel *title = [[UILabel alloc] initWithFrame:headerLabelRect];
    title.text = type.text;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [headerView addSubview:title];
    [headerView addSubview:addButton];
    headerView.backgroundColor = [UIColor yellowColor];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Entry *entry = self.entriesDataSource.entryTypes[indexPath.section].entries[indexPath.row];
    
    [self.entriesViewControllerDelegate showCompleteEntryActionSheet:entry];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
