//
//  PersistedUserID.h
//  ToDo
//
//  Created by William Tachau on 12/16/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import Foundation;

@interface PersistedUserID : NSObject

+ (NSUUID *) getUUID;
+ (NSString *) getUUIDString;

@end
