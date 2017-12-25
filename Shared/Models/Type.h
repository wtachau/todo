//
//  Type.h
//  ToDo
//
//  Created by William Tachau on 12/24/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;
#import "Mantle.h"
@class Entry;   

@interface Type : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readwrite) NSNumber *typeId;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSNumber *order;
@property (nonatomic, strong, readwrite) NSDate *createdAt;
@property (nonatomic, strong, readwrite) NSDate *updatedAt;
@property (nonatomic, strong, readwrite) NSArray <Entry *> *entries;

@end

