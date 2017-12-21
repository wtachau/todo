//
//  NSLayoutConstraint+AutoLayout.h
//  OriginateAutoLayout
//
//  Created by Aaron Daub on 2015-08-13.
//  Copyright (c) 2015 Originate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (AutoLayout)

+ (instancetype)constraintWithItem:(id)item attribute:(NSLayoutAttribute)attribute toItem:(id __nullable)secondItem;
+ (void)ori_activateConstraints:(NSArray *)constraints;

@end

NS_ASSUME_NONNULL_END