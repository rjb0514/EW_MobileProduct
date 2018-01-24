//
//  MYFShowPicutreView.m
//  GomeLoanClient
//
//  Created by ru on 2018/1/10.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "MYFShowPicutreView.h"




@interface MYFShowPicutreView ()<UIScrollViewDelegate>

/** 中间显示的图片 */
@property (nonatomic, strong) UIImageView *displayImageView;

/** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGRect originViewRect;

@end

@implementation MYFShowPicutreView


+ (instancetype)creatMYFShowPictureViewWithImage:(UIImage *)displayImage {
    MYFShowPicutreView *picture = [[MYFShowPicutreView alloc] init];
    picture.displayImage = displayImage;
    return picture;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect temp = [UIScreen mainScreen].bounds;
    if (frame.size.width == 0 || frame.size.height == 0) {
        frame.size = temp.size;
    }
    self = [super initWithFrame:frame];
    if (self) {
        //设置UI
        self.backgroundColor = [UIColor blackColor];
        self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.displayImageView];
    
}


/** 展示 */
- (void)showWithOriginRect:(CGRect)originRect {
    self.originViewRect = originRect;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 0;
    CGRect temp = self.displayImageView.frame;
    self.displayImageView.frame = originRect;
    [UIView animateWithDuration:0.35 animations:^{
        self.displayImageView.frame = temp;
        self.alpha = 1;
    }];
    
}

/** 销毁 */
- (void)dismiss {

    [UIView animateWithDuration:0.35 animations:^{
        self.displayImageView.frame = self.originViewRect;
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - scrollView Delegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    [self calculateDisplayImageViewFrame];
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.displayImageView;
}



#pragma mark - scrollView Click
- (void)scrollViewTapClick:(UITapGestureRecognizer *)tap {
    
    [self dismiss];
}


/** 初始化 图片大小 刚开始放到屏幕大 */
- (void)initialCalculateDisplayImageViewFrame {
    //最大尺寸
    CGRect maxRect = self.frame;
    //获取图片的frame
    [self.displayImageView sizeToFit];
    CGRect originFrame = self.displayImageView.frame;
    
    CGFloat displayViewX = 0;
    CGFloat displayViewY = 0;
    
    //scrollView的滚动范围
    CGFloat scrollViewContextW = 0;
    CGFloat scrollViewContextH = 0;
    
    originFrame.size.height = maxRect.size.width * originFrame.size.height / originFrame.size.width;
    originFrame.size.width = maxRect.size.width;
    scrollViewContextW = originFrame.size.width;
    scrollViewContextH = originFrame.size.height;
    
    if (originFrame.size.height < maxRect.size.height ) {
        
        displayViewY = (maxRect.size.height - originFrame.size.height)/2.0;
    }else {
        scrollViewContextH = originFrame.size.height;
    }
    
    self.displayImageView.frame = CGRectMake(displayViewX, displayViewY, originFrame.size.width, originFrame.size.height);
    self.scrollView.contentSize = CGSizeMake(scrollViewContextW, scrollViewContextH);
}

/** 计算显示图片的frame */
- (void)calculateDisplayImageViewFrame {
    
    //最大尺寸
    CGRect maxRect = self.frame;
    //获取图片的frame
    CGRect originFrame = self.displayImageView.frame;
    
    CGFloat displayViewX = 0;
    CGFloat displayViewY = 0;
    
    //scrollView的滚动范围
    CGFloat scrollViewContextW = 0;
    CGFloat scrollViewContextH = 0;
    
    if (originFrame.size.width < maxRect.size.width ) {
        
        displayViewX = (maxRect.size.width - originFrame.size.width)/2.0;
    }else {
        scrollViewContextW = originFrame.size.width;
    }
    
    if (originFrame.size.height < maxRect.size.height ) {
        
        displayViewY = (maxRect.size.height - originFrame.size.height)/2.0;
    }else {
        scrollViewContextH = originFrame.size.height;
    }
    
    self.displayImageView.frame = CGRectMake(displayViewX, displayViewY, originFrame.size.width, originFrame.size.height);
    self.scrollView.contentSize = CGSizeMake(scrollViewContextW, scrollViewContextH);
    
}


#pragma mark - lazy
- (UIImageView *)displayImageView {
    if (!_displayImageView) {
        _displayImageView = [[UIImageView alloc] init];
//        _displayImageView.image = [UIImage imageNamed:@"certifyTemplate"];
    }
    return _displayImageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 5.0;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapClick:)];
        
        [_scrollView addGestureRecognizer:tapGes];
    }
    return _scrollView;
}


- (void)setDisplayImage:(UIImage *)displayImage {
    _displayImage = displayImage;
    self.displayImageView.image = displayImage;
    [self initialCalculateDisplayImageViewFrame];
}


@end
