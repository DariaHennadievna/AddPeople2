//
//  AppDelegate.h
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark - Contacts

- (NSArray *)currentContact;
-(void)setCurrentContact:(NSArray *)contacts;

#pragma mark - Phone Numbers

-(NSArray *)phoneNumbersForKey:(NSString *)key;
-(void)setPhoneNumbers:(NSArray *)phoneNumbers ForKey: (NSString *)key;



@end

