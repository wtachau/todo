//
//  EntryTableViewCell.m
//  ToDo
//
//  Created by William Tachau on 12/25/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntryTableViewCell.h"
#import "Formatting.h"

@interface EntryTableViewCell() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong, readwrite) UITextField *hiddenTextField;
@property (nonatomic, strong, readwrite) UIPickerView *entryOptionsPickerView;

@end

@implementation EntryTableViewCell

- (UITextField *)hiddenTextField
{
    if (!_hiddenTextField) {
        _hiddenTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _hiddenTextField.inputView = self.entryOptionsPickerView;
    }
    return _hiddenTextField;
}

- (UIPickerView *)entryOptionsPickerView
{
    if (!_entryOptionsPickerView) {
        _entryOptionsPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _entryOptionsPickerView.dataSource = self;
        _entryOptionsPickerView.delegate = self;
    }
    return _entryOptionsPickerView;
}

#pragma mark - Lifecycle
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addAutoLayoutSubview:self.hiddenTextField];
}

# pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (void)openPickerView
{
    [self.hiddenTextField becomeFirstResponder];
}

@end
