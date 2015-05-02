//
//  PhoneNumbersVC.m
//  AddPeople2
//
//  Created by Admin on 24.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PhoneNumbersVC.h"

@interface PhoneNumbersVC ()

@property (nonatomic) UITableView *phoneNumbersTableView;
@property (nonatomic) NSArray *numbersFromUserDefaults;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) MyContact *contact;

- (IBAction)addNewPhoneNumber:(UIBarButtonItem *)sender;

@end

@implementation PhoneNumbersVC

#pragma mark - Views

-(UITableView *)phoneNumbersTableView
{
    if(!_phoneNumbersTableView)
    {
        _phoneNumbersTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _phoneNumbersTableView.dataSource = self;
        _phoneNumbersTableView.delegate = self;
    }
    return _phoneNumbersTableView;
}

-(AppDelegate *)appDelegate
{
    if(!_appDelegate)
    {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}


#pragma mark - Core Data

-(MyContact *)gettingContactWithName:(NSString *)name age:(NSString *)age
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([MyContact class])];
    NSArray *allContacts = [context executeFetchRequest:request error:nil];
    MyContact *myContact;
    for (MyContact *contact in allContacts)
    {
        if ([contact.name isEqual:name] && [contact.age isEqual:age] )
        {
            myContact = contact;
        }
    }
    return myContact;
}


-(NSMutableArray *)gettingPhoneNumbersOfContact:(MyContact *)myContact
{
    NSMutableArray *arrOfNumbers = [[NSMutableArray alloc] initWithCapacity:60];      
    for (PhoneNumber *myNumber in myContact.phoneNumbers)
    {
        [arrOfNumbers addObject:myNumber];
    }
    return arrOfNumbers;
}

-(PhoneNumber *)gettingPhoneNumberWith:(NSString *)phoneNumber
{
    MyContact *myContact = [self gettingContactWithName:self.contact.name age:self.contact.age];
    NSMutableArray *allNumbers = [self gettingPhoneNumbersOfContact:myContact];
    PhoneNumber *currentNumber;
    for (PhoneNumber *myNumber in allNumbers)
    {
        if([myNumber.number isEqual:phoneNumber])
        {
            currentNumber = myNumber;
        }
    }
    return currentNumber;
}


-(void)deleteNumber:(NSString *)phoneNumber
{
    MyContact *myContact = [self gettingContactWithName:self.contact.name age:self.contact.age];
    PhoneNumber *myNumber = [self gettingPhoneNumberWith:phoneNumber];
    [myContact removePhoneNumbersObject:myNumber];
    self.phoneNumbers = [self gettingPhoneNumbersOfContact:myContact];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate saveContext];    
    [self.phoneNumbersTableView reloadData];
}


#pragma mark - Load Data From User Defaults

-(void) loadFromUserDefaults
{
    self.numbersFromUserDefaults = [self.appDelegate phoneNumbersForKey:self.title];
    NSLog(@"self.title = %@",self.title);
}

-(void) deleteNumberAtIndex:(NSInteger)index
{
    self.numbersFromUserDefaults = [self.appDelegate phoneNumbersForKey:self.title];
    NSMutableArray *myNumbers = [[NSMutableArray alloc] init];
    myNumbers = [self.numbersFromUserDefaults mutableCopy];
    [myNumbers removeObjectAtIndex:index];
    self.numbersFromUserDefaults = [myNumbers copy];
    [self.appDelegate setPhoneNumbers:self.numbersFromUserDefaults ForKey:self.title];
}


#pragma mark - Action

- (IBAction)addNewPhoneNumber:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"ShowAddPhoneNumberVC" sender:self];
}


#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"self.phoneNumbers.count = %li",self.phoneNumbers.count);
    return self.phoneNumbers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneNumbersCell *phoneNumbersCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass ([PhoneNumbersCell class]) forIndexPath:indexPath];
    PhoneNumber *myNumber = self.phoneNumbers[indexPath.row];
    phoneNumbersCell.phoneNumberLabel.text = myNumber.number;
    return phoneNumbersCell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselectRowAtIndexPath:) withObject:indexPath afterDelay:0.1f];
    PhoneNumbersCell *phoneNumbersCell = (PhoneNumbersCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self deleteNumber:phoneNumbersCell.phoneNumberLabel.text];
    //NSLog(@"номер тел %@", phoneNumbersCell.phoneNumberLabel.text);
}


-(void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.phoneNumbersTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"ShowAddPhoneNumberVC"] )
    {        
        if([segue.destinationViewController isKindOfClass:[AddPhoneNumberVC class]])
        {
            AddPhoneNumberVC *addPhoneNumberVC = (AddPhoneNumberVC *)segue.destinationViewController;
            addPhoneNumberVC.title = self.title;
            addPhoneNumberVC.currentContact = self.contact; // ~~~~~ contact ~~~~~~>
            NSLog(@"addPhoneNumberVC.title = %@", addPhoneNumberVC.title);
        }
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.contact = [self gettingContactWithName:self.currentContact.name age:self.currentContact.age];
    self.phoneNumbers = [self gettingPhoneNumbersOfContact:self.contact];
    [self.phoneNumbersTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneNumbersTableView];
    [self.phoneNumbersTableView registerClass:[PhoneNumbersCell class]
           forCellReuseIdentifier:NSStringFromClass([PhoneNumbersCell class])];
}

@end
