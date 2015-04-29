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

- (IBAction)addNewPhoneNumber:(UIBarButtonItem *)sender;

@end

@implementation PhoneNumbersVC

-(UITableView *)phoneNumbersTableView
{
    if(!_phoneNumbersTableView)
    {
        _phoneNumbersTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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

-(void) deleteNumberAtIndex:(NSInteger)index
{
    self.numbersFromUserDefaults = [self.appDelegate phoneNumbersForKey:self.title];
    
    NSMutableArray *myNumbers = [[NSMutableArray alloc] init];
    
    myNumbers = [self.numbersFromUserDefaults mutableCopy];
    
    [myNumbers removeObjectAtIndex:index];
    
    self.numbersFromUserDefaults = [myNumbers copy];
    
    [self.appDelegate setPhoneNumbers:self.numbersFromUserDefaults ForKey:self.title];    
}


#pragma mark - Load Data

-(void) loadFromUserDefaults
{
    self.numbersFromUserDefaults = [self.appDelegate phoneNumbersForKey:self.title];
    NSLog(@"self.title = %@",self.title);
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
    //NSLog(@"self.numbersFromUserDefaults.count = %lu", (unsigned long)self.numbersFromUserDefaults.count);
    return self.numbersFromUserDefaults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneNumbersCell *phoneNumbersCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass ([PhoneNumbersCell class]) forIndexPath:indexPath];
    phoneNumbersCell.phoneNumberLabel.text = self.numbersFromUserDefaults[indexPath.row];
    return phoneNumbersCell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselectRowAtIndexPath:) withObject:indexPath afterDelay:0.1f];
    
    [self deleteNumberAtIndex:indexPath.row];
    [self.phoneNumbersTableView reloadData];    
    
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
            NSLog(@"addPhoneNumberVC.title = %@", addPhoneNumberVC.title);
        }
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadFromUserDefaults];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneNumbersTableView];
    
    [self.phoneNumbersTableView registerClass:[PhoneNumbersCell class]
           forCellReuseIdentifier:NSStringFromClass([PhoneNumbersCell class])];
    
    //[self loadFromUserDefaults];
    
    self.phoneNumbersTableView.dataSource = self;
    self.phoneNumbersTableView.delegate = self;
    
}

@end
