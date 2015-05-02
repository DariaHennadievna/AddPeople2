//
//  AddPeopleViewController.m
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddPeopleViewController.h"

@interface AddPeopleViewController ()

@property NSArray *myContacts;

@end

@implementation AddPeopleViewController

-(void)showViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Views

-(UITextField *)addNameLabel
{
    if(!_addNameLabel)
    {
        _addNameLabel = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0f - 100.0f, self.view.frame.size.height/4, 200.0f, 30.0f)];
        _addNameLabel.delegate = self;
        _addNameLabel.placeholder = @"Enter your name here...";
        _addNameLabel.borderStyle = UITextBorderStyleRoundedRect;
        _addNameLabel.autocapitalizationType = UITextAutocapitalizationTypeWords;
        _addNameLabel.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return _addNameLabel;
}

-(UITextField *)addAgeLabel
{
    if(!_addAgeLabel)
    {
        _addAgeLabel = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0f - 100.0f, (self.view.frame.size.height/4) * 1.5f, 200.0f, 30.0f)];
        _addAgeLabel.delegate = self;
        _addAgeLabel.placeholder = @"Enter your age here...";
        _addAgeLabel.borderStyle = UITextBorderStyleRoundedRect;
        _addAgeLabel.autocapitalizationType = UITextAutocapitalizationTypeWords;
        _addAgeLabel.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return _addAgeLabel;
}

-(UIButton*)addButton
{
    if(!_addButton)
    {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0f - 100.0f, (self.view.frame.size.height/4) * 2.0f, 200.0f, 30.0f)];
        _addButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3f];
        [_addButton setTitle:@"Add" forState:UIControlStateNormal];
    }
    return _addButton;
}

#pragma mark - Save in the Core Data stack

-(void)saveNewContact:(Contact *)myContact
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    [MyContact contactInitWithName:myContact.name age:myContact.age ];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Save To NSUserDefaults

-(void)saveContactToUserDefaults: (Contact *)newContact
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableArray *myContactList = [[appDelegate currentContact] mutableCopy];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject: newContact];
    [myContactList addObject:userData];
    [appDelegate setCurrentContact:[myContactList copy]];
}

#pragma mark - Actions

- (void)addButtonPressed:(id)sender
{
    //NSLog(@"Cheeeeers!!!");
    Contact *contact = [Contact new];
    contact.name = self.addNameLabel.text;
    contact.age = self.addAgeLabel.text;
    [self saveNewContact:contact];
}


#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Add new";
    
    [self.view addSubview:self.addNameLabel];
    [self.view addSubview:self.addAgeLabel];
    [self.view addSubview:self.addButton];
    
    [self.addNameLabel resignFirstResponder];
    
    [self.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

@end
