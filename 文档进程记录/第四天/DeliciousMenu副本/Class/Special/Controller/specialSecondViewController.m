//
//  specialSecondViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "specialSecondViewController.h"
#import "specialSecondTableViewCell.h"

#import "specialSecondModel.h"

#import <AFNetworking/AFHTTPSessionManager.h>


static NSString *identifier = @"identifier";
@interface specialSecondViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *listArray;

@end

@implementation specialSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册cell;
//    self.tabBarItem.
    
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.5];

    
    self.title = self.nameTitle;
    [self.tableView registerNib:[UINib nibWithNibName:@"specialSecondTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    
    [self ConfigUpdeta];
    
    
}

#pragma mark------------数据的加载
-(void)ConfigUpdeta{
    //http://api.2meiwei.com/v1/recipe/100144/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511
    
    AFHTTPSessionManager *mangaer = [AFHTTPSessionManager manager];
    mangaer.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [mangaer GET:[NSString stringWithFormat:@"http://api.2meiwei.com/v1/collect/%@/?idx=1&size=15&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511",self.IDStr] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        YiralLog(@"dic === %@",dic);
        NSArray *array = dic[@"list"];
        for (NSDictionary *dict in array) {
            specialSecondModel *model = [[specialSecondModel alloc] initWithModel:dict];
            [self.listArray addObject:model];
            [self.tableView reloadData];
        }
        
        
        
        
//        YiralLog(@"responseObject ====== %@",responseObject);
        
        
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
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
