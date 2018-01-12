//
//  ToolBar.swift
//  hangge_1169_2
//
//  Created by 郑东喜 on 2016/11/29.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  自定义toolbar

import UIKit

class ToolBar: UIToolbar {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 }

/**
 ## 自定义toolbar，只需实现tool左右两边的标题和方法即可
 
 
 -  confirmTitle    确定标题名字（随便写）
 -  cancelTitle     取消标题名字（随便写）
 -  comfirmSEL      确定事件
 -  cancelSEL       取消事件
 */
extension ToolBar {
    
    
    func seToolBar(confirmTitle : String,cancelTitle : String,comfirmSEL : Selector?,cancelSEL : Selector?,target: Any?) -> Void {
//        let toolBar = UIToolbar()
        self.barStyle = UIBarStyle.default
        self.isTranslucent = true
        self.tintColor = UIColor.orange
        self.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: confirmTitle, style: UIBarButtonItemStyle.plain, target: target, action:comfirmSEL)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: cancelTitle, style: UIBarButtonItemStyle.plain, target: target, action:cancelSEL)
        
        self.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
    
    func seToolBarWithOne(confirmTitle : String,comfirmSEL : Selector?,target: Any?) -> Void {
        //        let toolBar = UIToolbar()
        self.barStyle = UIBarStyle.default
        self.isTranslucent = true
        self.tintColor = commonBtnColor
        self.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: confirmTitle, style: UIBarButtonItemStyle.plain, target: target, action:comfirmSEL)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        self.setItems([ spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
}
