//
//  NetworkingClient.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "NetworkingClient.h"
#import "AFNetworking.h"
#import "Logging.h"
#import "Mantle.h"
#import "PersistedUserID.h"

@interface NetworkingClient()

@property (nonatomic, copy, readwrite) AFHTTPSessionManager *manager;

@end

@implementation NetworkingClient

// Check for errors in response, if successful then serialize body response into expected type
+ (void)processResponse:(id)response
                  error:(NSError *)error
    expectedReponseType:(Class)expectedClass
          responseBlock:(HTTPClientResponse)responseBlock
{
    // todo: defer to delegate
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (error) {
        
        // Connection errors
        if ([error.userInfo[@"underlyingError"] isKindOfClass:[NSError class]]) {
            NSError *urlError = error.userInfo[@"underlyingError"];
            NSDictionary *errorUserInfo = urlError.userInfo;
//            [self showConnectionErrorWithDescription:errorUserInfo[NSLocalizedDescriptionKey]
//                                          completion:responseBlock];
            return;
        }
        
        // Authentication errors
        if (error.code == 401) {
            NSData *errorData = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
            if (errorDictionary[@"status"] && [errorDictionary[@"status"] isEqualToString:@"ko"]) {
//                UIViewController *currentRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//                if (currentRootViewController) {
//                    [currentRootViewController displayAlertWithTitle:@"Sorry!"
//                                                         andSubtitle:@"Your account has become logged out. Please log back in."
//                                                       andAcceptText:@"Okay"
//                                                          completion:^{
//                                                              if ([self.authenticationDelegate respondsToSelector:@selector(logOut)]) {
//                                                                  [self.authenticationDelegate logOut];
//                                                              }
//                                                          }];
//                }
                return;
            }
            // If we get a 401 but the error does NOT have {'status':'ko'}, it is a login error. Continue with the response.
            responseBlock(nil, [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                               options:0
                                                                 error:nil]);
        } else if (error.code == -1001) {
            [self showConnectionErrorWithDescription:@"The request timed out." completion:nil];
        } else {
            // A non 401 error. More logic to come later
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                       options:0
                                                                         error:nil];
            if (dictionary[@"message"]) {
                responseBlock(nil, dictionary[@"message"]);
            } else if (dictionary[@"errors"] && [dictionary[@"errors"] isKindOfClass:[NSDictionary class]]){
                // Again, the weird case where this is for the Registration callback,
                // which is out of the box Devise :-/
                NSDictionary *errorDict = dictionary[@"errors"];
                NSString *firstKey = [[errorDict allKeys] firstObject];
                NSArray *firstErrorArray = errorDict[firstKey];
                responseBlock(nil, [NSString stringWithFormat:@"Your %@ %@", firstKey, [firstErrorArray firstObject]]);
            }
        }
    } else {
        if (expectedClass == [NSString class]) {
            responseBlock(response[@"data"], nil);
        } else {
            // No error, proceed with response
            NSError *deserializationError = nil;
            if ([response[@"data"] isKindOfClass:[NSArray class]]) {
                responseBlock([MTLJSONAdapter modelsOfClass:expectedClass
                                              fromJSONArray:response[@"data"]
                                                      error:&deserializationError], deserializationError);
            } else if ([response[@"data"] isKindOfClass:[NSDictionary class]]) {
                responseBlock([MTLJSONAdapter modelOfClass:expectedClass
                                        fromJSONDictionary:response[@"data"]
                                                     error:&deserializationError], nil);
            }
            else {
                responseBlock(@{}, nil);
            }
        }
    }
}

#pragma mark - OriginateHTTPClient

