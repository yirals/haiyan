//
//  specialSecondTableViewCell.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "specialSecondTableViewCell.h"

#import <SDWebImage/UIImageView+HighlightedWebCache.h>
@interface specialSecondTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *showImg;

@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) IBOutlet UILabel *makeLable;



@end

@implementation specialSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.frame = CGRectMake(0, 64, self.frame.size.width, 90);
}

-(void)setModel:(specialSecondModel *)model{
//    self.showImg sd_
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
