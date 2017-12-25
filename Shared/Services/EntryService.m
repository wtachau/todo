//
//  EntryService.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "EntryService.h"
#import "Entry.h"
#import "Type.h"

@implementation EntryService

+ (void)fetchAllTypesWithSuccess:(void (^)(NSArray<Type *> *))success
                           failure:(HTTPErrorResponse)failure {
    [NetworkingClient GET:@"types"
     expectedResponseType:[Type class]
                 response:^(id response, NSString *error) {
                     response ? success(response) : failure(error);
                 }];
}

+ (void)submitNewEntry:(NSString *)text
                  type:(NSNumber *)type
           withSuccess:(void (^)(Entry *))success
               failure:(HTTPErrorResponse)failure {
    [NetworkingClient POST:@"entries"
                      data:@{
                             @"text": text,
                             @"type": type
                             }
      expectedResponseType:Entry.class
                  response:^(id response, NSString *error) {
                      response ? success(response) : failure(error);
                  }];
}

@end
