//
//  Entry.h
//  ToDo
//
//  Created by William Tachau on 12/10/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
#import "Mantle.h"

@interface Entry : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readwrite) NSNumber *entryId;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSNumber *type;
@property (nonatomic, strong, readwrite) NSNumber *order;
@property (nonatomic, strong, readwrite) NSNumber *userId;
@property (nonatomic, strong, readwrite) NSNumber *entryGeneratorId;
@property (nonatomic, readwrite) BOOL showBeforeActive;
@property (nonatomic, strong, readwrite) NSDate *activeAfter;
@property (nonatomic, strong, readwrite) NSDate *createdAt;
@property (nonatomic, strong, readwrite) NSDate *updatedAt;
@property (nonatomic, strong, readwrite) NSDate *completedOn;
@property (nonatomic, strong, readwrite) NSDate *deletedOn;

@end

