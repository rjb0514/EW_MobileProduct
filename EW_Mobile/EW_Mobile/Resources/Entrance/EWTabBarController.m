//
//  EWTabBarController.m
//  EW_Mobile
//
//  Created by ru on 2017/6/12.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import "EWTabBarController.h"
#import "EWBaseNavViewController.h"

//底部四个控制器
#import "EWHomeViewController.h"
#import "EWTheoryViewController.h"
#import "EWShareViewController.h"
#import "EWMoreViewController.h"


@interface EWTabBarController ()

@end

@implementation EWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    //设置属性
    [self setupChildViewControllersAttributes];
    //设置子视图
    [self setupChiledsViewControllers];
    
    
}

#pragma mark - 设置子视图
- (void)setupChiledsViewControllers {
    
    //首页
    EWHomeViewController *firstVC = [[EWHomeViewController alloc] init];
    EWBaseNavViewController *firstNav = [[EWBaseNavViewController alloc] initWithRootViewController:firstVC];
    
    //基本知识
    EWTheoryViewController *secondVC = [[EWTheoryViewController alloc] init];
    EWBaseNavViewController *secondNav = [[EWBaseNavViewController alloc] initWithRootViewController:secondVC];
    
    //友盟分享
    EWShareViewController *thirdVC = [[EWShareViewController alloc] init];
    EWBaseNavViewController *thirdNav = [[EWBaseNavViewController alloc] initWithRootViewController:thirdVC];
    
    //更多
    EWMoreViewController *fourthVC = [[EWMoreViewController alloc] init];
    EWBaseNavViewController *fourthNav = [[EWBaseNavViewController alloc] initWithRootViewController:fourthVC];
    
    
    self.viewControllers = @[firstNav,secondNav,thirdNav,fourthNav];
    
    //设置属性数组
    
}

- (void)setupChildViewControllersAttributes {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_normal",
                                                 CYLTabBarItemSelectedImage : @"home_highlight",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"基础",
                                                  CYLTabBarItemImage : @"mycity_normal",
                                                  CYLTabBarItemSelectedImage : @"mycity_highlight",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"服务",
                                                 CYLTabBarItemImage : @"message_normal",
                                                 CYLTabBarItemSelectedImage : @"message_highlight",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"更多",
                                                  CYLTabBarItemImage : @"account_normal",
                                                  CYLTabBarItemSelectedImage : @"account_highlight"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
 
    
    self.tabBarItemsAttributes = tabBarItemsAttributes;
}



@end
