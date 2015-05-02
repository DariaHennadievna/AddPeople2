//
//  AddPhoneNumberVC.m
//  AddPeople2
//
//  Created by Admin on 25.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddPhoneNumberVC.h"

@interface AddPhoneNumberVC ()

- (IBAction)addNewPhoneNumber:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFiled;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) NSArray *listOfNumbers;
@property (nonatomic) NSString *currentKey;
@property (nonatomic) MyContact *contact;

@end


@implementation AddPhoneNumberVC

-(AppDelegate *)appDelegate
{
    if(!_appDelegate)
    {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

#pragma marc - Core Data

-(void)gettingContactWithName:(NSString *)name age:(NSString *)age
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([MyContact class])];
    NSArray *allContacts = [context executeFetchRequest:request error:nil];
    for (MyContact *contact in allContacts)
    {
        if ([contact.name isEqual:name] && [contact.age isEqual:age] )
        {
            self.contact = contact;
        }
    }
}

-(void)addNewNumber:(NSString *)newNumber toTheContact:(MyContact *)myContact
{
    PhoneNumber *number = (PhoneNumber *)[PhoneNumber  numberInitWithContact:myContact
                                                                      number:self.phoneNumberTextFiled.text];
    [myContact addPhoneNumbersObject:number];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Save Data

-(void)saveContactToUserDefaults: (NSString *)newPhoneNumber
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableArray *myNumberList = [[appDelegate phoneNumbersForKey: self.currentKey] mutableCopy];
    if(!myNumberList)
    {
       myNumberList = [[NSMutableArray alloc] init];
    }
    
    [myNumberList addObject:newPhoneNumber];
    self.listOfNumbers = [myNumberList copy];
    [appDelegate setPhoneNumbers:self.listOfNumbers ForKey:self.currentKey];
}


#pragma mark - Actions

- (IBAction)addNewPhoneNumber:(UIBarButtonItem *)sender
{
    [self addNewNumber:self.phoneNumberTextFiled.text toTheContact:self.contact];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"contact name = %@, age = %@, phone = %li", self.currentContact.name, self.currentContact.age,
          self.currentContact.phoneNumbers.count);
    [self gettingContactWithName:self.currentContact.name age:self.currentContact.age];
}

@end
