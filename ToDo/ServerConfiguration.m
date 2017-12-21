//
//  ServerConfiguration.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "ServerConfiguration.h"
//#import "OttoConstants.h"

#define ConfigurationAPIEndpoint @"APIEndpoint"
#define ConfigurationLoggingEnabled @"LoggingEnabled"
#define ConfigurationSegmentKey @"SegmentKey"

@interface ServerConfiguration()

@property (nonatomic, assign, readwrite) ServerEnvironment environment;
@property (nonatomic, copy, readwrite) NSString *configuration;
@property (nonatomic, strong, readwrite) NSDictionary *configurationVariables;

@end

@implementation ServerConfiguration

+ (ServerConfiguration *)sharedInstance
{
    static ServerConfiguration *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // http://code.tutsplus.com/tutorials/ios-quick-tip-managing-configurations-with-ease--mobile-18324
        NSBundle *mainBundle = [NSBundle mainBundle];
        self.configuration = [[mainBundle infoDictionary] objectForKey:@"Configuration"];
        
        NSString *path = [mainBundle pathForResource:@"Configuration" ofType:@"plist"];
        NSDictionary *configurations = [NSDictionary dictionaryWithContentsOfFile:path];
        self.configurationVariables = [configurations objectForKey:self.configuration];
    }
    
    return self;
}

+ (NSString *)configuration
{
    return [[ServerConfiguration sharedInstance] configuration];
}

+ (NSURL *)APIEndpoint
{
    ServerConfiguration *sharedConfiguration = [ServerConfiguration sharedInstance];
    
    if (sharedConfiguration.configurationVariables) {
        NSString *urlString = [sharedConfiguration.configurationVariables objectForKey:ConfigurationAPIEndpoint];
        return [NSURL URLWithString:urlString];
    }
    
    return nil;
}

+ (BOOL)isLoggingEnabled
{
    ServerConfiguration *sharedConfiguration = [ServerConfiguration sharedInstance];
    
    if (sharedConfiguration.configurationVariables) {
        return [[sharedConfiguration.configurationVariables objectForKey:ConfigurationLoggingEnabled] boolValue];
    }
    
    return NO;
}
@end

