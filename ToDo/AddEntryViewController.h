//
//  AddEntryViewController.h
//  ToDo
//
//  Created by William Tachau on 12/22/17.
//  Copyright © 2017 Tachau. All rights reserved.
//

@import UIKit;
@class Type;
#import "AddEntryDelegate.h"

@interface AddEntryViewController : UIViewController

@property (strong, nonatomic, readwrite) Type *selectedType;
@property (nonatomic, weak, readwrite) NSObject<AddEntryDelegate> *addEntryDelegate;

@end
