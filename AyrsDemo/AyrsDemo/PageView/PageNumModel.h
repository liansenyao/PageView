//
//  PageNumModel.h
//  AyrsDemo
//
//  Created by Senyao Lian on 2022/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageNumModel : NSObject
//页数
@property(nonatomic,copy)NSString * page;
//是否省略
@property(nonatomic,assign)BOOL isOmit;
//页数
@property(nonatomic,assign)BOOL isSelect;


@end

NS_ASSUME_NONNULL_END
