//
//  PhoneNumber+Creating.h
//  AddPeople2
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PhoneNumber.h"
#import "AppDelegate.h"

@interface PhoneNumber (Creating)

+(instancetype) numberInitWithContact:(MyContact *)myContact number:(NSString *)number;

@end
