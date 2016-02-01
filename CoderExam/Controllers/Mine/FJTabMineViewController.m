//
//  FJTabMineViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJTabMineViewController.h"
#import "FJAboutViewController.h"

@interface FJTabMineViewController ()

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray *mineArray;

@end

@implementation FJTabMineViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.rowHeight = 40.0;
//        float bottom = self.view.bounds.size.height - 110;
        _tableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
        // 取消边界弹簧效果
        _tableView.bounces = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"mine";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"关于";
//        cell.detailTextLabel.text = @"--";
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    FJAboutViewController *aboutController = [[FJAboutViewController alloc] init];
    [self.navigationController pushViewController:aboutController animated:YES];
}

@end
