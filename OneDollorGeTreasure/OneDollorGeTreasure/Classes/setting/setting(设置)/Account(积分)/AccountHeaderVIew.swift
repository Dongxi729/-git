//
//  AccountHeaderVIew.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/24.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  我的积分头部视图

import UIKit

class AccountHeaderVIew: UIView {

    //背景图片
    lazy var BgImg : UIImageView = {
        let v = UIImageView()
        v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180 - 64)
        v.image = UIImage.init(named: "jifenBg")
        return v
    }()
    
    //头视图居中视图
    lazy var headCenterView : UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        
        return v
    }()
    
    
    //分数
    lazy var headCenterUpLabel : UILabel = {
        let v = UILabel()
        v.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 30)
        v.font = UIFont.systemFont(ofSize: 24)
        v.textAlignment = NSTextAlignment.center

        v.text = PersonInfoModel.shared.jifen
        v.textColor = UIColor.white
        
        return v
    }()
    
    //固定文字
    lazy var headCenterCurrentAccount : UILabel = {
        let v = UILabel()
        v.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 20)

        v.font = UIFont.systemFont(ofSize: 12)
        v.textAlignment = NSTextAlignment.center
        v.textColor = UIColor.white
        v.text = "当前我的积分"
        return v
    }()
    
    
    //我的积分记录
    lazy var title : UILabel = {
        let l = UILabel()
        l.frame = CGRect(x: 0, y: 180 - 64, width: UIScreen.main.bounds.width, height: 45)
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = NSTextAlignment.center
        l.backgroundColor = UIColor.gray
        l.text = "我的积分记录"
        return l
    }()
    
    //背景视图
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化视图（我的积分头部）
    func initView(){
        
        //背景图片
        addSubview(BgImg)
        
        //我的积分记录
        addSubview(title)
        
        //居中视图
        headCenterView.center = BgImg.center
        
        addSubview(headCenterView)
        
        //分数
        headCenterView.addSubview(headCenterUpLabel)
        //当前我的积分
        headCenterView.addSubview(headCenterCurrentAccount)
    }

    
}


