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
//#import "store.h"

static NSString *Identifier = @"Identifier";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//collection

@property(nonatomic, strong) UICollectionView *collectionView;
//@property(nonatomic, strong) UICollectionViewCell *cell;


//首页菜单名字
@property(nonatomic, strong) UILabel *nameLable;
//首页菜单展示图片；
@property(nonatomic, strong) UIImageView *showImag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
//    self.navigationController.
    [self.view addSubview:self.collectionView];
    [self updateConfig];
}

#pragma mark -----------数据加载
-(void)updateConfig{
    
    NSString *url = @"http://api.2meiwei.com/v1/collect/29973/?idx=1&size=10";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress = %@",downloadProgress);
     
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"list"];
        for (NSDictionary *dic in array) {
            
            
            [self.listArray addObject:dic];
//            NSLog(@"self.listArray = %@",self.listArray);
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
}


#pragma mark -----------dataScore/delegate
//cell个数；
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
//    return 10;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}



//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowViewController *showVC = [[ShowViewController alloc] init];
    
    [self.navigationController popToViewController:showVC animated:YES];
    
    
}

//设置cell；
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    //
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height*9/10, cell.frame.size.width, cell.frame.size.height/9)];
    self.nameLable.backgroundColor = [UIColor orangeColor];
//    self.nameLable.text = @"你大爷";
//    [cell.contentView addSubview:self.nameLable];
    
    
    if (indexPath.row < self.listArray.count) {
        self.nameLable.text = self.listArray[indexPath.row][@"title"];
    }
    
    self.showImag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height*9/10)];
    self.showImag.backgroundColor = [UIColor blackColor];
//    NSURL *urls = self.listArray[indexPath.row][@"cover"];
//    self.showImag = [UIImage imageNamed:self.listArray[indexPath.row][@"cover"]];
//    [self.showImag sd_setImageWithURL:urls placeholderImage:nil];
    
    
    [cell addSubview:self.nameLable];
    [cell addSubview:self.showImag];
    
    
    
    return cell;
    
}

#pragma mark-------------collectionView懒加载
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        //垂直显示；
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        [flowLayOut setItemSize:CGSizeMake(182, self.view.frame.size.height/3)];
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
        
        
        
        self.collectionView.backgroundColor = [UIColor cyanColor];
        
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

//-(UILabel *)nameLable{
//    if (_nameLable == nil) {
//        self.nameLable = [[UILabel alloc] init];
//    }
//    return _nameLable;
//}
//-(UIImageView *)showImag{
//    if (_showImag == nil) {
//        self.showImag = [[UIImageView alloc] init];
//    }
//    return _showImag;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
