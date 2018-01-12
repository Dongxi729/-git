//
//  LabelAnimated.m
//  LabelMove
//
//  Created by 郑东喜 on 2017/2/26.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

#import "LabelAnimated.h"

@implementation LabelAnimated

+ (void)animated:(UIView *)_view withFrame:(CGRect)rect {
    // 第一步：创建渐变效果的layer
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = rect;
    graLayer.colors = @[(__bridge id)[[UIColor greenColor] colorWithAlphaComponent:0.3].CGColor,
                        (__bridge id)[UIColor yellowColor].CGColor,
                        (__bridge id)[[UIColor redColor] colorWithAlphaComponent:0.3].CGColor];
    
    graLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
    graLayer.endPoint = CGPointMake(1, 0);  //设置渐变方向终点
    graLayer.locations = @[@(0.0), @(0.0), @(0.1)]; //colors中各颜色对应的初始渐变点
    
    // 第二步：通过设置颜色渐变点(locations)动画，达到预期效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.duration = 3.0f;
    animation.toValue = @[@(0.9), @(1.0), @(1.0)];
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.fillMode = kCAFillModeForwards;
    [graLayer addAnimation:animation forKey:@"xindong"];
    _view.layer.mask = graLayer;
}

@end
