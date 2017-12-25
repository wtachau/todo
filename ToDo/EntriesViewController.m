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
#import "AddEntryViewController.h"
#import "Type.h"
#import "PKFunctional.h"
#import "AddEntryDelegate.h"

@interface EntriesViewController () <DataSourceDelegate, UITableViewDelegate, AddEntryDelegate>

@property (nonatomic, strong, readwrite) UITableView *entriesTableView;
@property (nonatomic, strong, readwrite) EntriesDataSource *dataSource;
@property (nonatomic, strong, readwrite) UIButton *addEntryButton;

@property (nonatomic, strong, readwrite) AddEntryViewController *addEntryViewController;

@end

int const HEADER_HEIGHT = 80;

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

- (UIButton *)addEntryButton {
    if (!_addEntryButton) {
        _addEntryButton = [[UIButton alloc] init];
        [_addEntryButton addTarget:self
                            action:@selector(showAddEntryController)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _addEntryButton;
}

- (AddEntryViewController *)addEntryViewController
{
    if (!_addEntryViewController) {
        _addEntryViewController = [[AddEntryViewController alloc] init];
        _addEntryViewController.addEntryDelegate = self;
    }
    return _addEntryViewController;
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
    [self.view addAutoLayoutSubviews:@[
                                       self.entriesTableView,
                                       self.addEntryButton
                                       ]];
    
    self.addEntryButton.backgroundColor = [UIColor blueColor];
}

- (void)setupConstraints
{
    [self.entriesTableView centerHorizontally];
    [self.entriesTableView matchHeightWithView:self.view];
    [self.entriesTableView pinToBottom];
    [self.entriesTableView fillWidth];
    
    [self.addEntryButton centerHorizontally];
    [self.addEntryButton pinToBottomWithPadding:20];
    [self.addEntryButton fixSize:CGSizeMake(50, 50)];
}

#pragma mark - <TableViewDataSourceDelegate>

- (void)dataDidLoad
{
    [self.entriesTableView reloadData];
    NSLog(@"reloading");
}


#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    Type *type = self.dataSource.entryTypes[section];
    addButton.tag = [type.typeId intValue];
    [addButton addTarget:self action:@selector(showAddEntryController:) forControlEvents:UIControlEventTouchUpInside];
    
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

#pragma mark - AddEntryDelegate

- (void)entryAdded
{
    [self.dataSource fetchData];
}

# pragma mark - Miscellaneous

- (void)showAddEntryController:(UIButton *)sender
{
    Type *type = [self.dataSource.entryTypes pk_find:^BOOL(Type *type) {
        return [type.typeId integerValue] == sender.tag;
    }];
    self.addEntryViewController.selectedType = type;
    [self presentViewController:self.addEntryViewController animated:YES completion:nil];
}


@end
