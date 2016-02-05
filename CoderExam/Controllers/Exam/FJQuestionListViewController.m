//
//  FJQuestionListViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/3.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJQuestionListViewController.h"
#define CONTENT_SCROLL_VIEW_TAG 100
#define ANSWER_SCROLL_VIEW_TAG 101

@interface FJQuestionListViewController ()

@property (nonatomic, strong) NSMutableArray *questionContentArray;
@property (nonatomic, strong) UIScrollView *helpContentScrView;
@property (nonatomic, strong) UIPageControl *contentPageCtrl;

@property (nonatomic, strong) NSMutableArray *questionAnswerArray;
@property (nonatomic, strong) UIScrollView *helpAnswerScrView;
@property (nonatomic, strong) UIPageControl *answerPageCtrl;

@end

@implementation FJQuestionListViewController

- (id)questionContentArray {
    if (_questionContentArray == nil) {
        _questionContentArray = [[NSMutableArray alloc] initWithCapacity:4];
        [_questionContentArray addObject:@"\t1. [单择题] 下面哪些不是Thread类的方法"];
        [_questionContentArray addObject:@"\t2. [单择题] 下面关于java.lang.Exception类的说法正确的是"];
        [_questionContentArray addObject:@"\t3. [单择题] 下列说法正确的是"];
        [_questionContentArray addObject:@"\t4. [单择题] +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"];
    }
    return _questionContentArray;
}

- (id)questionAnswerArray {
    if (_questionAnswerArray == nil) {
        _questionAnswerArray = [[NSMutableArray alloc] initWithCapacity:4];
        [_questionAnswerArray addObject:@"\tq1. [单择题] 下面哪些不是Thread类的方法"];
        [_questionAnswerArray addObject:@"\tq2. [单择题] 下面关于java.lang.Exception类的说法正确的是"];
        [_questionAnswerArray addObject:@"\tq3. [单择题] 下列说法正确的是"];
        [_questionAnswerArray addObject:@"\tq4. [单择题] +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"];
    }
    return _questionAnswerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addQuestionContentPager];
//    [self addQuestionAnswerPager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageTurn:(UIPageControl *)sender {
    // TODO 并没有被调用
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = _helpContentScrView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    NSLog(@"pageTurn");
    NSLog(@"%f", rect.origin.x);
    [_helpContentScrView scrollRectToVisible:rect animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    if (scrollView.tag == CONTENT_SCROLL_VIEW_TAG)
        [_contentPageCtrl setCurrentPage:offset.x / bounds.size.width];
    else if (scrollView.tag == ANSWER_SCROLL_VIEW_TAG)
        [_answerPageCtrl setCurrentPage:(- offset.x) / bounds.size.width];
        
    NSLog(@"scrollViewDidEndDecelerating");
    NSLog(@"%f",offset.x / bounds.size.width);
}

