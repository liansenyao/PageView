//
//  PageCollectionViewCell.h
//  AyrsDemo
//
//  Created by Senyao Lian on 2022/8/17.
//

#import <UIKit/UIKit.h>
#import "PageNumModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel * pageNumLabel;
@property(nonatomic,strong)PageNumModel * model;
@end

NS_ASSUME_NONNULL_END
