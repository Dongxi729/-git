//
//  RefreshView.swift
//  UpdateView
//
//  Created by 郑东喜 on 2016/12/24.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  刷新视图

import UIKit

class RefreshView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 刷新视图
    ///
    /// - Parameter labStr: 刷新文字
    func setUI(labStr : String) -> Void {
        
        let lab = UILabel()
        lab.frame = CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 35)
        lab.backgroundColor = commonBtnColor
        lab.text = labStr
        
        //居中
        lab.textAlignment = NSTextAlignment.center
        lab.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(lab)
        
        self.backgroundColor = commonBtnColor
    }
    
    
}
