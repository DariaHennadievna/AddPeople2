//
//  PhoneNumbersVC.h
//  AddPeople2
//
//  Created by Admin on 24.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneNumbersCell.h"
#import "AddPhoneNumberVC.h"
#import "AppDelegate.h"

@interface PhoneNumbersVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

-(void) loadFromUserDefaults;
-(void) deleteNumberAtIndex:(NSInteger)index;

@end
