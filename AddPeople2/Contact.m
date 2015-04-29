//
//  Contact.m
//  AddPeople2
//
//  Created by Admin on 20.04.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Contact.h"

 NSString *const ContactNameKey = @"ContactNameKey";
 NSString *const ContactAgeKey = @"ContactAgeKey";
// NSString *const ContactArrayKey = @"ContactArrayKey";

@implementation Contact

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:self.name forKey:ContactNameKey];
    [aCoder encodeObject:self.age forKey:ContactAgeKey];
    //[aCoder encodeObject:self.arrayContact forKey:ContactArrayKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.name = [aDecoder decodeObjectForKey:ContactNameKey];
        self.age = [aDecoder decodeObjectForKey:ContactAgeKey];
        //self.arrayContact = [aDecoder decodeObjectForKey:ContactArrayKey];
    }
    return self;
}

@end
