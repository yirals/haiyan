//
//  specialTableViewCell.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "specialTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface specialTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *showImageView;


@property (strong, nonatomic) IBOutlet UILabel *titleLable;


@property (strong, nonatomic) IBOutlet UILabel *referralLable;


@end

@implementation specialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(specialModel *)model{
    
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.ShowImageView] placeholderImage:nil];
//    YiralLog(@"%@",model.ShowImageView);
    
    self.titleLable.text = model.nameLable;
    self.referralLable.text = model.makeLable;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    
    

    // Configure the view for the selected state
}




@end
