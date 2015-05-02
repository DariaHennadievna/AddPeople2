//
//  PhoneNumber.h
//  AddPeople2
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyContact;

@interface PhoneNumber : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) MyContact *owner;

@end
