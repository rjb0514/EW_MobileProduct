//
//  EWBaseViewController.m
//  EW_Mobile
//
//  Created by ru on 2017/6/12.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import "EWBaseViewController.h"

@interface EWBaseViewController ()

@end

@implementation EWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
}


@end
