//
//  AddPeopleViewController.h
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ViewController.h"



@interface AddPeopleViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) UITextField *addNameLabel;
@property (nonatomic) UITextField *addAgeLabel;
@property (nonatomic) UIButton *addButton;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSMutableArray *contacts;

-(void)saveContactToUserDefaults: (Contact *)newContact;


@end

