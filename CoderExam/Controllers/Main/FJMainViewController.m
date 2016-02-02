//
//  FJMainViewController.m
//  CoderExam
//
//  Created by 刘少明 on 16/2/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJMainViewController.h"
#import "FJTabHomeViewController.h"
#import "FJTabCategoryViewController.h"
#import "FJTabFindViewController.h"
#import "FJTabMineViewController.h"
#import "FJImageUtil.h"

@interface FJMainViewController ()

@end

@implementation FJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // UI should not return back to FJStartupViewController.
    [self.navigationItem setHidesBackButton:YES];
    //
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    // Home Tab Bar
    FJTabHomeViewController *homeController = [[FJTabHomeViewController alloc] init];
    UIImage *homeImage = [UIImage imageNamed:@"ic_home"];
    homeController.tabBarItem.title = @"首页";
    UIImage *homeImageVar = [FJImageUtil scaleToSize:homeImage size:CGSizeMake(25.0f, 25.0f)];
    homeController.tabBarItem.image = homeImageVar;
    
    // Category Tab Bar
    FJTabCategoryViewController *categoryController = [[FJTabCategoryViewController alloc] init];
    UIImage *categoryImage = [UIImage imageNamed:@"ic_category"];
    UIImage *categoryImageVar = [FJImageUtil scaleToSize:categoryImage size:CGSizeMake(25.0, 25.0)];
    categoryController.tabBarItem.title = @"分类";
    categoryController.tabBarItem.image = categoryImageVar;
    
    // Find Tab Bar
    FJTabFindViewController *findController = [[FJTabFindViewController alloc] init];
    UIImage *findImage = [UIImage imageNamed:@"ic_find"];
    UIImage *findImageVar = [FJImageUtil scaleToSize:findImage size:CGSizeMake(25.0, 25.0)];
    findController.tabBarItem.title = @"发现";
    findController.tabBarItem.image = findImageVar;
    
    // Mine Tab Bar
    FJTabMineViewController *mineController = [[FJTabMineViewController alloc] init];
    UIImage *mineImage = [UIImage imageNamed:@"ic_mine"];
    UIImage *mineImageVar = [FJImageUtil scaleToSize:mineImage size:CGSizeMake(25.0, 25.0)];
    mineController.tabBarItem.title = @"我";
    mineController.tabBarItem.image = mineImageVar;
    
    // Generate Tab Menu.
    self.viewControllers = @[homeController, categoryController, findController, mineController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

