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
    self.aboutLable.text = @"\t\t\t IT面试宝典\n\n\t 作者：SHAOMING LIU\n\t 版本：1.0\n\t XXXX信息技术有限公司产品.";
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
