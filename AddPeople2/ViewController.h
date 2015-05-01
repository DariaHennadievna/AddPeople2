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

-(NSMutableArray *) loadFromUserDefaults;
-(void) deleteContactFromContactsListAtIndex:(NSInteger)index;

-(void)showAddPeopleViewController;
-(void)showPhoneNumbersVC;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

