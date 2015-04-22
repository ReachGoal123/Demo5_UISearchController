//
//  TRPerson.m
//  Demo5_UISearchController
//
//  Created by tarena on 15-1-28.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRPerson.h"

@implementation TRPerson
- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber gender:(NSString *)gender
{
    self = [super init];
    if (self) {
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.gender = gender;
    }
    return self;
}
@end
