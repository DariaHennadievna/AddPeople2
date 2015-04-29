//
//  AddPeopleViewController.m
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddPeopleViewController.h"

@interface AddPeopleViewController ()

@end

@implementation AddPeopleViewController

-(void)showViewController
{
    [self.navigationController popViewControllerAnimated:YES];
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
    NSLog(@"Cheeeeers!!!");
    
    Contact *contact = [Contact new];
    contact.name = self.addNameLabel.text;
    contact.age = self.addAgeLabel.text;
    
    [self saveContactToUserDefaults:contact];
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

#pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    /*
    NSString *endString = @" ";
    if([string isEqualToString:endString])
    {
        NSString *name = [newString substringToIndex:(newString.length - 1)];
        
        [textField resignFirstResponder];
        textField.text = name;
        
        if([textField isEqual:self.addNameLabel])
        {
            self.name = textField.text;
            NSLog(@"NAME is [%@]", self.name);
        }
        else if ([textField isEqual:self.addAgeLabel])
        {
            self.age = textField.text;
            NSLog(@"NAME is [%@]", self.age);
        }
    }
     */
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
