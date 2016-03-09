//
//  specialSecondModel.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface specialSecondModel : NSObject
@property(nonatomic, copy) NSString *ImagView;
@property(nonatomic, copy) NSString *nameLable;
@property(nonatomic, copy) NSString *makeLable;
@property(nonatomic, copy) NSString *rid;


-(instancetype)initWithModel:(NSDictionary *)dict;


@end