- (void)addQuestionContentPager {
    [self questionContentArray];
    NSInteger pageCount = _questionContentArray.count;
    CGRect bounds = self.view.frame;  //获取界面区域
    
    //创建UIScrollView
    _helpContentScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 300)];  //创建UIScrollView，位置大小与主界面一样。
    _helpContentScrView.tag = CONTENT_SCROLL_VIEW_TAG;
    [_helpContentScrView setContentSize:CGSizeMake(bounds.size.width * pageCount, 100)];  //设置全部内容的尺寸，这里帮助图片是3张，所以宽度设为界面宽度*3，高度和界面一致。
    _helpContentScrView.pagingEnabled = YES;  //设为YES时，会按页滑动
    _helpContentScrView.bounces = NO; //取消UIScrollView的弹性属性，这个可以按个人喜好来定
    [_helpContentScrView setDelegate:self];//UIScrollView的delegate函数在本类中定义
    _helpContentScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    
    //加载蒙板图片，限于篇幅，这里仅显示一张图片的加载方法
    for (NSInteger i=0; i<_questionContentArray.count; i++) {
        CGFloat screenWidth = bounds.size.width;
        //创建UIImageView，位置大小与主界面一样。
        UILabel *questionView = [[UILabel alloc] initWithFrame:CGRectMake(bounds.origin.x + screenWidth*i,
                                                                          bounds.origin.y - 60,
                                                                          bounds.size.width,
                                                                          bounds.size.height - 400)];
        questionView.text = _questionContentArray[i];
        questionView.textAlignment = NSTextAlignmentLeft;
        questionView.numberOfLines = 0;
//        questionView.backgroundColor = [UIColor greenColor];
        
        [_helpContentScrView addSubview:questionView];//将UIImageView添加到UIScrollView中。
    }
    [self.view addSubview:_helpContentScrView]; //将UIScrollView添加到主界面上。
    
    //创建UIPageControl
    _contentPageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, bounds.size.width, 300)];  //创建UIPageControl，位置在屏幕最下方。
    _contentPageCtrl.numberOfPages = pageCount;    //总的图片页数
    _contentPageCtrl.currentPage = 0;  //当前页
    //用户点击UIPageControl的响应函数
    [_contentPageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    //将UIPageControl添加到主界面上。
    [self.view addSubview:_contentPageCtrl];
}

- (void)addQuestionAnswerPager {
//    CGFloat answerSrcY = _helpContentScrView.frame.origin.y
//    + _helpContentScrView.frame.size.height
//    + 200;
    
    [self questionAnswerArray];
    NSInteger pageCount = _questionAnswerArray.count;
    CGRect bounds = self.view.frame;  //获取界面区域
    CGFloat answerSrcY = 300;
    CGFloat answerSrcHeight = bounds.size.height * 0.4;
    CGFloat answerHeight = bounds.size.height * 0.35;

    
    //创建UIScrollView
    _helpAnswerScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, answerSrcY, bounds.size.width, answerSrcHeight)];  //创建UIScrollView，位置大小与主界面一样。
    _helpAnswerScrView.tag = ANSWER_SCROLL_VIEW_TAG;
    [_helpContentScrView setContentSize:CGSizeMake(bounds.size.width * pageCount, 100)];  //设置全部内容的尺寸，这里帮助图片是3张，所以宽度设为界面宽度*3，高度和界面一致。
    _helpAnswerScrView.pagingEnabled = YES;  //设为YES时，会按页滑动
    _helpAnswerScrView.bounces = NO; //取消UIScrollView的弹性属性，这个可以按个人喜好来定
    [_helpAnswerScrView setDelegate:self];//UIScrollView的delegate函数在本类中定义
    _helpAnswerScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    
    //加载蒙板图片，限于篇幅，这里仅显示一张图片的加载方法
    for (NSInteger i=0; i<_questionAnswerArray.count; i++) {
        CGFloat screenWidth = bounds.size.width;
        //创建UIImageView，位置大小与主界面一样。
        UILabel *questionView = [[UILabel alloc] initWithFrame:CGRectMake(bounds.origin.x + screenWidth*i,                                                  answerSrcY,
            bounds.size.width,
            answerHeight)];
        questionView.text = _questionAnswerArray[i];
        questionView.textAlignment = NSTextAlignmentLeft;
        questionView.numberOfLines = 0;
        questionView.backgroundColor = [UIColor blueColor];
        
        [_helpAnswerScrView addSubview:questionView];//将UIImageView添加到UIScrollView中。
    }
    [self.view addSubview:_helpAnswerScrView]; //将UIScrollView添加到主界面上。
    
    //创建UIPageControl
    _answerPageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200, bounds.size.width, 200)];  //创建UIPageControl，位置在屏幕最下方。
    _answerPageCtrl.numberOfPages = pageCount;    //总的图片页数
    _answerPageCtrl.currentPage = 0;  //当前页
    //用户点击UIPageControl的响应函数
    [_answerPageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    //将UIPageControl添加到主界面上。
    [self.view addSubview:_answerPageCtrl];
}


@end
