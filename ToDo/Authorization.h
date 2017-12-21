//
//  Authorization.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
#import "OriginateHttp.h"

@interface Authorization : NSObject <OriginateHTTPAuthorizedObject>

@property (nonatomic, copy, readwrite) NSString *authenticationToken;

- (instancetype)initWithAuthenticationToken:(NSString *)authenticationToken;
- (void)setAuthenticationToken:(NSString *)authenticationToken;

@end
