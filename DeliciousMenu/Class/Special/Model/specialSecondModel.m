//
//  specialSecondModel.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "specialSecondModel.h"

@implementation specialSecondModel

-(instancetype)initWithModel:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.nameLable = dict[@"546"];
        self.makeLable = dict[@"5423"];
        self.makeLable = dict[@"1564"];
    }
    return self;
}

@end
