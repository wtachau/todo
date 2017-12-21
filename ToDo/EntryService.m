//
//  EntryService.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntryService.h"
#import "Entry.h"

@implementation EntryService

+ (void)fetchAllGamesWithSuccess:(void (^)(NSArray<Entry *> *))success
                         failure:(HTTPErrorResponse)failure {
    [NetworkingClient GET:@"entries"
     expectedResponseType:[Entry class]
                 response:^(id response, NSString *error) {
                     response ? success(response) : failure(error);
                 }];
}

@end
