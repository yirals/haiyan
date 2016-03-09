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
        self.nameLable = dict[@"title"];
        self.ImagView = dict[@"cover"];
        self.makeLable = dict[@"message"];
        
        self.rid = dict[@"id"];
        
    }
    return self;
}

@end
