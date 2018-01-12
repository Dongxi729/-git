//
//  LeftBtn.swift
//  TTT
//
//  Created by 郑东喜 on 2017/1/21.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class LeftBtn: UIButton {

    var linStr : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
        
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: self.frame.width * 0.1, y: 0, width: self.frame.width * 0.25, height: self.frame.height)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
      return CGRect.init(x: self.frame.width * 0.35, y: 0, width: self.frame.width - self.frame.width * 0.35, height: self.frame.height)
    }
}
