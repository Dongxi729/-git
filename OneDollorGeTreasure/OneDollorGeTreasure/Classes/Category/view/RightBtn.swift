//
//  RightBtn.swift
//  TTT
//
//  Created by 郑东喜 on 2017/1/21.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class RightBtn: UIButton {
    
    var liiinKSre : String?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.setTitleColor(UIColor.black, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.65)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: self.frame.height * 0.65, width: self.frame.width, height: self.frame.height * 0.35)
    }

}
