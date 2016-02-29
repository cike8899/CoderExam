//
//  FJQuestionListViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/3.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJQuestionListViewController.h"
#import "RadioBox.h"
#import "RadioGroup.h"
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

// RadioBox
@property (nonatomic, strong) NSMutableArray *radioGroupArray;

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
    [self addScoreBtn];
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
        for (int i = 0; i < 50; i++) {
            self.questionAnswerArray[i] = [NSNumber numberWithInt:99];
        }
    }
    
    if (self.radioGroupArray == nil) {
        self.radioGroupArray = [NSMutableArray arrayWithCapacity:50];
        for (int i = 0; i < 50; i++) {

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
        self.screenY + 65.0,
        self.screenWidth,
        self.screenHeight - 40.0)];  //创建UIScrollView，位置大小与主界面一样。
    _helpContentScrView.backgroundColor = [UIColor redColor];
    _helpContentScrView.tag = CONTENT_SCROLL_VIEW_TAG;
    // setContentSize:CGSizeMake(xLength, 0), 以禁用UIScrollView在垂直方向的滚动.
    [_helpContentScrView setContentSize:CGSizeMake(self.screenWidth * pageCount, 0)];  //设置全部内容的尺寸
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
    float originYOfAnswer = 0.4 * self.screenHeight;
    
    //代码实现
    RadioBox *radiobox0 = [[RadioBox alloc] initWithFrame:CGRectMake(12, 10, 100, 10)];
    RadioBox *radiobox1 = [[RadioBox alloc] initWithFrame:CGRectMake(12, 50, 100, 10)];
    RadioBox *radiobox2 = [[RadioBox alloc] initWithFrame:CGRectMake(12, 90, 100, 10)];
    RadioBox *radiobox3 = [[RadioBox alloc] initWithFrame:CGRectMake(12, 130, 100, 10)];
    
    radiobox0.text = @"选项一";
    radiobox1.text = @"选项二";
    radiobox2.text = @"选项三";
    radiobox3.text = @"选项四";
    
    radiobox0.value = 0;
    radiobox1.value = 1;
    radiobox2.value = 2;
    radiobox3.value = 3;
    
    NSArray *controls = [NSArray arrayWithObjects:radiobox0,
                     radiobox1,
                     radiobox2,
                     radiobox3,
                     nil];
    
    RadioGroup * radioGroup = [[RadioGroup alloc] initWithFrame:CGRectMake(self.screenX + pageIndex * self.screenWidth, originYOfAnswer, 0.8 * self.screenWidth, 162) WithControl:controls];
    
    [radioGroup addSubview:radiobox0];
    [radioGroup addSubview:radiobox1];
    [radioGroup addSubview:radiobox2];
    [radioGroup addSubview:radiobox3];
    
    radioGroup.backgroundColor = [UIColor cyanColor];
    radioGroup.textFont = [UIFont systemFontOfSize:14.0];
    //    radioGroup1.selectValue = 2;
    
    //    self.radioGroup1 = radioGroup1;
    self.radioGroupArray[pageIndex] = controls;
    [self.helpContentScrView addSubview:radioGroup];
}

- (void)addScoreBtn {
    CGFloat scoreBtnY = self.screenHeight + 30.0;
    UIButton *scoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, scoreBtnY, 32, 20)];
    scoreBtn.backgroundColor = [UIColor magentaColor];
    
    [scoreBtn setTitle:@"得分" forState:UIControlStateNormal];
    scoreBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [scoreBtn addTarget:self action:(@selector(onScoreBtnClick)) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreBtn];
}

- (void)onScoreBtnClick {
    for (int i = 0; i < self.questionContentArray.count; i++) {
        NSLog(@"Answer of %dth question is: %ld", i
              , [self getValueOfRadioGroup:self.radioGroupArray[i]]);
    }
}

- (NSInteger)getValueOfRadioGroup:(NSArray *)group {
    for (int i = 0; i < group.count; i++) {
        RadioBox *box = group[i];
        if (box.isOn) {
            return i;
        }
    }
    // NSIntegerMax表示这个RadioGroup未被选择过。
    return NSIntegerMax;
}

@end
