//
//  NetworkingClient.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;

@interface NetworkingClient : NSObject

typedef void (^HTTPClientResponse)(id response, NSString *error);
typedef void (^HTTPErrorResponse)(NSString *error);

+ (void)GET:(NSString *)URI
expectedResponseType:(Class)expectedClass
   response:(HTTPClientResponse)responseBlock;

+ (void)PUT:(NSString *)URI
       data:(NSDictionary *)body
expectedResponseType:(Class)expectedClass
   response:(HTTPClientResponse)responseBlock;

+ (void)POST:(NSString *)URI
        data:(NSDictionary *)body
expectedResponseType:(Class)expectedClass
    response:(HTTPClientResponse)responseBlock;

+ (void)PATCH:(NSString *)URI
         data:(NSDictionary *)body
expectedResponseType:(Class)expectedClass
     response:(HTTPClientResponse)responseBlock;

+ (void)DELETE:(NSString *)URI
expectedResponseType:(Class)expectedClass
      response:(HTTPClientResponse)responseBlock;

@end
