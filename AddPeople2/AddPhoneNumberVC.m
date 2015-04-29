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
    //NSLog(@"self.phoneNumberTextFiled.text = %@", self.phoneNumberTextFiled.text);
    [self saveContactToUserDefaults:self.phoneNumberTextFiled.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentKey = self.title;
    //NSLog(@"currentKey = %@", self.currentKey);
}

@end
