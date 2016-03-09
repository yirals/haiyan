//
//  LoginViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+Comment.h"
#import "ResignViewController.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"
#import "ViewController.h"
@interface LoginViewController ()

@property(nonatomic, strong) UITextField *resignTF;
@property(nonatomic, strong) UITextField *resignPass;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self showBackButtonWithImage:@"btn_left"];
    
    self.resignTF = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/6, kWidth*3/4, 45)];
    self.resignTF.placeholder = @"请输入用户名";
    self.resignTF.textAlignment = NSTextAlignmentCenter;
    self.resignTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.resignTF];
    
    
    self.resignPass = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/6+50, kWidth*3/4, 45)];
    self.resignPass.placeholder = @"请输入密码";
    self.resignPass.textAlignment = NSTextAlignmentCenter;
    self.resignPass.borderStyle = UITextBorderStyleRoundedRect;
    self.resignPass.secureTextEntry = YES;
    [self.view addSubview:self.resignPass];
    
    //QQ登录按钮
    UIButton *QQfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    QQfinish.frame = CGRectMake(kWidth/8, kHeight/6 + 200, kWidth/4, 45);
    UIImageView *qq = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    
    qq.image = [UIImage imageNamed:@"485c77cc7"];
    [QQfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [QQfinish addSubview:qq];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(45,0, QQfinish.frame.size.width*3/4, 45)];
    lable.text = @"QQ登录";
    lable.tintColor = [UIColor grayColor];
    [QQfinish addSubview:lable];
    [self.view addSubview:QQfinish];
    
    //登录按钮
    UIButton *Loginfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    [Loginfinish setTitle:@"登录" forState:UIControlStateNormal];
    [Loginfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Loginfinish addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    Loginfinish.frame = CGRectMake(kWidth/8, kHeight/6+100, kWidth/4, 45);
    [self.view addSubview:Loginfinish];
    
    //注册
    UIButton *resignLfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    [resignLfinish setTitle:@"注册" forState:UIControlStateNormal];
    [resignLfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    resignLfinish.frame = CGRectMake(kWidth/8, kHeight/6+150, kWidth/4, 45);
    [resignLfinish addTarget:self action:@selector(pushResignVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignLfinish];
    
 
    
}


-(void)login{
    
    [ProgressHUD show:@"正在登录"];
    
    [BmobUser loginWithUsernameInBackground:self.resignTF.text password:self.resignPass.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            YiralLog(@"%@",self.resignTF.text);
        }
        
        
    }];
    [ProgressHUD showSuccess:@"恭喜您，登录成功"];
    
    
    ViewController *VC = [[ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ProgressHUD dismiss];
    
    
}

-(void)pushResignVC{
    
    ResignViewController *resign = [[ResignViewController alloc] init];
    [self.navigationController pushViewController:resign animated:YES];
    
}


//点击空白处回收键盘；
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //两种方法回收键盘；
    [self.view endEditing:YES];
    
    
}

//点击右下角回收键盘；
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
