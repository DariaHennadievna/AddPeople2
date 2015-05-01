//
//  MyContact+Creating.h
//  AddPeople2
//
//  Created by Admin on 29.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "MyContact.h"
#import "AppDelegate.h"

@interface MyContact (Creating)

+(instancetype) contactInitWithName:(NSString *)name age:(NSString *)age;

@end
