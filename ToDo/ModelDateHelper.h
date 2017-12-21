//
//  ModelDateHelper.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;

@interface ModelDateHelper : NSObject

+ (NSDateFormatter *)dateFormatter;
+ (NSDateFormatter *)dateTimeFormatter;
+ (NSValueTransformer *)dateTransformer;
+ (NSValueTransformer *)dateTimeTransformer;

@end
