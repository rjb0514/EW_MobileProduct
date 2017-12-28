//
//  EWMoreViewController.m
//  EW_Mobile
//
//  Created by ru on 2017/6/12.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import "EWMoreViewController.h"
#import "UIColor+Gradient.h"

@interface EWMoreViewController ()

@end

@implementation EWMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"更多";
    
    self.view.backgroundColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor yellowColor] withHeight:self.view.bounds.size.height];
    
    
}




@end
