//
//  NewViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()
@property(nonatomic, retain) UIWebView *webView;

@end

@implementation NewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self ];
    self.webView = [[UIWebView alloc] init];
//    NSString *urlStr = @"http://m.benlai.com/showSite";
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSLog(@"url:%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.benlai.com/showSite"]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
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
