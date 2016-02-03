//
//  FJTabCategoryViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJTabCategoryViewController.h"
#import "FJQuestionListViewController.h"

@interface FJTabCategoryViewController ()

@property (nonatomic, strong) IBOutlet UIButton *javaCategoryBtn;

@end

@implementation FJTabCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onItemClick:(UIButton *)sender {
    FJQuestionListViewController *questionController = [[FJQuestionListViewController alloc] init];
    [self.navigationController pushViewController:questionController
                                         animated:YES];
}

@end
