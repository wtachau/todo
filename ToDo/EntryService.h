//
//  EntryService.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
#import "NetworkingClient.h"
@class Entry;

@interface EntryService : NSObject

+ (void)fetchAllGamesWithSuccess:(void (^)(NSArray<Entry *> *))success
                        failure:(HTTPErrorResponse)failure;

@end
