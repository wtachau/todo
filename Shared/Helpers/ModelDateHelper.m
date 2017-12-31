//
//  ModelDateHelper.m
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

#import "ModelDateHelper.h"
#import "Mantle.h"

@implementation ModelDateHelper

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}

+ (NSDateFormatter *)dateTimeFormatter {
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    dateTimeFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateTimeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    dateTimeFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    return dateTimeFormatter;
}

+ (NSValueTransformer *)dateTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[[self class] dateFormatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[[self class] dateFormatter] stringFromDate:date];
    }];
}

+ (NSValueTransformer *)dateTimeTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[[self class] dateTimeFormatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        // This is a hack because of the way Marshmallow (the Flask serializer) handles datetimes.
        // Although the datetimes are timezone-unaware at the DB level, the serializer imposes a timezone.
        // If we try to include that timezone in the request to the server, the backend de-serialization fails.
        // This is the cleanest place I found to inject a fix.
        // More: https://github.com/marshmallow-code/marshmallow/issues/520,
        //       https://github.com/marshmallow-code/marshmallow/issues/627,
        //       https://github.com/marshmallow-code/marshmallow/issues/309
        NSString *dateString = [[[self class] dateTimeFormatter] stringFromDate:date];
        NSRange range = [dateString rangeOfString:@"+"];
        if (range.location != NSNotFound) {
            return [dateString substringToIndex:range.location];
        } else {
            return dateString;
        }
    }];
}
@end
