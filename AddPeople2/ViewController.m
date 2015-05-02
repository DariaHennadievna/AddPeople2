//
//  ViewController.m
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic)  UITableView *tableView;
@property (nonatomic) NSArray *array;
@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic) NSString *nameOfContact;
@property (nonatomic) NSMutableArray *numbersForCurrentConact;

@property NSArray *contacts;

@end

@implementation ViewController


-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

-(AppDelegate *)appDelegate
{
    if(!_appDelegate)
    {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

#pragma mark - Show Controllers

-(void)showAddPeopleViewController
{
    AddPeopleViewController * addPeopleVC = [[AddPeopleViewController alloc] init];
    [self.navigationController pushViewController:addPeopleVC animated:YES];
}

-(void)showPhoneNumbersVC
{
    PhoneNumbersVC *phoneNumbersVC = [[PhoneNumbersVC alloc] init];
    [self.navigationController pushViewController:phoneNumbersVC animated:YES];
}

#pragma mark - Core Data stack

-(void)reload
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([MyContact class])];
    //NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    //NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //request.sortDescriptors = @[nameSort, ageSort];
    //NSLog(@"request %@", request);
    
    // Вариант self.managedObjectContext не работает. По-этому беру тотже "context" что использовался при сохранении
    NSArray *contacts = [context executeFetchRequest:request error:nil];
    self.contacts = contacts;
    
    //MyDebug...
    /*NSLog(@"request %lu", self.contacts.count);
    for(MyContact *myContact in self.contacts)
    {
        NSInteger index = [self.contacts indexOfObject:myContact];
        NSLog(@"# %li contact: name = %@, age = %@",index, myContact.name, myContact.age);
    }*/
}

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


-(void)deleteContactWithName:(NSString *)name age:(NSString *)age
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    MyContact *myContact = [self gettingContactWithName:name age:age];
    [context deleteObject:myContact];
    [appDelegate saveContext];
    [self reload];
    [self.tableView reloadData];
}

#pragma mark - Load From NSUserDefaults

-(NSMutableArray *) loadFromUserDefaults
{
    self.array = [self.appDelegate currentContact];
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.array.count; i++)
    {
        NSData *mycon = self.array[i];
        Contact *contact = [NSKeyedUnarchiver unarchiveObjectWithData:mycon];
        [contacts addObject:contact];
    }
    return contacts;
}


-(void) deleteContactFromContactsListAtIndex:(NSInteger)index
{
    self.array = [self.appDelegate currentContact];
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    contacts = [self.array mutableCopy];
    [contacts removeObjectAtIndex:index];
    [self.appDelegate setCurrentContact:[contacts copy]];
}

#pragma mark - Table View Data Source


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; // две секции в Table View
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(section == 0) // для первой секции с индексом 0 только одна клетка.
   {
       return 1;
   }
    
    return self.contacts.count;
}


// определяем что будет содержать ячейка
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        
        AddPeopleCell *addPeopleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddPeopleCell class]) forIndexPath:indexPath];
        addPeopleCell.addPeopleLabel.text = @"Add New";
        return addPeopleCell;
    }
    else
    {
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactCell class]) forIndexPath:indexPath];
        MyContact *myContact = self.contacts[indexPath.row];
        cell.nameLabel.text = myContact.name;
        cell.ageLabel.text = myContact.age;
        return cell;
    }
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselectRowAtIndexPath:) withObject:indexPath afterDelay:0.1f];
    if(indexPath.section == 0)
    {
        [self showAddPeopleViewController];
    }
    if(indexPath.section == 1)
    {
        ContactCell *myCell = (ContactCell *)[tableView cellForRowAtIndexPath:indexPath];
        if(myCell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            NSLog(@"UITableViewCellAccessoryCheckmark");
            [self deleteContactWithName:myCell.nameLabel.text age:myCell.ageLabel.text];
            myCell.accessoryType = UITableViewCellAccessoryNone;
        }
        else
        {
            self.contactInList = [self gettingContactWithName:myCell.nameLabel.text age:myCell.ageLabel.text];
            self.nameOfContact = self.contactInList.name;
            [self performSegueWithIdentifier:@"ShowPhoneNumbersVC" sender:self];
        }
    }
}

-(void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma marc - Gesture Recognizer

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    //Get location of the swipe
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    //Get the corresponding index path within the table view
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    //Check if index path is valid
    if(indexPath)
    {
        //Get the cell out of the table view
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        //Update the cell or model
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.
    }
}


#pragma marc - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"ShowPhoneNumbersVC"] )
    {
        if([segue.destinationViewController isKindOfClass:[PhoneNumbersVC class]])
        {
            PhoneNumbersVC *phoneNumbersVC = (PhoneNumbersVC *)segue.destinationViewController;
            phoneNumbersVC.currentContact = self.contactInList;          
            
            if(!self.nameOfContact)
            {
                phoneNumbersVC.title = @"NoName";
            }
            else
            {
                phoneNumbersVC.title = self.nameOfContact;
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"People";
    [self.view addSubview:self.tableView];
    [self reload];
    
    // регистрируем клетку. Обязательно надо сделать!!!
    [self.tableView registerClass:[AddPeopleCell class]
           forCellReuseIdentifier:NSStringFromClass([AddPeopleCell class])];
    
    [self.tableView registerClass:[ContactCell class] forCellReuseIdentifier:NSStringFromClass([ContactCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleSwipeLeft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.tableView addGestureRecognizer:recognizer];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self reload];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(handleSwipeLeft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.tableView addGestureRecognizer:recognizer];
}


@end
