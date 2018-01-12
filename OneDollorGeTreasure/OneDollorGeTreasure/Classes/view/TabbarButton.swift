
//
//  TabbarButton.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/6.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

class TabbarButton: UIButton {
    let tabbarImageRadio = 0.25
    
    var item : UITabBarItem = UITabBarItem(){
        didSet{
            self.setTitle(self.item.title, for: UIControlState())
            self.setTitle(self.item.title, for: .selected)
            
            self.setImage(self.item.image, for: UIControlState())
            self.setImage(self.item.selectedImage, for: .selected)
        }
    }
    
    //设置按钮标题和图片样式
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //图片居中
        self.imageView?.contentMode = .scaleAspectFit
        //按钮取出高亮
        self.adjustsImageWhenDisabled = false
        
        //文字居中
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        //title两种颜色
        self.setTitleColor(UIColor.green, for: .selected)
        self.setTitleColor(UIColor.black, for: UIControlState())
    }
    
    // MARK:- title
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titltY = contentRect.size.height * CGFloat(tabbarImageRadio)
        let titleH = contentRect.size.height - titltY
        let titleW = contentRect.size.width
        return CGRect(x: 0, y: (contentRect.size.height * 0.35), width: titleW, height: titleH)
    }
    
    // MARK:- image
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageH = contentRect.size.height * CGFloat(0.45)
        let imageW = contentRect.size.width
        return CGRect(x: 0, y: contentRect.size.height * 0.1, width: imageW, height: imageH)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
