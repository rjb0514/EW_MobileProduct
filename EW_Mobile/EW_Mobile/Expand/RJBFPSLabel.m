//
//  RJBFPSLabel.m
//  测试23423
//
//  Created by ru on 2017/12/28.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import "RJBFPSLabel.h"

#define kLabelSize   CGSizeMake(55, 20)


@interface RJBFPSLabel ()

@property (nonatomic, strong) CADisplayLink *displayLink;

/** 计数 */
@property (nonatomic, assign) NSInteger conut;

@property (nonatomic, assign) NSTimeInterval lastTime;

@end


@implementation RJBFPSWindow

+ (instancetype)sharedFPSWindow {
    static RJBFPSWindow *fpsWindow = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fpsWindow = [RJBFPSWindow new];
        CGRect temp = [UIScreen mainScreen].bounds;
        fpsWindow.frame = CGRectMake(0, 0,temp.size.width, temp.size.height);
        fpsWindow.windowLevel = UIWindowLevelNormal + 1;
        fpsWindow.hidden = NO;
        fpsWindow.backgroundColor = [UIColor clearColor];
        fpsWindow.rootViewController = [UIViewController new];
        RJBFPSLabel *fpsLabel = [RJBFPSLabel new];
//        fpsWindow.userInteractionEnabled = NO;
        fpsLabel.center = fpsWindow.center;
        [fpsWindow addSubview:fpsLabel];
    });
    return fpsWindow;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *view = [super hitTest:point withEvent:event];

    if ([view isEqual:self.rootViewController.view]) {
        return nil;
    }else {
        return view;
    }


}

@end

@implementation RJBFPSLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (frame.size.width == 0 && frame.size.height == 0) {
        
        frame.size = kLabelSize;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.textAlignment =NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculater:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}



/** 计算帧数  一秒钟走多少帧 */
- (void)calculater:(CADisplayLink *)display {
    if (!self.lastTime) {
        self.lastTime = display.timestamp;
        return;
    }
    
    self.conut ++;
    
    NSTimeInterval number = display.timestamp - self.lastTime;
    
    if (number < 1) {
        return;
    }
    
    CGFloat fps = self.conut / number;
    
    NSString *str = [NSString stringWithFormat:@"%zdFPS",(int)round(fps)];
    
    NSMutableAttributedString *strAttr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [strAttr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 2)];
    
    [strAttr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(str.length - 3, 3)];
    
    self.lastTime = display.timestamp;
    self.conut = 0;
    
    
    self.attributedText = strAttr;
    
    
}

- (void)tapClick:(UITapGestureRecognizer *)tapGes {
    
    CGPoint temp = [tapGes locationInView:self.superview];
    
    self.center = temp;
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.center = self.superview.center;
}


- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}


- (void)dealloc {
    NSLog(@"RJBFPSLabel -- dealloc");
}


@end
