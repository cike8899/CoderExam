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

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenX;
@property (nonatomic, assign) CGFloat screenY;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self addQuestionContentPager];
//    [self addQuestionAnswerPager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData {
    CGRect bounds = self.view.frame;  //获取界面区域
    self.screenX = bounds.origin.x;
    self.screenY = bounds.origin.y;
    self.screenWidth = bounds.size.width;
    self.screenHeight = bounds.size.height;
    [self printRectInfo:bounds];
    
    if (self.questionAnswerArray == nil) {
        self.questionAnswerArray = [NSMutableArray arrayWithCapacity:50];
        for (int i = 0; i < 10; i++) {
            self.questionAnswerArray[i] = [NSNumber numberWithInt:99];
        }
    }
}

//- (void)pageTurn:(UIPageControl *)sender {
//    // TODO 并没有被调用
//    //令UIScrollView做出相应的滑动显示
//    CGSize viewSize = _helpContentScrView.frame.size;
//    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
//    NSLog(@"pageTurn--------------------");
//    NSLog(@"%f", rect.origin.x);
//    [_helpContentScrView scrollRectToVisible:rect animated:YES];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    if (scrollView.tag == CONTENT_SCROLL_VIEW_TAG)
        [_contentPageCtrl setCurrentPage:offset.x / bounds.size.width];
        
    NSLog(@"scrollViewDidEndDecelerating");
    NSLog(@"%f",offset.x / bounds.size.width);
}

- (void)addQuestionContentPager {
    [self questionContentArray];
    NSInteger pageCount = _questionContentArray.count;
    
    //创建UIScrollView
    _helpContentScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.screenX,
        self.screenY + 65,
        self.screenWidth,
        self.screenHeight)];  //创建UIScrollView，位置大小与主界面一样。
//    _helpContentScrView.backgroundColor = [UIColor redColor];
    _helpContentScrView.tag = CONTENT_SCROLL_VIEW_TAG;
    [_helpContentScrView setContentSize:CGSizeMake(self.screenWidth * pageCount, self.screenHeight)];  //设置全部内容的尺寸
    _helpContentScrView.pagingEnabled = YES;  //设为YES时，会按页滑动
    _helpContentScrView.bounces = NO; //取消UIScrollView的弹性属性，这个可以按个人喜好来定
    [_helpContentScrView setDelegate:self];//UIScrollView的delegate函数在本类中定义
    _helpContentScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    
    //加载蒙板图片，限于篇幅，这里仅显示一张图片的加载方法
    for (NSInteger i=0; i<_questionContentArray.count; i++) {
        //创建UIImageView，位置大小与主界面一样。
        UILabel *questionView = [[UILabel alloc] initWithFrame:CGRectMake(self.screenX + self.screenWidth * i,
            self.screenY - 0.1 * self.screenHeight,
            self.screenWidth,
            0.5 * self.screenHeight)];
        questionView.text = _questionContentArray[i];
        questionView.textAlignment = NSTextAlignmentLeft;
        questionView.numberOfLines = 0;
        questionView.backgroundColor = [UIColor greenColor];
        
        [_helpContentScrView addSubview:questionView];//将UIImageView添加到UIScrollView中。
        
        //
        [self AddRadioButton:(int)i];
    }
    [self.view addSubview:_helpContentScrView]; //将UIScrollView添加到主界面上。
    
    //创建UIPageControl
    _contentPageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.screenHeight, self.screenWidth, 0.16 * self.screenHeight)];  //创建UIPageControl，位置在屏幕最下方。
    _contentPageCtrl.numberOfPages = pageCount;    //总的图片页数
    _contentPageCtrl.currentPage = 0;  //当前页
    //用户点击UIPageControl的响应函数
//    [_contentPageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    //将UIPageControl添加到主界面上。
    [self.view addSubview:_contentPageCtrl];
}

- (void)printRectInfo:(CGRect)rect {
    NSLog(@"rect,x:%f", rect.origin.x);
    NSLog(@"rect,y:%f", rect.origin.y);
    NSLog(@"rect,width:%f", rect.size.width);
    NSLog(@"rect,height:%f", rect.size.height);
}

- (void)AddRadioButton:(int)pageIndex {
    NSString *groupIdVar = [NSString stringWithFormat:@"group%d",pageIndex];

    //初始化单选按钮控件
    LSMRadioButton *rb1 = [[LSMRadioButton alloc] initWithGroupId:groupIdVar index:0];
    LSMRadioButton *rb2 = [[LSMRadioButton alloc] initWithGroupId:groupIdVar index:1];
    LSMRadioButton *rb3 = [[LSMRadioButton alloc] initWithGroupId:groupIdVar index:2];
    //设置Frame
    float originYOfAnswer = 0.4 * self.screenHeight;
    rb1.frame = CGRectMake(10 + pageIndex * self.screenWidth, originYOfAnswer + 30, 22, 22);
    rb2.frame = CGRectMake(10 + pageIndex * self.screenWidth, originYOfAnswer + 60, 22, 22);
    rb3.frame = CGRectMake(10 + pageIndex * self.screenWidth, originYOfAnswer + 90, 22, 22);
    //添加到视图容器
    [_helpContentScrView addSubview:rb1];
    [_helpContentScrView addSubview:rb2];
    [_helpContentScrView addSubview:rb3];
    
    //初始化第一个单选按钮的UILabel
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(40 + pageIndex * self.screenWidth, originYOfAnswer + 30, 60, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"Red";
    [_helpContentScrView addSubview:label1];
    //    [label1 release];
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(40 + pageIndex * self.screenWidth, originYOfAnswer + 60, 60, 20)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"Green";
    [_helpContentScrView addSubview:label2];
    
    UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(40 + pageIndex * self.screenWidth, originYOfAnswer + 90, 60, 20)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"Blue";
    [_helpContentScrView addSubview:label3];
    
    //按照GroupId添加观察者
    [LSMRadioButton addObserverForGroupId:groupIdVar observer:self];
}

//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId {
    int pageIndex = [groupId substringFromIndex:5].intValue;
    self.questionAnswerArray[pageIndex] = [NSNumber numberWithInteger:index];
    NSLog(@"Answer at page-%d- changed to %d", pageIndex, (uint)index);
    
    NSLog(@"------Answer result----%@", self.questionAnswerArray);
}

@end
