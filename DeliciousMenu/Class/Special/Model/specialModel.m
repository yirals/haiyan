//
//  specialModel.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "specialModel.h"

@implementation specialModel

-(instancetype)initWithModel:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.nameLable = dict[@"546"];
        self.makeLable = dict[@"5423"];
    }
    return self;
}

@end
