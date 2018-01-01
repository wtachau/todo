//
//  EntriesMacViewController.m
//  ToDoMac
//
//  Created by William Tachau on 12/31/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntriesMacViewController.h"
#import "EntriesScrollView.h"

@interface EntriesMacViewController ()

@property (strong, nonatomic, readwrite) EntriesScrollView *entriesScrollView;

@end

@implementation EntriesMacViewController

- (EntriesScrollView *)entriesScrollView
{
    if (!_entriesScrollView)
    {
        _entriesScrollView = [[EntriesScrollView alloc] init];
    }
    return _entriesScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.entriesScrollView];

}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self.entriesScrollView setFrame:self.view.frame];
}
@end
