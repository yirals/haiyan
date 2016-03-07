//
//  store.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//


#ifndef store_h
#define store_h


//界面宽高宏定义
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

//首页网址；
#define mainNetworkFirst @"http://api.2meiwei.com/v1/collect/29973/?idx="
//http://api.2meiwei.com/v1/collect/29973/?idx=1&size=10
//http://api.2meiwei.com/v1/collect/29973/?idx=2&size=10

//拼接网址；

//#define main @"http://api.2meiwei.com/v1/recipe/"
//#define special @"/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511"

//首页转接网页
#define mainNetWorkSecond @"http://api.2meiwei.com/v1/recipe/22981/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511"

//http://api.2meiwei.com/v1/collect/list/?type=5&idx=5&size=10&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511

//http://api.2meiwei.com/v1/collect/list/?type=5&idx=1&size=10&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511

//专题首页
#define specialNetWorkFirst @"http://api.2meiwei.com/v1/collect/list/?type=5&idx=1&size=10&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511"

#define backgroungColor [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.5]

//http://api.2meiwei.com/v1/collect/list/?type=5&idx=5&size=10&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511



//专题转接页面

#define specialNetWorkSecond @"http://api.2meiwei.com/v1/collect/2882487/?idx=1&size=15&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511"

//专题再次转接页面

#define specialNetWorkingThird @"http://api.2meiwei.com/v1/recipe/100144&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511"
///100144&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511"

//http://api.2meiwei.com/v1/recipe/22981/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511

//http://api.2meiwei.com/v1/recipe/100144/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511

//统一输出结构
#	define YiralLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define YiralLog(...)





#endif /* store_h */
