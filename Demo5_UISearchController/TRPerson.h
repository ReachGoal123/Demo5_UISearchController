//
//  TRPerson.h
//  Demo5_UISearchController
//
//  Created by tarena on 15-1-28.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPerson : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phoneNumber;
@property (nonatomic, strong)NSString *gender;

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber gender:(NSString *)gender;
@end





