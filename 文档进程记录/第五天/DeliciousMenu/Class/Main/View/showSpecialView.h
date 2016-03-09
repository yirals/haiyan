//
//  showSpecialView.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "specialModel.h"
@interface showSpecialView : UIView

@property(nonatomic, strong) UIImageView *showImage;
@property(nonatomic, strong) UILabel *nameLable;

@property(nonatomic, strong) UILabel *tasteLable;
@property(nonatomic, strong) UILabel *tasteLable1;
@property(nonatomic, strong) UILabel *diffLable;
@property(nonatomic, strong) UILabel *diffLable1;

@property(nonatomic, strong) UILabel *waysLable;
@property(nonatomic, strong) UILabel *waysLable1;

@property(nonatomic, strong) UILabel *timeLable;
@property(nonatomic, strong) UILabel *timeLable1;

@property(nonatomic, strong) specialModel *spModel;

@end
