//
//  PhoneNumbersCell.m
//  AddPeople2
//
//  Created by Admin on 24.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PhoneNumbersCell.h"

@implementation PhoneNumbersCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self configureCell];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self configureCell];
    }
    return self;
}

-(void)configureCell
{
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.f, self.frame.size.height)];
    numberLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneNumberLabel = numberLabel;    
    [self addSubview:self.phoneNumberLabel];    
}

@end
