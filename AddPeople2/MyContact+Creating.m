//
//  MyContact+Creating.m
//  AddPeople2
//
//  Created by Admin on 29.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "MyContact+Creating.h"

@implementation MyContact (Creating)

+(instancetype) contactInitWithName:(NSString *)name age:(NSString *)age
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    MyContact *myContact = (MyContact *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
    if (myContact) {
        myContact.name = name;
        myContact.age = age;
    }
    return myContact;
}
    

@end
