//
//  specialSecondViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "specialSecondViewController.h"
#import "specialSecondTableViewCell.h"
#import "UIViewController+Comment.h"
#import "specialSecondModel.h"
#import "ShowViewController.h"

#import <AFNetworking/AFHTTPSessionManager.h>


static NSString *identifier = @"identifier";
@interface specialSecondViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>

{
    NSInteger _page;
}
@property(nonatomic, assign) BOOL refreshing;
@property(nonatomic, strong) PullingRefreshTableView *tableView;

@property(nonatomic, strong) NSMutableArray *listArray;

@end

@implementation specialSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册cell;
//    self.tabBarItem.
    _page = 1;
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.5];

    
    self.title = self.nameTitle;
    [self.tableView registerNib:[UINib nibWithNibName:@"specialSecondTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self.tableView launchRefreshing];
    [self.view addSubview:self.tableView];
    [self showBackButtonWithImage:@"btn_left"];
    
    [self ConfigUpdeta];
    
    
}

#pragma mark------------数据的加载
-(void)ConfigUpdeta{
   
    
    AFHTTPSessionManager *mangaer = [AFHTTPSessionManager manager];
    mangaer.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [mangaer GET:[NSString stringWithFormat:@"http://api.2meiwei.com/v1/collect/%@/?idx=%lu&size=15&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511",self.IDStr,_page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [ProgressHUD show:@"正在加载中。。。。"];
        
        NSDictionary *dic = responseObject;

        NSArray *array = dic[@"list"];
        
        if (self.refreshing) {
            if (self.listArray.count > 0) {
                [self.listArray removeAllObjects];
            }
        }
        
        
        for (NSDictionary *dict in array) {
            specialSecondModel *model = [[specialSecondModel alloc] initWithModel:dict];
            [self.listArray addObject:model];
        }
        
        
        [ProgressHUD showSuccess:@"已完成"];
        
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    

    
}

#pragma mark----------tableView,delegate,dataScore
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    specialSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    cell.model = self.listArray[indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ShowViewController *showView = [[ShowViewController alloc] init];

    specialSecondModel *special = self.listArray[indexPath.row];
    showView.hidesBottomBarWhenPushed = YES;
    
    showView.strID = special.rid;
    
    
    [self.navigationController pushViewController:showView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    specialSecondModel *model = self.listArray[indexPath.row];
 
    CGFloat hight = [HWTools getTextHeightWithTest:model.makeLable bigestSize:CGSizeMake(190, 1000) textFound:17.0];
    
    if (hight > kHeight /5 ) {
        return hight;
    }else
        return kHeight/5;
    
    
    
    return 0;
//    return kHeight/5;
}

#pragma mark------------------上拉刷新与下拉加载
//手指开始拖动方法；
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    
}
//下拉刷新开始时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
    
}

//开始刷新的时候掉用；
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _page = 1;
    self.refreshing = YES;
    [self performSelector:@selector(ConfigUpdeta) withObject:nil afterDelay:1.0];
    
}

//上拉加载开始调用
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _page += 1;
    self.refreshing = NO;
    [self performSelector:@selector(ConfigUpdeta) withObject:nil afterDelay:1.0];
    
}

//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    //创建一个NSDataFormatter显示刷新时间
    return [TimeTools getNowDate];
}



#pragma mark----------懒加载

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
        
    }
    return _listArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [ProgressHUD dismiss];
    
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
