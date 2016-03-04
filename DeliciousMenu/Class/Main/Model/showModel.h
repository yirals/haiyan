//
//  showModel.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface showModel : NSObject
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *states;
@property(nonatomic, copy) NSString *wayLable;
@property(nonatomic, copy) NSString *timeLable;
@property(nonatomic, copy) NSString *diffLable;
@property(nonatomic, copy) NSString *nameLable;

-(void)getModelData:(NSDictionary *)model;

@end