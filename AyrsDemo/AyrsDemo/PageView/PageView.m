//
//  PageView.m
//  AyrsDemo
//
//  Created by Senyao Lian on 2022/8/18.
//

#import "PageView.h"
#import "PageCollectionViewCell.h"
#import "PageNumModel.h"
@implementation PageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame: frame];
    if(self) {
      
        [self makeUI];

        self.showCount = 9;
        self.currentPage = 1;
        self.dataSource = [NSMutableArray array];
        
    }
    return self;
}

-(void)makeUI
{
    [self addSubview:self.leftBtn];
    [self addSubview:self.collectionView];
    [self addSubview:self.rightBtn];
    self.leftBtn.hidden = YES;
}

-(void)setCount:(int)count
{
    _count = count;
    
    [self initData];
}

-(void)setShowCount:(int)showCount
{
    _showCount = showCount;
    [self initData];
}

-(void)initData
{
    int forCount = self.count > self.showCount ? self.showCount : self.count;
    
    [self updateUI:forCount];

    for (int i = 0; i < forCount; i++) {
        PageNumModel * model = [[PageNumModel alloc]init];
        if (i == 0) {
            model.page = @"1";
            model.isSelect = YES;
        } else if (i == forCount - 1) {
            model.page = [NSString stringWithFormat:@"%d", self.count];
        } else {
            model.page = [NSString stringWithFormat:@"%d", i+1];
        }
        
        model.isOmit = (i == (forCount - 2) && self.count > self.showCount) ? YES : NO;
        [self.dataSource addObject:model];
    }
    [self.collectionView reloadData];
}


-(void)updateUI:(int)forCount
{
    CGRect rect = self.frame;
    rect.size.width = 220 + forCount * 55;
    self.frame = rect;
    
    CGRect collectionRect = self.collectionView.frame;
    collectionRect.size.width = forCount * 55;
    self.collectionView.frame = collectionRect;
    
    CGRect rightRect = self.rightBtn.frame;
    rightRect.origin.x = CGRectGetMaxX(self.collectionView.frame) + 20;
    self.rightBtn.frame = rightRect;
}
#pragma mark 代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PageCollectionViewCell" forIndexPath:indexPath];
    PageNumModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PageNumModel * model = self.dataSource[indexPath.row];
    if (model.isOmit) return;
    self.currentPage = model.page.intValue;
    
    [self handleSelectPage];
    
    if (self.itemClickBlock) {
        self.itemClickBlock(self.currentPage);
    }

}


//上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}


//上一页
-(void)prePage{
    self.currentPage--;
    [self handleSelectPage];
   
}

//下一页
-(void)nextPage{
    self.currentPage++;
    [self handleSelectPage];
    
}

-(void)handleSelectPage
{
    if (self.currentPage == 1) {
        self.leftBtn.hidden = YES;
    } else {
        self.leftBtn.hidden = NO;
    }
    
    if (self.currentPage == self.count) {
        self.rightBtn.hidden = YES;
    } else {
        self.rightBtn.hidden = NO;
    }
    
    if (self.showCount%2 == 1) {
        //显示按钮个数奇数
        [self handleShowOddCount];
    } else {
        //显示按钮个数偶数
        [self handleShowEvenCount];
    }
    
    [self.collectionView reloadData];
    
}


//显示个数为奇数
-(void)handleShowOddCount
{
    //按钮中间序号
    int middle = (self.showCount+1)/2;
    
    if (self.count < self.showCount) {
        // 总个数小于显示个数
        // 设置选中状态即可 请求接口
        for (PageNumModel * pagemodel in self.dataSource) {
            if (self.currentPage == pagemodel.page.intValue && !pagemodel.isOmit) {
                pagemodel.isSelect = YES;
            } else {
                pagemodel.isSelect = NO;
            }
        }

    } else if (self.currentPage < middle) {
        // 设置选中状态即可 请求接口
        PageNumModel * secondmodel = self.dataSource[1];
        secondmodel.isOmit = NO;
        for (int i = 0; i < self.showCount-2; i++) {
            PageNumModel * tmpmodel = self.dataSource[i];
            tmpmodel.page = [NSString stringWithFormat:@"%d", i+1];
        }
    } else if (self.count - self.currentPage >= ((self.showCount-5)/2+2) && self.currentPage >= middle){
        //显示中间，两边省略号
        //第二个和倒数第二个现实省略号
        PageNumModel * secondmodel = self.dataSource[1];
        secondmodel.isOmit = YES;
        PageNumModel * secondmodel1 = self.dataSource[self.showCount-2];
        secondmodel1.isOmit = YES;

        //中间按钮个数 : 总数 - 两个省略 - 两头
        int middleNum = self.showCount - 4;
        
        NSMutableArray * middleArr = [NSMutableArray array];
        for (int i = 0; i<middleNum; i++) {
           [middleArr addObject:@(-(middleNum-1)/2 + i + self.currentPage)];
        }
        
        for (int i = 2; i < self.showCount-2; i++) {
            PageNumModel * tmpmodel = self.dataSource[i];
            tmpmodel.page = [middleArr[i - 2] stringValue];
        }
       
    }else if (self.count - self.currentPage < ((self.showCount-5)/2+2)) {
        //  1 。。显示最后7位  总数-开头1-省略
        
        //将倒数第二个省略号改为显数字
        PageNumModel * secondmodel = self.dataSource[self.showCount-2];
        secondmodel.isOmit = NO;
        for (int i = 0; i < self.showCount-2; i++) {
            PageNumModel * tmpmodel = self.dataSource[i+2];
            tmpmodel.page = [NSString stringWithFormat:@"%d", self.count - (self.showCount - 3 - i)];
        }
    }
    
    for (PageNumModel * pagemodel in self.dataSource) {
        if (self.currentPage == pagemodel.page.intValue && !pagemodel.isOmit) {
            pagemodel.isSelect = YES;
        } else {
            pagemodel.isSelect = NO;
        }
    }
}

-(void)handleShowEvenCount
{
    
}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(50, 50);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(110, 0, CGRectGetWidth(self.frame) - 220, 50) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        [_collectionView registerClass:[PageCollectionViewCell class] forCellWithReuseIdentifier:@"PageCollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _leftBtn.frame = CGRectMake(20, 0, 70, 50);
        [_leftBtn setTitle:@"上一页" forState:(UIControlStateNormal)];
        [_leftBtn addTarget:self action:@selector(prePage) forControlEvents:(UIControlEventTouchUpInside)];
        [_leftBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _rightBtn.frame = CGRectMake(CGRectGetMaxX(self.collectionView.frame)+20, 0, 70, 50);
        [_rightBtn setTitle:@"下一页" forState:(UIControlStateNormal)];
        [_rightBtn setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        [_rightBtn addTarget:self action:@selector(nextPage) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightBtn;
}

@end
