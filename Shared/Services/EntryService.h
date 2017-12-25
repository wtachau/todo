//
//  EntryService.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
#import "NetworkingClient.h"
@class Type;
@class Entry;

@interface EntryService : NSObject

+ (void)fetchAllTypesWithSuccess:(void (^)(NSArray<Type *> *))success
                         failure:(HTTPErrorResponse)failure;

+ (void)submitNewEntry:(NSString *)text
                  type:(NSNumber *)type
           withSuccess:(void (^)(Entry *))success
               failure:(HTTPErrorResponse)failure;

@end
