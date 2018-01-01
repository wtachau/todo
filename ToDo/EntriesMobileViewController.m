//
//  EntriesMobileViewController.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesMobileViewController.h"

#import "Formatting.h"
#import "AddEntryViewController.h"
#import "Type.h"
#import "Entry.h"
#import "PKFunctional.h"
#import "AddEntryDelegate.h"
#import "EntryTableViewCell.h"
#import "EntryService.h"
#import "SVProgressHUD.h"
#import "EntriesTableView.h"
#import "EntriesViewControllerDelegate.h"

@interface EntriesMobileViewController () <AddEntryDelegate, EntriesViewControllerDelegate>

@property (nonatomic, strong, readwrite) EntriesTableView *entriesTableView;

@property (nonatomic, strong, readwrite) AddEntryViewController *addEntryViewController;

@end

@implementation EntriesMobileViewController

#pragma mark - Properties

- (UITableView *)entriesTableView
{
    if (!_entriesTableView) {
        _entriesTableView = [[EntriesTableView alloc] init];
        _entriesTableView.entriesViewControllerDelegate = self;
    }
    return _entriesTableView;
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
                                       ]];
}

- (void)setupConstraints
{
    [self.entriesTableView pinToVerticalEdges];
    [self.entriesTableView pinToHorizontalEdges];
    [self.entriesTableView fillWidth];
    [self.entriesTableView fillHeight];
}


#pragma mark - AddEntryDelegate

- (void)entryAdded
{
    [self.entriesTableView.entriesDataSource fetchData];
}

# pragma mark - Miscellaneous

- (void)showAddEntryController:(UIButton *)sender
{
    Type *type = [self.entriesTableView.entriesDataSource.entryTypes pk_find:^BOOL(Type *type) {
        return [type.typeId integerValue] == sender.tag;
    }];
    self.addEntryViewController.selectedType = type;
    [self presentViewController:self.addEntryViewController animated:YES completion:nil];
}

- (void)showCompleteEntryActionSheet:(Entry *)entry
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Complete"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action)
                         {
                             [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Completing \"%@\"", entry.text]];
                             [EntryService completeEntry:entry withSuccess:^(Entry *entry) {
                                 [SVProgressHUD dismiss];
                                 [self.entriesTableView.entriesDataSource fetchData];
                             } failure:^(NSString *error) {
                                 
                             }];
                         }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
