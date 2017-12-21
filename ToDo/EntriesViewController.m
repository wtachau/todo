//
//  EntriesViewController.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesViewController.h"
#import "EntriesDataSource.h"
#import "Formatting.h"

@interface EntriesViewController () <TableViewDataSourceDelegate, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *entriesTableView;
@property (nonatomic, strong, readwrite) EntriesDataSource *dataSource;

@end

@implementation EntriesViewController

#pragma mark - Properties

- (UITableView *)entriesTableView
{
    if (!_entriesTableView) {
        _entriesTableView = [[UITableView alloc] init];
        _entriesTableView.delegate = self;
        _entriesTableView.dataSource = self.dataSource;
        [_entriesTableView registerClass:[UITableViewCell class]
                forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _entriesTableView;
}

- (EntriesDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[EntriesDataSource alloc] init];
        _dataSource.dataSourceDelegate = self;
    }
    return _dataSource;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews
{
    [self.view addAutoLayoutSubviews:@[self.entriesTableView]];
}

- (void)setupConstraints
{
    [self.entriesTableView centerHorizontally];
    [self.entriesTableView matchHeightWithView:self.view];
    [self.entriesTableView pinToBottom];
    [self.entriesTableView fillWidth];
}

#pragma mark - <TableViewDataSourceDelegate>

- (void)dataDidLoad
{
    [self.entriesTableView reloadData];
}


#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
