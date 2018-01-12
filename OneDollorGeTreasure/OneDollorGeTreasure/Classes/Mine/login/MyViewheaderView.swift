//
//  MyViewheaderView.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/24.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  我的模块头视图

import UIKit


class MyViewheaderView: UIView {
    
    static let shared = MyViewheaderView()
    
    //默认背景视图
    lazy var headerBgImg : UIImageView = {
        let v = UIImageView()
        v.contentMode = UIViewContentMode.scaleToFill
        
        if SH == 812 {
            v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180 + 44 - 45)
        } else {
            v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180 - 45)
        }
        
        v.image = UIImage.init(named: "jifenBg")
        return v
    }()
    
    //头像
    lazy var headImg : UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: Int(UIScreen.main.bounds.width / 2 - 30), y:44, width: 60, height: 60)
        if SH == 812 {
            img.frame = CGRect(x: Int(UIScreen.main.bounds.width / 2 - 30), y:84, width: 60, height: 60)
        }
        img.layer.cornerRadius = 30
        
        img.layer.masksToBounds = true
        img.image = #imageLiteral(resourceName: "userThumb")
        return img
    }()
    
    // 姓名
    var nickName : UILabel = {
        var lab = UILabel()
        lab.frame = CGRect(x: 0, y: 160 - 64, width: UIScreen.main.bounds.width, height: 44)
        if SH == 812 {
            lab.frame = CGRect(x: 0, y: 220 - 84, width: UIScreen.main.bounds.width, height: 44)
        }
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.textAlignment = NSTextAlignment.center
        lab.textColor = UIColor.white
        
        return lab
    }()
    
    //默认背景视图
    lazy var donwView : UIView = {
        let v = UIView()
        v.contentMode = UIViewContentMode.scaleAspectFill
        v.frame = CGRect(x: 0, y: 180, width: UIScreen.main.bounds.width, height: 60)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    /// 积分视图
    lazy var jifenSmallV: MyVJIfenV = {
        let d: MyVJIfenV = MyVJIfenV.init(frame: CGRect.init(x: 0, y: self.headerBgImg.BottomY, width: SW, height: 45))
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
        addSubview(jifenSmallV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() -> Void {
        
        self.addSubview(headerBgImg)
        self.addSubview(headImg)
        self.addSubview(nickName)
     
    }
}
