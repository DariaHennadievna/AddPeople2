//
//  AppDelegate.m
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"

NSString *const DefaultContactsKey = @"DefaultContactsKey";

@interface AppDelegate ()


@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - Contacts

- (NSArray *)currentContact
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];    
    NSArray *myContacts = [userDefaults objectForKey:DefaultContactsKey];
    
    return myContacts;
}

-(void)setCurrentContact:(NSArray *)contacts
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:contacts forKey:DefaultContactsKey];
    [userDefaults synchronize];
}

#pragma mark - Phone Numbers

-(NSArray *)phoneNumbersForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *myNumbers = [userDefaults objectForKey:key];
    
    return myNumbers;
}

-(void)setPhoneNumbers:(NSArray *)phoneNumbers ForKey: (NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phoneNumbers forKey:key];
    [userDefaults synchronize];
}

/*
- (void)setCurrentContact:(Contact *)newContact
{
    NSLog(@"new contact = %@, %@", newContact.name, newContact.age);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject: newContact];
    
    [userDefaults setObject:userData forKey:DefaultContactsKey];
    
    [userDefaults synchronize];
    
    NSLog(@"self.array = [%@]", userDefaults);
}
*/





@end
