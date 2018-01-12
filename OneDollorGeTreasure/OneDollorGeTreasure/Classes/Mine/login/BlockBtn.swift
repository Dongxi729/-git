//
//  BlockBtn.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/17.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  暂时没用到，先留着

import UIKit


/**
 *  LTBlockButton
 *
 *  BlockButton 闭包回调
 */
class BlockBtn: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.adjustsImageWhenDisabled = false
    }
 
    
    //默认为蓝色
    override func awakeFromNib() {
        self.backgroundColor = UIColor.blue
    }

    typealias buttonClickedClosure = (_ button: UIButton) -> Void
    
    //闭包
    fileprivate var buttonClosure: buttonClickedClosure?
    
    /** 设置『闭包』回调方法 */
    func setClickClosure(_ closure: @escaping buttonClickedClosure) -> Void {
        self.addTarget(self, action: #selector(BlockBtn.buttonAction(_:)), for: UIControlEvents.touchUpInside)
        buttonClosure = closure
    }
    
    //MARK: >> button 点击事件
    @objc fileprivate func buttonAction(_ button: UIButton) -> Void {
        if buttonClosure != nil {
            buttonClosure!(button)
        }
    }
    
    //重写按钮图片大小（占据全部）
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    //重写按钮文本大小（为空）
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    

}
