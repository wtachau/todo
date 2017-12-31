//
//  AddEntryViewController.m
//  ToDo
//
//  Created by William Tachau on 12/22/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "AddEntryViewController.h"
#import "Formatting.h"
#import "Type.h"
#import "Entry.h"
#import "EntryService.h"
#import "SVProgressHUD.h"

@interface AddEntryViewController ()

@property (nonatomic, strong, readwrite) UITextField *entryTextField;
@property (nonatomic, strong, readwrite) UIButton *exitButton;
@property (nonatomic, strong, readwrite) UILabel *typeLabel;
@property (nonatomic, strong, readwrite) UIButton *submitButton;

@end

@implementation AddEntryViewController

#pragma mark - Properties

- (UITextField *)entryTextField
{
    if (!_entryTextField) {
        _entryTextField = [[UITextField alloc] init];
        _entryTextField.backgroundColor = [UIColor whiteColor];
    }
    return _entryTextField;
}

- (UIButton *)exitButton
{
    if (!_exitButton) {
        _exitButton = [[UIButton alloc] init];
        _exitButton.backgroundColor = [UIColor redColor];
        [_exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
    }
    return _typeLabel;
}

- (UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:@"Add" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(addEntry) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.entryTextField becomeFirstResponder];
}

- (void)setupViews
{
    [self.view addAutoLayoutSubviews:@[
                                       self.entryTextField,
                                       self.exitButton,
                                       self.typeLabel,
                                       self.submitButton]
    ];
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)setupConstraints
{
    [self.entryTextField matchWidthWithView:self.view
                                 multiplier:0.8];
    [self.entryTextField fixHeight:50];
    [self.entryTextField centerHorizontally];
    [self.entryTextField pinToTopWithPadding:100];
    
    [self.exitButton pinToTopWithPadding:30];
    [self.exitButton pinToRightWithPadding:20];
    [self.exitButton fixWidth:30];
    [self.exitButton fixHeight:30];
    
    [self.typeLabel centerHorizontally];
    [self.typeLabel pinToTopWithPadding:30];
    
    [self.submitButton placeBelowView:_entryTextField padding:20];
    [self.submitButton centerHorizontally];
    [self.submitButton fixWidth:50];
    [self.submitButton fixHeight:20];
}

#pragma mark - <TableViewDataSourceDelegate>

- (void)dataDidLoad
{
    
}

# pragma mark - Other methods

- (void)exit
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSelectedType:(Type *)selectedType
{
    _selectedType = selectedType;
    [self.typeLabel setText:[NSString stringWithFormat:@"Add New %@", selectedType.text]];
}

- (void)addEntry
{
    NSString *entryText = self.entryTextField.text;
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Adding \"%@\"", entryText]];
    [EntryService submitNewEntry:entryText
                            type:self.selectedType.typeId
                     withSuccess:^(Entry * entry) {
                         [SVProgressHUD dismiss];
                         [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                         [self.addEntryDelegate entryAdded];
                         self.entryTextField.text = @"";
                     } failure:^(NSString *error) {
                         
                     }];
}


@end
