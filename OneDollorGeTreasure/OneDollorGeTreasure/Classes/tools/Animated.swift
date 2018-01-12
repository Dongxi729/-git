//
//  Animated.swift
//  Alili
//
//  Created by 郑东喜 on 2017/2/18.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  转场动画

import UIKit

class Animated: NSObject {

    //    kCATransitionMoveIn 新视图移到旧视图上面
    //    kCATransitionPush   新视图把旧视图推出去
    //    kCATransitionReveal 将旧视图移开,显示下面的新视图
    //    pageCurl            向上翻一页
    //    pageUnCurl          向下翻一页
    //    rippleEffect        滴水效果
    //    suckEffect          收缩效果，如一块布被抽走
    //    cube                立方体效果
    //    oglFlip             上下翻转效果

    /// 转场动画
    ///
    /// - Parameters:
    ///   - vc: 执行的控制器
    ///   - animatedType: 类型
    ///   - timeduration: 转场时间
    ///   -      kCATransitionFade   交叉淡化过渡
    
    class func vcWithTransiton(vc : UIViewController,animatedType : String,timeduration : CFTimeInterval) -> Void {
        let transition : CATransition = CATransition.init()
        
        transition.duration = timeduration
        transition.type = animatedType
        vc.view.layer.add(transition, forKey: nil)
    }
    
    /// 转场动画
    ///
    /// - Parameters:
    ///   - vc: 执行的控制器
    ///   - animatedType: 类型
    ///   - timeduration: 转场时间
    ///   -      kCATransitionFade   交叉淡化过渡
    class func vcWithTransiton(_view : UIView,animatedType : String,timeduration : CFTimeInterval) -> Void {
        let transition : CATransition = CATransition.init()
        
        transition.duration = timeduration
        transition.type = animatedType
        _view.layer.add(transition, forKey: nil)
    }
    

}
