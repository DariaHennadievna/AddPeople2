//
//  ViewController.h
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ContactCell.h"
#import "AddPeopleCell.h"
#import "AddPeopleViewController.h"
#import "Contact.h"
#import "AppDelegate.h"
#import "PhoneNumbersVC.h"
#import "MyContact+Creating.h"

@interface ViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) MyContact *contactInList;

-(NSMutableArray *) loadFromUserDefaults;
-(void) deleteContactFromContactsListAtIndex:(NSInteger)index;

#pragma mark - Show Controllers
-(void)showAddPeopleViewController;
-(void)showPhoneNumbersVC;

#pragma mark - Core Data
-(void)reload;
-(MyContact *)gettingContactWithName:(NSString *)name age:(NSString *)age;
-(void)deleteContactWithName:(NSString *)name age:(NSString *)age;


@end

