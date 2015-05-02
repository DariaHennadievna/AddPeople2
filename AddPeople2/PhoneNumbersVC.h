//
//  PhoneNumbersVC.h
//  AddPeople2
//
//  Created by Admin on 24.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PhoneNumbersCell.h"
#import "AddPhoneNumberVC.h"
#import "AppDelegate.h"
#import "MyContact.h"
#import "PhoneNumber.h"
#import "MyContact+Creating.h"
#import "PhoneNumber+Creating.h"

@interface PhoneNumbersVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) MyContact *currentContact;
@property (nonatomic) NSMutableArray *phoneNumbers;

-(void) loadFromUserDefaults;
-(void) deleteNumberAtIndex:(NSInteger)index;

#pragma mark - Core Data

-(MyContact *)gettingContactWithName:(NSString *)name age:(NSString *)age;
-(NSMutableArray *)gettingPhoneNumbersOfContact:(MyContact *)myContact;
-(PhoneNumber *)gettingPhoneNumberWith:(NSString *)phoneNumber;
-(void)deleteNumber:(NSString *)phoneNumber;


@end
