//
//  SpecialViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "SpecialViewController.h"
#import "specialTableViewCell.h"
#import "specialSecondViewController.h"
#import "PullingRefreshTableView.h"
#import "specialModel.h"

#import "ZMYNetManager.h"

#import "HWTools.h"
//网络请求插件
#import <AFNetworking/AFHTTPSessionManager.h>
#import "store.h"
//static NSString *identifier = @"identifier";

@interface SpecialViewController ()<UITableViewDelegate,UITableViewDataSource,PullingRefreshTableViewDelegate>

{
    NSInteger _page;
}
@property(nonatomic, assign) BOOL refreshing;

@property(nonatomic, strong) PullingRefreshTableView *tableView;

//@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *listArray;

@property(nonatomic, strong) UIView *imageVC;

//@property(nonatomic, strong) specialModel *model;

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 1;
    
    self.title = @"专题";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"specialTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableHeaderView = self.imageVC;
    
    [self.view addSubview:self.tableView];
    //上拉刷新下拉加载；
    [self.tableView launchRefreshing];
    
    [self requestData];
}

#pragma mark------------数据请求；
-(void)requestData{
    //判断是否有网
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

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[NSString stringWithFormat:@"%@%lu",specialNetWorkFirst,(long)_page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [ProgressHUD show:@"正在加载"];
//        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"list"];
        
        if (self.refreshing) {
            //下拉刷新的时候需要移除数组中的元素；
            if (self.listArray.count > 0) {
                [self.listArray removeAllObjects];
            }
        }

        
        
        for (NSDictionary *dic in array) {
            specialModel *model = [[specialModel alloc] initWithModel:dic];
//            YiralLog(@"%@",dic);
            [self.listArray addObject:model];
        }
        
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];

        
        [ProgressHUD showSuccess:@"已成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    
    
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
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.0];
    
}

//上拉加载开始调用
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _page += 1;
    self.refreshing = NO;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.0];
    
}

//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    //创建一个NSDataFormatter显示刷新时间
    return [TimeTools getNowDate];
}



#pragma mark----------tableView,delegate,dataScore
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    specialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.model = self.listArray[indexPath.row];
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    specialModel *model = self.listArray[indexPath.row];
    
    specialSecondViewController *secondVC = [[specialSecondViewController alloc] init];
    
    secondVC.IDStr = model.SecondID;
    secondVC.nameTitle = model.nameLable;
        

    
    
    [self.navigationController pushViewController:secondVC animated:YES];
    
    
    
}


#pragma mark----------懒加载

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight- 64) pullingDelegate:self];
        
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

-(UIView *)imageVC{
    if (_imageVC == nil) {
        
        self.imageVC = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight*2/5)];
        UIImageView *imageC = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight*2/5)];
        self.imageVC.backgroundColor = [UIColor redColor];
        imageC.image = [UIImage imageNamed:@"2e1b885ae30c6529b4049144ab387ec2"];
        [_imageVC addSubview:imageC];
        
        
    }
    return _imageVC;
    
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
