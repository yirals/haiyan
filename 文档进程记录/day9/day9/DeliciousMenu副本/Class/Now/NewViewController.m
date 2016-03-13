//
//  NewViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "NewViewController.h"
#import "ZMYNetManager.h"
@interface NewViewController ()




@end

@implementation NewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [ProgressHUD show:@"正在加载"];


    
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
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
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    NSURL *url = [NSURL URLWithString:@"http://m.benlai.com/showSite"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [ProgressHUD showSuccess:@"已成功"];
    [self.view addSubview:webView];
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:YES];
//    [ProgressHUD show:@"正在加载"];
//
//}

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
