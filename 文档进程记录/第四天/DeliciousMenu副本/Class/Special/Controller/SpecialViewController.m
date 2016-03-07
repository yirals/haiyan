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

#import "specialModel.h"
//网络请求插件
#import <AFNetworking/AFHTTPSessionManager.h>
#import "store.h"
//static NSString *identifier = @"identifier";

@interface SpecialViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *listArray;

//@property(nonatomic, strong) specialModel *model;

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"specialTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self requestData];
}

#pragma mark------------数据请求；
-(void)requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:specialNetWorkFirst parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"list"];
        for (NSDictionary *dic in array) {
            specialModel *model = [[specialModel alloc] initWithModel:dic];
//            YiralLog(@"%@",dic);
            [self.listArray addObject:model];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    
    
}

#pragma mark----------tableView,delegate,dataScore
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    specialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    self.model = self.listArray[indexPath.row];
    
    
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

-(UITableView *)tableView{
    if (_tableView == nil) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
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
