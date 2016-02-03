//
//  FJQuestionListViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/3.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJQuestionListViewController.h"

@interface FJQuestionListViewController ()

@property (nonatomic, strong) NSMutableArray *questionArray;
@property (nonatomic, strong) UIScrollView *helpScrView;
@property (nonatomic, strong) UIPageControl *pageCtrl;

@end

@implementation FJQuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _questionArray = [[NSMutableArray alloc] initWithCapacity:4];
    [_questionArray addObject:@"\t1. [单择题] 下面哪些不是Thread类的方法"];
    [_questionArray addObject:@"\t2. [单择题] 下面关于java.lang.Exception类的说法正确的是"];
    [_questionArray addObject:@"\t3. [单择题] 下列说法正确的是"];
    [_questionArray addObject:@"\t4. [单择题] +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"];
    NSInteger pageCount = _questionArray.count;
    CGRect bounds = self.view.frame;  //获取界面区域
    
    //创建UIScrollView
    _helpScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 300)];  //创建UIScrollView，位置大小与主界面一样。
    [_helpScrView setContentSize:CGSizeMake(bounds.size.width * pageCount, 100)];  //设置全部内容的尺寸，这里帮助图片是3张，所以宽度设为界面宽度*3，高度和界面一致。
    _helpScrView.pagingEnabled = YES;  //设为YES时，会按页滑动
    _helpScrView.bounces = NO; //取消UIScrollView的弹性属性，这个可以按个人喜好来定
    [_helpScrView setDelegate:self];//UIScrollView的delegate函数在本类中定义
    _helpScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    
    //加载蒙板图片，限于篇幅，这里仅显示一张图片的加载方法
    for (NSInteger i=0; i<_questionArray.count; i++) {
        CGFloat screenWidth = bounds.size.width;
        //创建UIImageView，位置大小与主界面一样。
        UILabel *questionView = [[UILabel alloc] initWithFrame:CGRectMake(bounds.origin.x + screenWidth*i,
            bounds.origin.y - 60,
            bounds.size.width,
            bounds.size.height - 400)];
        questionView.text = _questionArray[i];
        questionView.textAlignment = NSTextAlignmentLeft;
        questionView.numberOfLines = 0;
        
        [_helpScrView addSubview:questionView];//将UIImageView添加到UIScrollView中。
    }
    [self.view addSubview:_helpScrView]; //将UIScrollView添加到主界面上。
    
    //创建UIPageControl
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, bounds.size.width, 300)];  //创建UIPageControl，位置在屏幕最下方。
    _pageCtrl.numberOfPages = pageCount;    //总的图片页数
    _pageCtrl.currentPage = 0;  //当前页
    //用户点击UIPageControl的响应函数
    [_pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    //将UIPageControl添加到主界面上。
    [self.view addSubview:_pageCtrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageTurn:(UIPageControl *)sender {
    // TODO 并没有被调用
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = _helpScrView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    NSLog(@"pageTurn");
    NSLog(@"%f", rect.origin.x);
    [_helpScrView scrollRectToVisible:rect animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageCtrl setCurrentPage:offset.x / bounds.size.width];
    NSLog(@"scrollViewDidEndDecelerating");
    NSLog(@"%f",offset.x / bounds.size.width);
}

@end
