//
//  ShowViewController.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *showImageView;
//口味
@property (strong, nonatomic) IBOutlet UILabel *tasteLable;
//方法
@property (strong, nonatomic) IBOutlet UILabel *wayLable;
//时间
@property (strong, nonatomic) IBOutlet UILabel *timeLable;
//难易程度
@property (strong, nonatomic) IBOutlet UILabel *diffLable;
//名字
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@end
