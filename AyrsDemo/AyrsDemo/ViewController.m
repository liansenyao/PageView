//
//  ViewController.m
//  AyrsDemo
//
//  Created by Senyao Lian on 2022/8/16.
//

#import "ViewController.h"
#import "PageView.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求接口获取到的总页数
    int pageCount = 60;
    
    PageView * pageview = [[PageView alloc] initWithFrame:CGRectMake(100, 100, 220 + 9 *55, 50)];
    pageview.showCount = 11;
    pageview.count = pageCount;
    [self.view addSubview:pageview];
    pageview.itemClickBlock = ^(NSInteger pageIndex) {
        NSLog(@"点击的第%ld页",pageIndex);
    };
    
    // Do any additional setup after loading the view.
}



@end
