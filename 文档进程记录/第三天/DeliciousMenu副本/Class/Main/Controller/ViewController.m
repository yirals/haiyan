//
//  ViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ViewController.h"
#import "ShowViewController.h"
//#import "ViewCollectionCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
//#import "store.h"

static NSString *Identifier = @"Identifier";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//collection





@property(nonatomic, strong) UICollectionView *collectionView;
//@property(nonatomic, strong) UICollectionViewCell *cell;



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
            ;
            [self.imageArray addObject:dic];
            [self.collectionView reloadData];
//            NSLog(@"%lu",self.listArray.count);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
}


#pragma mark -----------dataScore/delegate

//设置cell；
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    
   UILabel *snameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height*9/10, 182, cell.frame.size.height/9)];
    snameLable.backgroundColor = [UIColor orangeColor];
    
     UIImageView *showImag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 182, cell.frame.size.height*9/10)];
//    showImag.backgroundColor = [UIColor blackColor];
//
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
//        return 10;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}



//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowViewController *showVC = [[ShowViewController alloc] init];
    
    [self.navigationController pushViewController:showVC animated:YES];
    
    
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
        
        
        
//        self.collectionView.backgroundColor = [UIColor cyanColor];
        
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
