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

@interface MainViewController ()<UIApplicationDelegate,WBHttpRequestDelegate>


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
    wbfinish.frame = CGRectMake(kWidth/8, kHeight/2, kWidth/4, 45);
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
    QQfinish.frame = CGRectMake(kWidth/2, kHeight/2, kWidth/4, 45);
    
    [QQfinish addTarget:self action:@selector(loginQQAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *qq = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    
    qq.image = [UIImage imageNamed:@"485c77cc7"];
    [QQfinish setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    QQfinish.tag = 1;
    
    [QQfinish addSubview:qq];
    UILabel *qqlable = [[UILabel alloc] initWithFrame:CGRectMake(45,0, QQfinish.frame.size.width*3/4, 45)];
    qqlable.text = @"QQ登录";
    qqlable.tintColor = [UIColor grayColor];
    [QQfinish addSubview:qqlable];
    [self.view addSubview:QQfinish];



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

//微博分享的实现方法；

-(void)shareAction{
    
   
        
        AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
        authRequest.scope = @"all";
        
        
        WBSendMessageToWeiboRequest *request=[WBSendMessageToWeiboRequest requestWithMessage:[self messageToshare] authInfo:authRequest access_token:myDelegate.wbtoken];
        
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        [WeiboSDK sendRequest:request];
      
   
}

- (WBMessageObject *)messageToshare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"Hello,我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人";
    return message;
}



#pragma mark ——微信分享——
-(void)loginQQAction:(UIButton *)btn{
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //取消授权
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
    
    
    SendMessageToWXReq* request = [[SendMessageToWXReq alloc] init];
    request.text = @"Hello, 我正在应用一个关于居家做味美佳肴的手机APP，在这里，不管你有没有基础，有没有做菜天赋，都可以成为居家好女人";
    request.bText = YES;
    request.scene = WXSceneSession;
    
    [WXApi sendReq:request];
    
}


//朋友圈
//-(void)friendAction{
//    
//    
//    
//    WXMediaMessage *message = [WXMediaMessage message];
//    [message setThumbImage:[UIImage imageNamed:@""]];
//    
//    WXImageObject *ext = [WXImageObject object];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6" ofType:@".gif"];
//    
//    ext.imageData = [NSData dataWithContentsOfFile:filePath];
//    
//    
//    UIImage* image = [UIImage imageWithData:ext.imageData];
//    ext.imageData = UIImagePNGRepresentation(image);
//    
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
//}

//-(void)loginQQAction{
//    
//    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    //取消授权
//    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
//    
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
//    req.bText = YES;
//    req.scene = WXSceneSession;
//    
//    [WXApi sendReq:req];
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
