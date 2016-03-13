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
#import "MainViewController.h"
@interface LoginViewController ()

@property(nonatomic, strong) UITextField *resignTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self showBackButtonWithImage:@"btn_left"];
    
    
    [self.view addSubview:self.resignPass];
    
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
  
    [BmobUser loginWithUsernameInBackground:self.resignTF.text password:self.resignPass.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            [ProgressHUD show:@"正在登录"];
            [ProgressHUD showSuccess:@"登录成功"];

            MainViewController *main = [[MainViewController alloc] init];
            
            main.str = self.resignTF.text;
            
            self.str1 = @"1";
            main.str1 = self.str1;
            

            YiralLog(@"%@",self.resignTF.text);
            
            
            [self.navigationController pushViewController:main animated:YES];

        }else{
            YiralLog(@"登录失败")
//            [ProgressHUD showSuccess:@"登录失败，请检查您的账户密码是否正确"];
            
            [self AlertController:@"登录失败，请检查您的账户密码是否正确"];
        }
        
        
    }];
    
    
    
    
    
    
}
//在视图即将消失的时候，收起第三方菊花

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [ProgressHUD dismiss];
    
    
}

-(void)AlertController:(NSString *)art{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:art preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YiralLog(@"确定");
    }];
    UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YiralLog(@"取消");
    }];
    
    [alert addAction:action];
    [alert addAction:quxiao];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)pushResignVC{
    
    ResignViewController *resign = [[ResignViewController alloc] init];
    [self.navigationController pushViewController:resign animated:YES];
    
}

//点击右下角回收键盘；
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

//点击空白处回收键盘；
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //两种方法回收键盘；
    [self.view endEditing:YES];
    
    
}

-(UITextField *)resignTF{
    if (_resignTF == nil) {
        
        self.resignTF = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/6, kWidth*3/4, 45)];
        self.resignTF.placeholder = @"请输入用户名";
        self.resignTF.textAlignment = NSTextAlignmentCenter;
        self.resignTF.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:self.resignTF];
        
        
        
    }
    
    return _resignTF;
}


-(UITextField *)resignPass{
    if (_resignPass == nil) {
        self.resignPass = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/6+50, kWidth*3/4, 45)];
        self.resignPass.placeholder = @"请输入密码";
        //文字居中
        self.resignPass.textAlignment = NSTextAlignmentCenter;
        //边框样式
        self.resignPass.borderStyle = UITextBorderStyleRoundedRect;
        self.resignTF.text = self.str;
        //密文显示
        self.resignPass.secureTextEntry = YES;

    }
    return _resignPass;
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
