//
//  Logging.m
//  Mantle
//
//  Created by William Tachau on 12/10/17.
//

#import "Logging.h"

@implementation Logging

+ (void)setupLogger
{
    RMPaperTrailLogger *paperTrailLogger = [RMPaperTrailLogger sharedInstance];
    paperTrailLogger.host = @"logs4.papertrailapp.com";
    paperTrailLogger.port = 36059;
    //        paperTrailLogger.debug = NO; //Silences some NSLogging
    [DDLog addLogger:paperTrailLogger];
}

@end

