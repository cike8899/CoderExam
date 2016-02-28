//
//  FJTabFindViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJTabFindViewController.h"
#import "RadioBox.h"
#import "RadioGroup.h"

@interface FJTabFindViewController ()

@property (nonatomic, strong) RadioGroup *radioGroup1;
@property (nonatomic, strong) NSArray *controls;

@end

@implementation FJTabFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TestRadioButton];
    [self addTestBtn];
}

- (void)addTestBtn {
    // 176, 171, 124, 226
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(176, 405, 40, 40)];
    testBtn.backgroundColor = [UIColor redColor];
    [testBtn addTarget:self action:(@selector(onBtnClick)) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
}

- (void)onBtnClick {
//    int selectValue = (int)(self.radioGroup1.selectValue);
//    NSString *selectText = (self.radioGroup1.selectText);
//    NSLog(@"selectValue: %d, selectText: %@", selectValue, selectText);
    
//    NSLog(@"---selectValue----%ld", (long)self.radioGroup1.selectValue);
//    NSLog(@"---selectText----%@", (long)self.radioGroup1.selectText);
    RadioBox *box0 = self.controls[0];
    NSLog(@"---radiobox1.isOn----%ld", (long)box0.isOn);
    NSLog(@"---radiobox1.isOn----%@", box0.text);
    NSLog(@"Selected:%ld", [self getValueOfRadioGroup:self.controls]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)TestRadioButton {
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
    
    self.controls = [NSArray arrayWithObjects:radiobox0,
                     radiobox1,
                     radiobox2,
                     radiobox3,
                     nil];
    
    RadioGroup * radioGroup1 = [[RadioGroup alloc] initWithFrame:CGRectMake(40, 160, 124, 162) WithControl:self.controls];
    
    [radioGroup1 addSubview:radiobox0];
    [radioGroup1 addSubview:radiobox1];
    [radioGroup1 addSubview:radiobox2];
    [radioGroup1 addSubview:radiobox3];
    
    radioGroup1.backgroundColor = [UIColor cyanColor];
    radioGroup1.textFont = [UIFont systemFontOfSize:14.0];
//    radioGroup1.selectValue = 2;
    
//    self.radioGroup1 = radioGroup1;
    [self.view addSubview:radioGroup1];
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
