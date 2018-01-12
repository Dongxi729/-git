//
//  ZDXAlertController.swift
//  Alili
//
//  Created by 郑东喜 on 2017/11/2.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class ZDXAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addAction(_ action: UIAlertAction) {
        super.addAction(action)
        //通过tintColor实现按钮颜色的修改。
        self.view.tintColor = commonBtnColor
        //也可以通过设置 action.setValue 来实现
        //action.setValue(UIColor.orange, forKey:"titleTextColor")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

