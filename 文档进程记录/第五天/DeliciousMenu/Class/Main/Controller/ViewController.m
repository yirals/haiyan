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
#import "PullingRefreshTableView.h"
#import "store.h"

static NSString *Identifier = @"Identifier";


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//collection

{
    NSInteger _page;
}



@property(nonatomic, strong) UICollectionView *collectionView;
//@property(nonatomic, strong) UICollectionViewCell *cell;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
//    self.navigationController.
    _page = 1;
    
    
    self.view.backgroundColor = backgroungColor;
    [self.view addSubview:self.collectionView];
    [self updateConfig];
}




#pragma mark -----------数据加载
-(void)updateConfig{
    
    NSString *url = @"http://api.2meiwei.com/v1/collect/29973/?idx=";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"%@%lu&size=10",url,_page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
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

//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"show" bundle:nil];
// 
//    ShowViewController *showVC = [sb instantiateViewControllerWithIdentifier:@"showSB"];
    ShowViewController *showVC = [[ShowViewController alloc] init];
    NSLog(@"%@ %ld",self.listArray[indexPath.row], indexPath.row);
    showVC.strID = self.listArray[indexPath.row][@"id"];
    
 
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

#pragma mark------------上拉刷新，下来加载方法；
//下拉刷新开始时调用
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self.collectionView collectionViewLayout];
//
//}

//手指开始拖动方法；
/*-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 [self.collectionView tableViewDidScroll:scrollView];
 
 }
 //下拉刷新开始时调用
 -(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 [self.tableView tableViewDidEndDragging:scrollView];
 
 }
 
 //开始刷新的时候掉用；
 -(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
 _page = 1;
 self.refreshing = YES;
 [self performSelector:@selector(Chooserquest) withObject:nil afterDelay:1.0];
 
 }
 
 //上拉加载开始调用
 -(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
 _page += 1;
 self.refreshing = NO;
 [self performSelector:@selector(Chooserquest) withObject:nil afterDelay:1.0];
 
 }
 
 //刷新完成时间
 - (NSDate *)pullingTableViewRefreshingFinishedDate{
 //创建一个NSDataFormatter显示刷新时间
 return [HWTools getSystemNowDay];
 }*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
