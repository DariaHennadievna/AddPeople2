//
//  AddPhoneNumberVC.h
//  AddPeople2
//
//  Created by Admin on 25.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "PhoneNumbersVC.h"
#import "PhoneNumber.h"
#import "MyContact.h"
#import "PhoneNumber.h"
#import "MyContact+Creating.h"
#import "PhoneNumber+Creating.h"

@interface AddPhoneNumberVC : UIViewController

@property (nonatomic) MyContact *currentContact;

@end
