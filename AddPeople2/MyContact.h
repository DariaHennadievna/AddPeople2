//
//  MyContact.h
//  AddPeople2
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PhoneNumber;

@interface MyContact : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *phoneNumbers;
@end

@interface MyContact (CoreDataGeneratedAccessors)

- (void)addPhoneNumbersObject:(PhoneNumber *)value;
- (void)removePhoneNumbersObject:(PhoneNumber *)value;
- (void)addPhoneNumbers:(NSSet *)values;
- (void)removePhoneNumbers:(NSSet *)values;

@end
