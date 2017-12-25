//
//  ServerConfiguration.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSUInteger, ServerEnvironment) {
    ServerEnvironmentProduction,
    ServerEnvironmentStaging,
    ServerEnvironmentDevelopment,
};

@interface ServerConfiguration : NSObject

#pragma mark - Properties
@property (nonatomic, assign, readonly) ServerEnvironment environment;

#pragma mark - Methods
+ (ServerConfiguration *)sharedInstance;
+ (NSString *)configuration;
+ (NSURL *)APIEndpoint;
+ (BOOL)isLoggingEnabled;

@end
