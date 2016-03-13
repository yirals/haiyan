//
//  ViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "Reachability.h"

#import "ZMYNetManager.h"

#import "ProgressHUD.h"





static NSString *Identifier = @"Identifier";


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//collection

{
    NSInteger _page;
}

@property(nonatomic, assign) BOOL isRefresh;


@property(nonatomic, strong) UICollectionView *collectionView;
//@property(nonatomic, strong) UICollectionViewCell *cell;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";

    _page = 1;
    
    
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 增加数据
        [self.collectionView.mj_header beginRefreshing];
        
        _page=1;
        
        self.isRefresh=YES;
        [self updateConfig];
        YiralLog(@"zhengzai1shuaxin");
        

        [self.collectionView.mj_header endRefreshing];
        
    }];
    
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer beginRefreshing];

        _page+=1;
        self.isRefresh=NO;
        [self updateConfig];

        // 结束刷新
        [self.collectionView.mj_footer endRefreshing];
        
        
        
    }];

    
    
    self.view.backgroundColor = backgroungColor;
    [self.view addSubview:self.collectionView];
    [self updateConfig];
}

#pragma mark -----------数据加载
-(void)updateConfig{
    
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
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
    


    
    NSString *url = @"http://api.2meiwei.com/v1/collect/29973/?idx=";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"%@%lu&size=10",url,(long)_page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress = %@",downloadProgress);
     
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [ProgressHUD show:@"正在为您加载数据"];
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"list"];
        for (NSDictionary *dic in array) {

            [self.listArray addObject:dic];
            ;
            [self.imageArray addObject:dic];
            
        }
        [self.collectionView reloadData];

        [ProgressHUD showSuccess:@"已成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
}

#pragma mark -----------dataScore/delegate

//设置cell；
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
   UILabel *snameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height*9/10, kWidth*0.485, cell.frame.size.height/9)];
    snameLable.backgroundColor = [UIColor whiteColor];
    
     UIImageView *showImag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth*0.48, cell.frame.size.height*9/10)];


    if (indexPath.row < self.listArray.count) {
        
        snameLable.text = self.listArray[indexPath.row][@"title"];
        
    }
    if (indexPath.row < self.listArray.count) {
        [showImag sd_setImageWithURL:[NSURL URLWithString:self.listArray[indexPath.row][@"cover"]] placeholderImage:nil];
    }
    [cell.contentView addSubview:snameLable];
    [cell.contentView addSubview:showImag];
    
    
    
    return cell;
    
}


//cell个数；
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.listArray.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}



//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    
    ShowViewController *showVC = [[ShowViewController alloc] init];

    
    showVC.hidesBottomBarWhenPushed = YES;
    
    showVC.strID = self.listArray[indexPath.row][@"id"];
    
 
    [self.navigationController pushViewController:showVC animated:YES];
    
    
}


#pragma mark-------------collectionView懒加载
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        //垂直显示；
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        [flowLayOut setItemSize:CGSizeMake(kWidth*0.48, self.view.frame.size.height/3)];
        //设置每一列的间距；
        flowLayOut.minimumLineSpacing = 10;
        //设置每一行的间距；
        flowLayOut.minimumInteritemSpacing = 1;
        //section的边距；
        flowLayOut.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayOut];
        
        //设置代理；
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        
        
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        //注册item类型；
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Identifier];
        
        
    }
    return _collectionView;
    
}

-(NSMutableArray *)listArray{
    
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
    
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        self.imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
