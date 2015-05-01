//
//  AddPeopleViewController.h
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Contact.h"
#import "MyContact.h"
#import "MyContact+Creating.h"
#import "ViewController.h"



@interface AddPeopleViewController : UIViewController <UITextFieldDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic) UITextField *addNameLabel;
@property (nonatomic) UITextField *addAgeLabel;
@property (nonatomic) UIButton *addButton;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSMutableArray *contacts;

//for CoreData
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void)saveContactToUserDefaults: (Contact *)newContact;


@end

