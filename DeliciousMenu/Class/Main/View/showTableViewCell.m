//
//  showTableViewCell.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "showTableViewCell.h"

@interface showTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *shouImageView;
@property (strong, nonatomic) IBOutlet UILabel *makeLable;
@property (strong, nonatomic) IBOutlet UILabel *numLable;



@end

@implementation showTableViewCell



- (void)awakeFromNib {
    // Initialization code
    self.frame = CGRectMake(0, 260, self.frame.size.width, 90);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end