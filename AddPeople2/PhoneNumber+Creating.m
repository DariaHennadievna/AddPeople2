//
//  PhoneNumber+Creating.m
//  AddPeople2
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PhoneNumber+Creating.h"

@implementation PhoneNumber (Creating)

+(instancetype) numberInitWithContact:(MyContact *)myContact number:(NSString *)number
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    PhoneNumber *myNumber = (PhoneNumber *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
    if (myNumber) {
        myNumber.owner = myContact;
        myNumber.number = number;
    }
    return myNumber;
}

@end
