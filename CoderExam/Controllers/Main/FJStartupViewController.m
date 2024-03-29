//
//  FJStartupViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJStartupViewController.h"
#import "FJMainViewController.h"

@interface FJStartupViewController ()

@property (nonatomic, weak) IBOutlet UILabel *loadingLable;

@end

@implementation FJStartupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sleepForAWhile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sleepForAWhile {
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 将 任务 添加 全局队列 中去 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"---thread id: %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"---thread id: %@", [NSThread currentThread]);
            FJMainViewController *mainController = [[FJMainViewController alloc] init];
            [self.navigationController pushViewController:mainController animated:YES];
        });
    });
}

@end
