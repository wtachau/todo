//
//  Logging.h
//  Mantle
//
//  Created by William Tachau on 12/10/17.
//

@import Foundation;
//#import <PaperTrailLumberjack/RMPaperTrailLogger.h>
#import "ServerConfiguration.h"

#if DEBUG
//static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
//static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

// Note: This is some weird preprocessor stuff. I know.
// This is the only way that Papertrail shows the source of the log correctly.
//#define base_log(text, force_prod) if ([ServerConfiguration isLoggingEnabled] || force_prod) { NSLog(@"%@", text); } else { DDLogVerbose(@"%@ > %@", ServerConfiguration.configuration, text); }

#define base_log(text, force_prod) if ([ServerConfiguration isLoggingEnabled] || force_prod) { NSLog(@"%@", text); } else { NSLog(@"%@ > %@", ServerConfiguration.configuration, text); }

#define log(text) base_log(text, false)

#define log_prefix(prefix, text) log([[prefix stringByAppendingString:@"\t > "] stringByAppendingString:text]);

#define prod_log base_log(true)

#define dev_log(text) if ([ServerConfiguration.configuration isEqualToString:@"Development"]) { NSLog(@"%@", text); }

@interface Logging : NSObject

+ (void)setupLogger;

@end

