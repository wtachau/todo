//
//  AppDelegate.m
//  ToDoMac
//
//  Created by William Tachau on 12/21/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "AppDelegate.h"
#import "EntryService.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [EntryService fetchAllGamesWithSuccess:^(NSArray<Entry *> *entries) {
        NSLog(@"TEXT");
    } failure:^(NSString *error) {
        NSLog(@"ERROR: > %@", error);
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
