//
//  showSpecialView.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "showSpecialView.h"

@interface showSpecialView ()




#define backGround [UIColor colorWithRed:180 green:180 blue:180 alpha:1.0]
#define backGround1 [UIColor colorWithRed:150 green:150 blue:150 alpha:1.0]








@end



@implementation showSpecialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}
-(void)configView{
    
    
   
    [self addSubview:self.showImage];
    [self addSubview:self.nameLable];
    [self addSubview:self.tasteLable];
    [self addSubview:self.tasteLable1];
    [self addSubview:self.waysLable];
    [self addSubview:self.waysLable1];
    [self addSubview:self.timeLable];
    [self addSubview:self.timeLable1];
    [self addSubview:self.diffLable];
    [self addSubview:self.diffLable1];


}

-(UIImageView *)showImage{
    if (_showImage == nil) {
        self.showImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kWidth*0.6)];
        self.showImage.backgroundColor = [UIColor redColor];
   
        
    }
    return _showImage;
}

-(UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth*0.6+2, kWidth, kWidth/10)];
        _nameLable.textColor = [UIColor orangeColor];
        _nameLable.backgroundColor =[UIColor whiteColor];
        
    }
    return _nameLable;
}
-(UILabel *)tasteLable{
    if (_tasteLable == nil) {
        _tasteLable = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15, kWidth*0.76, kWidth/5, kWidth/9)];
        _tasteLable.backgroundColor = backGround1;
        _tasteLable.text = @"口味";
//        _tasteLable.textAlignment = uite
//        _tasteLable.font = [UIFont fontWithName:@"Helvetica" size:15.0];
//        _tasteLable.textColor = backGround;

        _tasteLable.textAlignment=NSTextAlignmentCenter;
        
        
    }
    return _tasteLable;
}
-(UILabel *)tasteLable1{
    if (_tasteLable1 == nil) {
        _tasteLable1 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15, kWidth*0.76+kWidth/9+2, kWidth/5, kWidth/9)];
        _tasteLable1.backgroundColor = [UIColor orangeColor];
        
        
        
    }
    return _tasteLable1;
}
-(UILabel *)waysLable{
    if (_waysLable == nil) {
        _waysLable = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15+kWidth/5+2, kWidth*0.76, kWidth/5, kWidth/9)];
        _waysLable.backgroundColor = [UIColor orangeColor];
        _waysLable.textAlignment = NSTextAlignmentCenter;
        _waysLable.text = @"方式";
        
    }
    return _waysLable;
}
-(UILabel *)waysLable1{
    if (_waysLable1 == nil) {
        _waysLable1 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15+kWidth/5+2, kWidth*0.76+kWidth/9+2, kWidth/5, kWidth/9)];
        _waysLable1.backgroundColor = [UIColor orangeColor];
        
    }
    return _waysLable1;
}
-(UILabel *)timeLable{
    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15+kWidth/5*2 +4, kWidth*0.76 , kWidth/5, kWidth/9)];
        _timeLable.backgroundColor = [UIColor orangeColor];
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.text = @"时间";
        
    }
    return _timeLable;
}

-(UILabel *)timeLable1{
    if (_timeLable1 == nil) {
        _timeLable1 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15+kWidth/5*2 +4, kWidth*0.76+kWidth/9+2 , kWidth/5, kWidth/9)];
        _timeLable1.backgroundColor = [UIColor orangeColor];
        
    }
    return _timeLable1;
}

-(UILabel *)diffLable{
    if (_diffLable == nil) {
        _diffLable = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15+kWidth/5*3 +6, kWidth*0.76 , kWidth/5, kWidth/9)];
        _diffLable.backgroundColor = [UIColor orangeColor];
        _diffLable.textAlignment = NSTextAlignmentCenter;
        _diffLable.text = @"难度";
        
    }
    return _diffLable;
}
-(UILabel *)diffLable1{
    if (_diffLable1 == nil) {
        _diffLable1 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth/15 + kWidth/5*3 + 6, kWidth*0.76 +kWidth/9 +2, kWidth/5, kWidth/9)];
        _diffLable1.backgroundColor = [UIColor orangeColor];
        
    }
    return _diffLable1;
}


@end
