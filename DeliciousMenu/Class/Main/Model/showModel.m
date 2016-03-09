//
//  showModel.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "showModel.h"

@implementation showModel

-(instancetype)initModelData:(NSDictionary *)model{
    self = [super init];
    if (self) {
        self.image = model[@"cover"];
        self.states = model[@"cuisine"];
        self.wayLable = model[@"technics"];
        self.diffLable = model[@"level"];
        self.nameLable = model[@"subject"];
        self.timeLable = model[@"during"];
        self.showImageView = model[@"pic"];
        self.makeLable = model[@"note"];
        self.ird = model[@"ird"];
//        self.idx = model[@"idx"];
        
    }
    return self;
}




//-(void)getModelData:(NSDictionary *)model{
//    
//    if (self) {
//        self.states = model[@""];
//    }
//   
//    return self;
//}

@end
