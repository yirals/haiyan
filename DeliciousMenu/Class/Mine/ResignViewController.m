//
//  ResignViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ResignViewController.h"
#import "UIViewController+Comment.h"
#import "ProgressHUD.h"
#import <BmobSDK/BmobUser.h>
#import "LoginViewController.h"

@interface ResignViewController ()

@property(nonatomic, strong) UITextField *resignName;
@property(nonatomic, strong) UITextField *resignEmail;
@property(nonatomic, strong) UITextField *resignPass;
@property(nonatomic, strong) UITextField *resignSecPass;

@end

@implementation ResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    [self showBackButtonWithImage:@"btn_left"];
    //头像
    UIImageView *TitleImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/4, kHeight/7, kWidth/2, kWidth/2)];
    TitleImage.backgroundColor = [UIColor cyanColor];
    TitleImage.layer.cornerRadius = kWidth/4;
    TitleImage.clipsToBounds = YES;
    TitleImage.image = [UIImage imageNamed:@"2dac0149c5f82fad5dd686c9176e4a3e"];
    [self.view addSubview:TitleImage];
    
    
    //用户名
    self.resignName = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/2, kWidth*3/4, 45)];
    self.resignName.placeholder = @"请输入用户名";
    self.resignName.textAlignment = NSTextAlignmentCenter;
    self.resignName.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.resignName];
    
    
    //邮箱
    self.resignEmail = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/2+50, kWidth*3/4 , 45)];
    self.resignEmail.placeholder = @"请输入邮箱";
    self.resignEmail.textAlignment = NSTextAlignmentCenter;
    self.resignEmail.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.resignEmail];

    
    //密码
    self.resignPass = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/2+100, kWidth*3/4, 45)];
    self.resignPass.placeholder = @"请输入密码";
    self.resignPass.textAlignment = NSTextAlignmentCenter;
    self.resignPass.borderStyle = UITextBorderStyleRoundedRect;
    self.resignPass.secureTextEntry = YES;
    [self.view addSubview:self.resignPass];
    
    //再次输入密码；
    self.resignSecPass = [[UITextField alloc] initWithFrame:CGRectMake(kWidth/8, kHeight/2 +150, kWidth*3/4, 45)];
    self.resignSecPass.placeholder = @"请再次输入密码";
    self.resignSecPass.textAlignment = NSTextAlignmentCenter;
    self.resignSecPass.borderStyle = UITextBorderStyleRoundedRect;
    self.resignSecPass.secureTextEntry = YES;
    [self.view addSubview:self.resignSecPass];
    
    
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame = CGRectMake(kWidth/2, kHeight/2 +200, kWidth/4, 45);
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];

    [finish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:finish];
    
  
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


-(void)finishAction{
    if (![self checkOut]) {
        return ;
    }
    [ProgressHUD show:@"正在注册"];
    
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.resignName.text];
    [bUser setPassword:self.resignPass.text];
    [bUser setObjectId:self.resignEmail.text];
    [bUser setEmail:self.resignEmail.text];
    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
//            [self AlertController:@"注册成功"];
            [ProgressHUD showSuccess:@"注册成功"];
            
            LoginViewController *controller = [[LoginViewController alloc] init];
            
            controller.str = self.resignName.text;
            
            [self.navigationController pushViewController:controller animated:YES];
            
            
        }else{
            [self AlertController:@"注册失败，请按照要求重试"];

        }
    }];

    
    
    
}

-(BOOL)checkOut{
    
    //用户名不能为空，且不能包含空格符号
    
    if (self.resignName.text.length <= 0 || [self.resignName.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"用户名不能包含空格且不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;}
    //判断邮箱是否合法；
    if (![self isValidateEmail:self.resignEmail.text] ){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的邮箱不符合规范" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }


        //密码不能为空且不能包含空字符
    
    
    if (self.resignPass.text.length <= 0 || [self.resignPass.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"密码名不能包含空格且不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
        
    }
    if (![self.resignPass.text isEqualToString:self.resignSecPass.text]){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"两次输入密码不相同" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            YiralLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
   
    return YES;
    
}
//验证手机号是否合法
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//验证邮箱是否合法；
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
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
