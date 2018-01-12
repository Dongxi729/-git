//
//  MyVJIfenV.swift
//  Alili
//
//  Created by 郑东喜 on 2018/1/3.
//  Copyright © 2018年 郑东喜. All rights reserved.
//  积分背景视图

import UIKit

class MyVJIfenV: UIView {
    
    private var jinbiV : UIView = UIView()
    
    /// 积分文本
    var jifenLabel : UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let a = UIImageView.init(frame: CGRect.init(x: SW / 3 - 10, y: 25 / 2, width: 20, height: 20))
        a.image = #imageLiteral(resourceName: "money")
        a.contentMode = .scaleAspectFit
        let b = UILabel.init(frame: CGRect.init(x: SW / 3, y: 0, width: SW / 3, height: 45))
        b.textAlignment = .center
        b.text = "我的积分"
        let c = UILabel.init(frame: CGRect.init(x: SW / 3 * 2, y: 0, width: SW / 3, height: 45))
        c.textColor = #colorLiteral(red: 0.3090585172, green: 0.6651561856, blue: 0.9146764874, alpha: 1)
        jifenLabel = c
        
        addSubview(a)
        addSubview(b)
        addSubview(c)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
