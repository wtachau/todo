//
//  AppDelegate.m
//  ToDoMac
//
//  Created by William Tachau on 12/21/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "AppDelegate.h"
#import "EntryService.h"
#import "EntriesMacViewController.h"

@interface AppDelegate ()
@property (assign) NSWindow *window;
@property (strong, nonatomic, readwrite) EntriesMacViewController *entriesViewController;
@end

@implementation AppDelegate

- (EntriesMacViewController *)entriesViewController
{
    if (!_entriesViewController) {
        _entriesViewController = [[EntriesMacViewController alloc] init];
    }
    return _entriesViewController;
}

//- (NSWindow *)window {
//    if (!_window) {
//        _window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 200, 200)
//                                              styleMask:NSWindowStyleMaskTitled
//                                                backing:NSBackingStoreBuffered
//                                                  defer:NO];
//        [_window cascadeTopLeftFromPoint:NSMakePoint(20,20)];
//        [_window setTitle:@"TODO"];
//        [_window makeKeyAndOrderFront:nil];
//    }
//    return _window;
//}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.window.contentView addSubview:self.entriesViewController.view];
    self.entriesViewController.view.frame = ((NSView*)self.window.contentView).bounds;
    [self.window makeKeyAndOrderFront:nil];
    [self.window setIsVisible:YES];
    
    
    // Insert code here to initialize your application
    [EntryService fetchAllTypesWithSuccess:^(NSArray<Type *> *types) {
        NSLog(@"%@", types);
    } failure:^(NSString *error) {
        NSLog(@"ERROR: > %@", error);
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
