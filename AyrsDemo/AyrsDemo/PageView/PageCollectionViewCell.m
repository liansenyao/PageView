//
//  PageCollectionViewCell.m
//  AyrsDemo
//
//  Created by Senyao Lian on 2022/8/17.
//

#import "PageCollectionViewCell.h"

@implementation PageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews{
    
    self.pageNumLabel = [[UILabel alloc] init];
    self.pageNumLabel.frame = CGRectMake(0, 0, 50, 50);
    self.pageNumLabel.text = @"1";
    self.pageNumLabel.layer.cornerRadius = 25;
    self.pageNumLabel.backgroundColor = UIColor.lightGrayColor;
    self.pageNumLabel.textAlignment = NSTextAlignmentCenter;
    self.pageNumLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.pageNumLabel];
}

-(void)setModel:(PageNumModel *)model
{
    _model = model;
    if (!model.isOmit) {
        
        self.pageNumLabel.text = model.page;
    } else {
        self.pageNumLabel.text = @"..";
    }
    
    
    if (model.isSelect) {
        self.pageNumLabel.backgroundColor = UIColor.purpleColor;
    } else {
        self.pageNumLabel.backgroundColor = UIColor.lightGrayColor;
    }
    
}


@end
