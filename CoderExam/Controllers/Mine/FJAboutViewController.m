//
//  FJAboutViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/2.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJAboutViewController.h"

@interface FJAboutViewController ()

@property (nonatomic, strong) IBOutlet UILabel *aboutLable;

@end

@implementation FJAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutLable.text = @"\tIT面试宝典\n\nXXXX信息技术有限公司产品\n作者：刘少明\n版本：1.0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
