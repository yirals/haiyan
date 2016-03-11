//
//  UIViewController+Comment.m
//  走起WeakDay
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "UIViewController+Comment.h"

@implementation UIViewController (Comment)

-(void)showBackButtonWithImage:(NSString *)imageName{
    
    UIButton *backbtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backbtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backbtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void)backButtonAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)showRightButtonWith:(NSString *)tittle{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 64, 44);
//    [rightBtn setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:tittle forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(selectorText) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarButtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightbarButtn;
}

-(void)selectorText{
    
}
@end
