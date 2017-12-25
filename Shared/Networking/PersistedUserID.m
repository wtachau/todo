//
//  PersistedUserID.m
//  ToDo
//
//  Created by William Tachau on 12/16/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "PersistedUserID.h"

NSString * const TODO_USER_ID = @"ToDoUserID";

@implementation PersistedUserID

+ (NSUUID *) getUUID
{
    NSUUID *uuid;
    NSString *uuidString = [[NSUbiquitousKeyValueStore defaultStore] stringForKey: TODO_USER_ID];
    if (!uuidString) {
        // This is our first launch for this iTunes account, so we generate random UUID and store it in iCloud:
        uuid = [NSUUID UUID];
        [[NSUbiquitousKeyValueStore defaultStore] setString: uuid.UUIDString forKey: TODO_USER_ID];
        [[NSUbiquitousKeyValueStore defaultStore] synchronize];
        
    } else {
        uuid = [[NSUUID alloc] initWithUUIDString: uuidString];
    }
    
    return uuid;
}

+ (NSString *) getUUIDString
{
    return [self getUUID].UUIDString;
}

+ (void) load
{
    // get changes that might have happened while this
    // instance of your app wasn't running
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
}

@end