+ (void)GET:(NSString *)URI expectedResponseType:(Class)expectedClass response:(HTTPClientResponse)responseBlock
{
    NSNumber *RID = @([URI hash] % 1001);
    NSString *prefixString = [NSString stringWithFormat:@"NET (RID: #%@)", RID];
    NSString *logString = [NSString stringWithFormat:@"GET: %@", URI];
    log_prefix(prefixString, logString);
//    log_prefix(@"HEADERS", [[self client].authorizedObject authorizationHeader].description);
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [self.client GETResource:URI response:^(id response, NSError *error) {
//        log_prefix(prefixString, [self responseString:response]);
//        [self checkError:error RID:RID];
//
//    }];
    
    [self.manager GET:[self urlWithBasePath:URI]
           parameters:nil
             progress:nil
              success:^(NSURLSessionTask *task, id response) {
        NSLog(@"JSON: %@", response);
        [self processResponse:response
                        error:nil
          expectedReponseType:expectedClass
                responseBlock:responseBlock];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

+ (void)PUT:(NSString *)URI
       data:(NSDictionary *)body
expectedResponseType:(Class)expectedClass
   response:(HTTPClientResponse)responseBlock
{
    NSNumber *RID = @([URI hash] % 1001);
    NSString *logString = [NSString stringWithFormat:@"POST: %@ - Data: %@.", URI, body];
    log_prefix([self prefixString:RID], logString);
    
    [self.manager PUT:[self urlWithBasePath:URI] parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self processResponse:responseObject
                        error:nil
          expectedReponseType:expectedClass
                responseBlock:responseBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)POST:(NSString *)URI
        data:(NSDictionary *)body
expectedResponseType:(Class)expectedClass
    response:(HTTPClientResponse)responseBlock
{
    NSNumber *RID = @([URI hash] % 1001);
    NSString *logString = [NSString stringWithFormat:@"POST: %@ - Data: %@.", URI, body];
    log_prefix([self prefixString:RID], logString);
    
    [self.manager POST:[self urlWithBasePath:URI]
            parameters:body
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
                   NSLog(@"JSON: %@", response);
                   [self processResponse:response
                                   error:nil
                     expectedReponseType:expectedClass
                           responseBlock:responseBlock];
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"Error: %@", error);
               }];
//    log_prefix(@"HEADERS", [[self client].authorizedObject authorizationHeader].description);
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [self.client POSTResource:URI payload:data response:^(id response, NSError *error) {
//        log_prefix([self prefixString:RID], [self responseString:response]);
//        [self checkError:error RID:RID];
//        [self processResponse:response error:error expectedReponseType:expectedClass responseBlock:responseBlock];
//    }];
}

+ (void)PATCH:(NSString *)URI
         data:(NSDictionary *)body
expectedResponseType:(Class)expectedClass
     response:(HTTPClientResponse)responseBlock
{
    NSNumber *RID = @([URI hash] % 1001);
    NSString *logString = [NSString stringWithFormat:@"PATCH: %@ - Data: %@.", URI, body];
    log_prefix([self prefixString:RID], logString);
    
    [self.manager PATCH:[self urlWithBasePath:URI]
             parameters:body
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        NSLog(@"JSON: %@", response);
        [self processResponse:response
                        error:nil
          expectedReponseType:expectedClass
                responseBlock:responseBlock];
    }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)DELETE:(NSString *)URI expectedResponseType:(Class)expectedClass response:(HTTPClientResponse)responseBlock
{
    NSNumber *RID = @([URI hash] % 1001);
    NSString *logString = [NSString stringWithFormat:@"DELETE: %@", URI];
    log_prefix([self prefixString:RID], logString);
//    log_prefix(@"HEADERS", [[self client].authorizedObject authorizationHeader].description);
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [self.client DELETEResource:URI response:^(id response, NSError *error) {
//        log_prefix([self prefixString:RID], [self responseString:response]);
//        [self checkError:error RID:RID];
//        [self processResponse:response error:error expectedReponseType:expectedClass responseBlock:responseBlock];
//    }];
}



#pragma mark - Miscellaneous

+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"ToDo/%@.%@ (iPhone)", appVersionString, appBuildString] forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:[[PersistedUserID getUUID] UUIDString] forHTTPHeaderField:@"X-User-Token"];
    return manager;
//    Authorization *authorization = [[Authorization alloc] initWithAuthenticationToken:[[PersistedUserID getUUID] UUIDString]];
//    OriginateHTTPClient *client = [[OriginateHTTPClient alloc] initWithBaseURL: [ServerConfiguration APIEndpoint]
//                                              authorizedObject: authorization];
//    client.userAgent = ;
//    return client;
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
}

+ (NSString *)urlWithBasePath:(NSString *)path {
    return [NSString stringWithFormat:@"%@%@", [ServerConfiguration APIEndpoint], path];
}

+ (void)showConnectionErrorWithDescription:(NSString *)description
                                completion:(HTTPClientResponse)responseBlock
{
//    UIViewController *currentRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    if (currentRootViewController) {
//        [currentRootViewController displayAlertWithTitle:@"Please check your connection!"
//                                             andSubtitle:description
//                                           andAcceptText:@"Okay"
//                                              completion:^{
//                                                  if (responseBlock) {
//                                                      responseBlock(nil, nil);
//                                                  }
//                                              }];
//    }
}

+ (void)checkError:(NSError *)error RID:(NSNumber *)RID
{
    if (error) {
        NSString *errorPrefixString = [NSString stringWithFormat:@"ERROR (RID: #%@)", RID];
        log_prefix(errorPrefixString, [error description])
    }
}

+ (NSString *)prefixString:(NSNumber *)RID
{
    return [NSString stringWithFormat:@"NET (RID: #%@)", RID];
}

+ (NSString *)responseString:(id)response
{
    return [NSString stringWithFormat:@"RESPONSE: %@", response];
}

@end
