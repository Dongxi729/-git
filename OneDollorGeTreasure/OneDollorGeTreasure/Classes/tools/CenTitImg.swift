//
//  CenTitImg.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/25.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  文字居中。图片上面居中

import UIKit

class CenTitImg: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        setTitleColor(UIColor.darkGray, for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y:self.bounds.height * 0.7 , width: self.bounds.width, height: self.bounds.height * 0.3)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.7)
    }
}
