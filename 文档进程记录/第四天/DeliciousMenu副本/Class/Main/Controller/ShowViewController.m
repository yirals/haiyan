//
//  ShowViewController.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ShowViewController.h"
#import "showTableViewCell.h"

static NSString *identifier = @"identifier";


@interface ShowViewController ()<UITableViewDelegate,UITableViewDataSource>
//展示图片

@property(nonatomic, strong) UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIView *showView;


@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabBarController.title = @"详情";
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:235/255.0];
    
//    [self configTableViewHeadView];
    self.tableview.tableHeaderView = self.showView;

    [self.view addSubview:self.tableview];
    
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"showTableViewcell" bundle:nil] forCellReuseIdentifier:identifier];
    //
    
    
    
}
#pragma mare------------tableView自定义头部；
//-(void)configTableViewHeadView{
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, self.view.frame.size.width)];
//    
////    self.tableview.tableHeaderView = headView ;
//    
//    
//}

#pragma mark-----------delegate,detaScore

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    showTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[showTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        
//    }
    
    return cell;

}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 90;
//}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, self.view.frame.size.width)];
//    
//    return headView;
//    
//}



#pragma mark-----------懒加载

-(UITableView *)tableview{
    if (_tableview == nil) {
        self.tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        self.tableview.frame = CGRectMake(0, 260, self.view.frame.size.width, 90);
        

        
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        
        
    }
    
    return _tableview;
    
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
