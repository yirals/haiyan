//
//  MainViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "MainViewController.h"
#import "ResignViewController.h"
#import "LoginViewController.h"

#import "WBHttpRequest+WeiboShare.h"
#import "AppDelegate.h"
#import "WXApiObject.h"
#import "WXApi.h"

#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuthObject.h>


@interface MainViewController ()<UIApplicationDelegate,WBHttpRequestDelegate,TencentLoginDelegate,TencentSessionDelegate>


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人";
    
    
    //注册按钮；
    UIButton *RegisterBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [RegisterBt setTitle:@"注册" forState:UIControlStateNormal];
    RegisterBt.frame = CGRectMake(kWidth/8, kHeight/4, kWidth*3/4, 45);
    RegisterBt.backgroundColor = backGround1;
//    RegisterBt.tintColor  [UIColor blackColor];
    [RegisterBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [RegisterBt addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:RegisterBt];
    
    //登录按钮
    UIButton *loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    loginBt.frame = CGRectMake(kWidth/8, kHeight/4+60, kWidth*3/4, 45);
    [loginBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBt addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    loginBt.backgroundColor = backGround1;
    [self.view addSubview:loginBt];

    
    //weibo分享；
    UIButton *wbfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    wbfinish.frame = CGRectMake(kWidth/7, kHeight/2, kWidth/2, 45);
    [wbfinish addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *weibo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    weibo.image = [UIImage imageNamed:@"ic_com_sina_weibo_sdk_logo"];
    [wbfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [wbfinish addSubview:weibo];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(45,0, wbfinish.frame.size.width*3/4, 45)];
    lable.text = @"微博分享";
    lable.tintColor = [UIColor grayColor];
    [wbfinish addSubview:lable];
    [self.view addSubview:wbfinish];
    
    
    
    //QQ登录按钮
    
    UIButton *QQfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    QQfinish.frame = CGRectMake(kWidth/7, kHeight/2+50, kWidth/2, 45);
    [QQfinish addTarget:self action:@selector(loginQQAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *qq = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    qq.image = [UIImage imageNamed:@"xiaoqie"];
    [QQfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [QQfinish addSubview:qq];
    UILabel *qqlable = [[UILabel alloc] initWithFrame:CGRectMake(45,0, QQfinish.frame.size.width*3/4, 45)];
    qqlable.text = @"分享QQ空间";
    qqlable.tintColor = [UIColor grayColor];
    [QQfinish addSubview:qqlable];
    [self.view addSubview:QQfinish];

    
    //微信朋友
    UIButton *wxFfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    wxFfinish.frame = CGRectMake(kWidth/7, kHeight/2 +100, kWidth/2, 45);
    
    [wxFfinish addTarget:self action:@selector(loginWXFAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *wxF = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    
    wxF.image = [UIImage imageNamed:@"WX"];
    [wxFfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [wxFfinish addSubview:wxF];
    UILabel *wxFlable = [[UILabel alloc] initWithFrame:CGRectMake(45,0, wxFfinish.frame.size.width*3/4, 45)];
    wxFlable.text = @"分享好友";
    wxFlable.tintColor = [UIColor grayColor];
    [wxFfinish addSubview:wxFlable];
    [self.view addSubview:wxFfinish];


    //微信朋友圈
    UIButton *wxfinish = [UIButton buttonWithType:UIButtonTypeCustom];
    wxfinish.frame = CGRectMake(kWidth/7, kHeight/2 +150, kWidth/2, 45);
    
    [wxfinish addTarget:self action:@selector(loginWXAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *wx = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    
    wx.image = [UIImage imageNamed:@"pyq"];
    [wxfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [wxfinish addSubview:wx];
    UILabel *wxlable = [[UILabel alloc] initWithFrame:CGRectMake(45,0, wxfinish.frame.size.width*3/4, 45)];
    wxlable.text = @"分享朋友圈";
    wxlable.tintColor = [UIColor grayColor];
    [wxfinish addSubview:wxlable];
    [self.view addSubview:wxfinish];


}

-(void)RegisterAction{
    
    ResignViewController *resignVC = [[ResignViewController alloc] init];
    //收起下方导航；
    resignVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resignVC animated:NO];
    
    
}

-(void)loginAction{
    
    LoginViewController *loginiVC = [[LoginViewController alloc]init];
    loginiVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginiVC animated:YES];
    
}

#pragma mark--------微博分享的实现方法；
-(void)shareAction{
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
        authRequest.scope = @"all";
        
        
        WBSendMessageToWeiboRequest *request=[WBSendMessageToWeiboRequest requestWithMessage:[self messageToshare] authInfo:authRequest access_token:myDelegate.wbtoken];
        
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",@"Other_Info_1": [NSNumber numberWithInt:123], @"Other_Info_2": @[@"obj1", @"obj2"],@"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        [WeiboSDK sendRequest:request];
      
   
}

- (WBMessageObject *)messageToshare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"Hello,我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人";
    return message;
}



#pragma mark ——分享到微信好友；


-(void)loginWXFAction{
    
    //    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //
    //    //取消授权
    //    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
    
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人";
    req.bText = YES;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
    
    
}

#pragma mark ——分享到微信朋友圈；

//-(void)loginWXAction{
//    
//    WXMediaMessage *message = [WXMediaMessage message];
////    [message setThumbImage:[UIImage imageNamed:@""]];
//    [message setTitle:@"味美佳肴，你值得拥有"];
//    
////    WXImageObject *ext = [WXImageObject object];
//    WXEmoticonObject *ext = [WXEmoticonObject object];
//    
////    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@".gif"];
//    
////    ext.imageData = [NSData dataWithContentsOfFile:filePath];
//    ext.emoticonData = [NSData dataWithContentsOfFile:@"xiaoyang"];
//    
//    
////    UIImage* image = [UIImage imageWithData:ext.imageData];
////    ext.imageData = UIImagePNGRepresentation(image);
////    
//    
//    message.mediaObject = ext;
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    
//    //朋友圈
//    req.scene =WXSceneTimeline;
//    
//    [WXApi sendReq:req];
//
//    
//    
//    
//    
//}
//


//-(void)loginQQAction:(UIButton *)btn{
//    
//    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    //取消授权
//    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
//    
//    
//    SendMessageToWXReq* request = [[SendMessageToWXReq alloc] init];
//    request.text = @"Hello, 我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人";
//    request.bText = YES;
//    request.scene = WXSceneSession;
//    
//    [WXApi sendReq:request];
//    
//}


//朋友圈
-(void)loginWXAction{
    
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@""]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"001" ofType:@".jpg"];
    
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    
    //朋友圈
    req.scene =WXSceneTimeline;
    
    [WXApi sendReq:req];

}

#pragma mark----------- qq  分享

-(void)loginQQAction{
    
    //登录授权；
    //    NSArray* permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,kOPEN_PERMISSION_ADD_SHARE,nil];
    
    //查询结果；
    //    TencentOAuth *auth = [[TencentOAuth alloc] initWithAppId:kWXAppID andDelegate:self];
    //
    //    NSString *utf8String = @"最有价值的分享";
    //
    //    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:utf8String ? : @"Hello, 我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人"];
    //    [txtObj setCflag:0];
    //
    //    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    
    
    //官方解释；
    //开发者分享的文本内容
    
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:@"Hello, 我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人"];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    //将内容分享到qq
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    //    [sent [NSURL ]]
    
    YiralLog(@"%d",sent);
    

    


}


//  QQ第三方登录所用到的后台方法。。。。


/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    [self arteViewShow:@"恭喜您，登录成功"];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    
    [self arteViewShow:@"登录出现问题，请重新登录"];
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    
//    [self art];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)arteViewShow:(NSString *)art{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:art preferredStyle:UIAlertControllerStyleAlert];
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
