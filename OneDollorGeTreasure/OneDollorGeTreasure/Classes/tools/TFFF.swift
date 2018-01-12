//
//  TFFF.swift
//  Alili
//
//  Created by 郑东喜 on 2016/12/29.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  一个功能，仅仅是设置背景字体

import UIKit

class TFFF: UITextField {

    /**
     ## 为UITextfield添加方法，修改placeholder 字体的大小
     
     - str              placeholder文字
     - holderColor      placeholder文字颜色
     - textFontSize     placeholder文字大小
     */
    func plStrSize(str : String,holderColor : UIColor,textFontSize : CGFloat) -> Void {
        
        self.attributedPlaceholder = NSAttributedString(string:str,
                                                        attributes:[NSAttributedStringKey.foregroundColor: holderColor,
                                                                    NSAttributedStringKey.font :UIFont(name: "Arial", size: textFontSize)!])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //在编辑时，隐藏
        self.clearButtonMode = UITextFieldViewMode.whileEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     ## 重写placeholder的大小
     */
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 2.5, width: self.bounds.width, height: self.bounds.height)
    }
}
