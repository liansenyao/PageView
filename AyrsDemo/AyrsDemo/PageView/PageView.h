//
//  PageView.h
//  AyrsDemo
//
//  Created by Senyao Lian on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ItemClickBlock) (NSInteger pageIndex);

@interface PageView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)UIButton* leftBtn;
@property(nonatomic,strong)UIButton* rightBtn;
//当前选中的页数
@property(nonatomic,assign)int currentPage;
//总页数
@property(nonatomic,assign)int count;
//下方显示的按钮总个数，默认是9
@property(nonatomic,assign)int showCount;
//前选中的页数 点击事件
@property (nonatomic, copy) ItemClickBlock itemClickBlock;
@end

NS_ASSUME_NONNULL_END
