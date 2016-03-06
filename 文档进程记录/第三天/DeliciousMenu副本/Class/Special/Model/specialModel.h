//
//  specialModel.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface specialModel : NSObject
@property(nonatomic, copy) NSString *nameLable;
@property(nonatomic, copy) NSString *makeLable;

-(instancetype)initWithModel:(NSDictionary *)dict;

@end
