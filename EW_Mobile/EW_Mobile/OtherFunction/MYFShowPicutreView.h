//
//  MYFShowPicutreView.h
//  GomeLoanClient
//
//  Created by ru on 2018/1/10.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYFShowPicutreView : UIView





/**
 初始化

 @param displayImage 要展示的图片
 @return 实例
 */
+ (instancetype)creatMYFShowPictureViewWithImage:(UIImage *)displayImage;


/**
 show

 @param originRect 要展示图片原来的位置
 */
- (void)showWithOriginRect:(CGRect)originRect;

/** 消失 */
- (void)dismiss;

/** 显示的图片 */
@property (nonatomic, strong) UIImage *displayImage;


@end
