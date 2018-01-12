//
//  CountDownBtn.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/27.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit
//发送几秒
var  NUMSS = 60
//protocol sendBtnDelegate:NSObjectProtocol {
//    func whenSendBtnClicked(button:CountDownBtn) -> Void
//}

class CountDownBtn: UIButton {
    
    //触发倒计时事件
    var countYES = ""
    
    
    //秒数
    var  i = NUMSS
    
    //定时器
    var myTimer:Timer?
    
    //按钮代理
//    weak var delegate:sendBtnDelegate!

    //当前按钮背景颜色
    var  currentColor:UIColor?
    
//    func aaa() -> Void {
        //初始化控件
        func initwith(color : UIColor,title:String,superView:UIView) -> Void {
            //        self.frame = frame;
            //        self.backgroundColor = color
            self.setTitle(title, for: UIControlState.normal)
            //        self.addTarget(self, action: #selector(CodeButtonTapped), for: UIControlEvents.touchUpInside)
            
            self.setTitle("重发(\(NUMSS))s", for: UIControlState.disabled)
            self.titleLabel?.adjustsFontSizeToFitWidth = true
            self.backgroundColor=UIColor.lightGray
            self.isEnabled=false
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tiemrBengin), userInfo: self, repeats: true)
            //        代理实现方法
//            self.delegate.whenSendBtnClicked(button: self)
            
            superView.addSubview(self)
//            self.delegate = delegate
            self.isUserInteractionEnabled = true
            self.currentColor = color
        }
//    }
    
    @objc func  tiemrBengin(timer:Timer)
    {
        
        i -= 1
        let  button = timer.userInfo as! CountDownBtn
        button.setTitle(String(format: "重发(%d)s",i), for: UIControlState.disabled)
        button.backgroundColor=UIColor.lightGray
        if i == 0 {
            timer.invalidate()
            button.isEnabled = true
            button.backgroundColor = self.currentColor
            i = NUMSS
            
        }
        
    }
}

