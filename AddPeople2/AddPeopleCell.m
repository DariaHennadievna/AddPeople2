//
//  AddPeopleCell.m
//  AddPeople2
//
//  Created by Admin on 20.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AddPeopleCell.h"

@implementation AddPeopleCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self configureAddPeopleCell];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self configureAddPeopleCell];
    }
    return self;
}

-(void)configureAddPeopleCell
{
    UILabel *addPeopleCell = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width,  self.frame.size.height)];
    addPeopleCell.textAlignment = NSTextAlignmentCenter;
    addPeopleCell.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.3f];
    self.addPeopleLabel = addPeopleCell;
    [self addSubview:self.addPeopleLabel];
}

@end
