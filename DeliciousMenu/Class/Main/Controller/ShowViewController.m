//
//  ShowViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ShowViewController.h"
#import "showTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "showSpecialView.h"
#import "showModel.h"
#import "UIViewController+Comment.h"

static NSString *identifier = @"identifier";


@interface ShowViewController ()<UITableViewDelegate,UITableViewDataSource>
//展示图片

@property(nonatomic, strong) UITableView *tableview;

@property(nonatomic, strong) NSDictionary *dictory;

@property(nonatomic, strong) NSMutableArray *listArray;
@property (strong, nonatomic)  UIView *showView;

@property(nonatomic, strong) showSpecialView *showVC;

@property(nonatomic, strong) showModel *model;


@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.dictory[@"subject"];
//    self.title = @"rdertyiu";
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:235/255.0];
    
    [self showBackButtonWithImage:@"btn_left"];
    ;
    
    [self.showView addSubview:self.showVC];
    
    self.tableview.tableHeaderView = self.showView;

    
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"showTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    //
    [self.view addSubview:self.tableview];

    [self configUpDate];

}
#pragma mark--------------加载数据

-(void)configUpDate{
    //[NSString stringWithFormat:@"%@%@/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511",specialNetWorkingThird,self.listArray]
    
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manger GET:[NSString stringWithFormat:@"http://api.2meiwei.com/v1/recipe/%@/&appname=mw_android&appver=1.0.12&osver=5.0.2&devicename=ALE-TL00&openudid=866656021957511",self.strID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress)
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        self.dictory = responseObject;
        YiralLog(@"self.dictory === %@",self.dictory);
        NSArray *array = self.dictory[@"steps"];
        for (NSDictionary *dict in array) {
            showModel *modelShow = [[showModel alloc]initModelData:dict];
            [self.listArray addObject:modelShow];
      
        }
        
        
              [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    
    
}


#pragma mark-----------delegate,detaScore

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    showTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
    
 
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}





#pragma mark-----------懒加载

-(UITableView *)tableview{
    if (_tableview == nil) {
        
        self.tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];

     
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        
        
    }
    
    return _tableview;
    
}


-(showSpecialView *)showVC{
    if (_showVC == nil) {
        _showVC = [[showSpecialView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeight *0.7)];
        
        self.showVC.diffLable1.text = self.dictory[@"level"];
        self.showVC.timeLable1.text = self.dictory[@"during"];
        self.showVC.tasteLable1.text = self.dictory[@"cuisine"];
        self.showVC.waysLable1.text = self.dictory[@"technics"];
        
        [self.showVC.showImage sd_setImageWithURL:[NSURL URLWithString:self.dictory[@"cover"]] placeholderImage:nil];
        
    }
    return _showVC;
}

-(UIView *)showView{
    if (_showView == nil) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];

        _showView.backgroundColor = backgroungColor;
    }
    return _showView;
   
}

-(NSDictionary *)dictory{
    if (_dictory == nil) {
        self.dictory = [NSDictionary new];
    }
    return _dictory;
}

-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}

-(showModel *)model{
    if (_model == nil) {
        self.model = [[showModel alloc]init];
        
    }
    return _model;
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
