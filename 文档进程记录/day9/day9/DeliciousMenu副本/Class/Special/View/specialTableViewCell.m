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
//@property (strong, nonatomic) IBOutlet UIImageView *showImageView;


@property (strong, nonatomic) IBOutlet UILabel *titleLable;


@property (strong, nonatomic) IBOutlet UILabel *referralLable;


@end

@implementation specialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(specialModel *)model{
    

    
    self.titleLable.text = model.nameLable;
    self.referralLable.text = model.makeLable;
    
//    CGFloat heaght = [[self class]getTextHeightWithText:model.makeLable];
//    CGRect frame = self.referralLable.frame;
//    frame.size.height = heaght;
//    self.referralLable.frame = frame;
    
    
//    CGFloat heaghg = [[self class]getTextHeightWithText:model.nameLable];
//    CGRect frame1 = self.titleLable.frame;
//    frame.size.height = heaghg;
//    self.titleLable.frame = frame1;
//    
    

    
}


//+(CGFloat)getHightForRowModel:(specialModel *)model{
//    
//    CGFloat textHeight = [[self class] getTextHeightWithText:model.makeLable];
//    
////    CGFloat tehi = [[self class] getTextHeightWithText:model.nameLable];
//    
//    return textHeight;
//    
//}

//+ (CGFloat)getTextHeightWithText:(NSString *)introl{
//    
//    CGRect rect = [introl boundingRectWithSize:CGSizeMake(kWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
//    
//    return rect.size.height;
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

}




@end
