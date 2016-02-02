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
        CGFloat width = self.view.bounds.size.width - 225;
        CGRect rect = CGRectMake(self.view.bounds.origin.x,
                                 self.view.bounds.origin.y,
                                 width,
                                 self.view.bounds.size.height);
//        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        // Enable cell.accessoryType, should make rect.size.width < width of screen. Or the accessory (for example array icon) can not shown.
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        
        _tableView.rowHeight = 40.0;
//        _tableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
        // Disable bounces effects.
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"mine";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @" 账号";
            break;
        case 1:
            cell.textLabel.text = @" 设置";
            break;
            
        default:
            cell.textLabel.text = @" 关于";
            break;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    if (indexPath.row == 2) {
        FJAboutViewController *aboutController = [[FJAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutController animated:YES];
    }
}

@end
