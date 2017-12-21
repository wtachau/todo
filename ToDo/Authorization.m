//
//  Authorization.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "Authorization.h"

@implementation Authorization

- (instancetype)initWithAuthenticationToken:(NSString *)authenticationToken
{
    self = [super init];
    
    if (self) {
        _authenticationToken = authenticationToken;
    }
    
    return self;
}

- (void)setAuthenticationToken:(NSString *)authenticationToken email:(NSString *)email
{
    _authenticationToken = authenticationToken;
}

#pragma mark - <OriginateHTTPAuthorizedObject>

- (NSDictionary *)authorizationHeader
{
    return @{
             @"X-User-Token" : self.authenticationToken ? self.authenticationToken : @"",
             };
}

@end
