//
//  AppDelegate.m
//  ToDo
//
//  Created by William Tachau on 11/26/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "AppDelegate.h"
#import "Logging.h"
#import "EntriesViewController.h"
#import "ServerConfiguration.h"
@import Intents;

@interface AppDelegate ()

@property (nonatomic, strong, readwrite) EntriesViewController *entriesViewController;

@end

NSString * const SHORTCUT_ITEM_ADD_ENTRY = @"Add Entry";

@implementation AppDelegate

#pragma mark - Properties

- (EntriesViewController *)entriesViewController
{
    if (!_entriesViewController) {
        _entriesViewController = [[EntriesViewController alloc] init];
    }
    return _entriesViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Logging setupLogger];
    
    self.window.rootViewController = self.entriesViewController;
    
    UIApplicationShortcutItem * addEntryItem = [[UIApplicationShortcutItem alloc] initWithType: SHORTCUT_ITEM_ADD_ENTRY
                                                                                localizedTitle: @"Add Entry"
                                                                             localizedSubtitle: nil
                                                                                          icon: [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd]
                                                                                      userInfo: nil];
    
    [UIApplication sharedApplication].shortcutItems = @[addEntryItem];
    CGFloat statusBarHeight = 20;
    self.window.clipsToBounds = YES;
    self.window.frame = CGRectMake(0,
                                   statusBarHeight,
                                   self.window.frame.size.width,
                                   self.window.frame.size.height - statusBarHeight);

    UIApplicationShortcutItem *shortcutItem = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if(shortcutItem){
        [self handleShortCutItem:shortcutItem];
    }
    
      return YES;
}

- (void)handleShortCutItem:(UIApplicationShortcutItem *)shortcutItem  {
    if([shortcutItem.type isEqualToString:SHORTCUT_ITEM_ADD_ENTRY]){
//        [self.entriesViewController showAddEntryController];
    }
}

- (void)application:(UIApplication *)application
performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    [self handleShortCutItem:shortcutItem];
}

@end
