//
//  FJTabFindViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJTabFindViewController.h"
#import "LSMRadioButton.h"

@interface FJTabFindViewController ()

@end

@implementation FJTabFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TestRadioButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)TestRadioButton {
    [super viewDidLoad];
    
    CGRect selfBounds = self.view.bounds;
    CGFloat margingLeft = 15;
    CGFloat widthVar = selfBounds.size.width *0.58;
    //初始化视图容器
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(margingLeft, 80, widthVar, 400)];
    container.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:container]
    ;
    //初始化UILabel并添加到之前的视图容器
    UILabel *questionText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,280,20)];
    questionText.backgroundColor = [UIColor clearColor];
    questionText.text = @"Which color do you like?";
    [container addSubview:questionText];
    //初始化单选按钮控件
    LSMRadioButton *rb1 = [[LSMRadioButton alloc] initWithGroupId:@"first group" index:0];
    LSMRadioButton *rb2 = [[LSMRadioButton alloc] initWithGroupId:@"first group" index:1];
    LSMRadioButton *rb3 = [[LSMRadioButton alloc] initWithGroupId:@"first group" index:2];
    //设置Frame
    rb1.frame = CGRectMake(10,30,22,22);
    rb2.frame = CGRectMake(10,60,22,22);
    rb3.frame = CGRectMake(10,90,22,22);
    //添加到视图容器
    [container addSubview:rb1];
    [container addSubview:rb2];
    [container addSubview:rb3];
    
    //初始化第一个单选按钮的UILabel
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 30, 60, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"Red";
    [container addSubview:label1];
//    [label1 release];
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(40, 60, 60, 20)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"Green";
    [container addSubview:label2];
    
    UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(40, 90, 60, 20)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"Blue";
    [container addSubview:label3];
    
    //按照GroupId添加观察者
    [LSMRadioButton addObserverForGroupId:@"first group" observer:self];

    [super viewDidLoad];
}

//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId {
    NSLog(@"changed to %d in %@",index,groupId);
}

@end
