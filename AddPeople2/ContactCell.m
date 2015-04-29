//
//  ContactCell.m
//  AddPeople2
//
//  Created by Admin on 19.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

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

-(void) configureCell
{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, self.frame.size.width/2.0f - 10.0f, self.frame.size.height)];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.nameLabel = nameLabel;
    [self addSubview:self.nameLabel];
    
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0f, 0.0f, self.frame.size.width/2.0f - 10.0f, self.frame.size.height)];
    ageLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    ageLabel.textAlignment = NSTextAlignmentRight;    
    self.ageLabel = ageLabel;
    [self addSubview:self.ageLabel];
    
}


@end
