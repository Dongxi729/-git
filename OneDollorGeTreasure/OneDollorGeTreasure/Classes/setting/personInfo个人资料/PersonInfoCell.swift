//
//  PersonInfoCell.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/20.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  个人信息cell

import UIKit

//设置代理方法
protocol PersonInfoCellDelegate {
    func seleImg()
}

class PersonInfoCell: UITableViewCell {
    //设置代理
    var delegate : PersonInfoCellDelegate?
    
    //cell的文字
    var headImgLabel: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 15, y: 15, width: 0, height: 30)
        lab.text = "头像"
        lab.sizeToFit()
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        
        return lab
    }()
    
    //分割线
    lazy var line : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    //头像按钮
    lazy var headImg : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.orange
        img.frame = CGRect(x: SW - 15 - 50, y: 5, width: 50, height: 50)
        img.backgroundColor = UIColor.orange
        img.layer.cornerRadius = 25
        
        //允许交互
        img.isUserInteractionEnabled = true
        //添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(PersonInfoCell.seleImgSEL))
        img.addGestureRecognizer(tapGes)
        return img
    }()
    
    
    //昵称
    lazy var nickName : UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 15, y: 75, width: 80, height: 30)
        
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        lab.text = "昵称"
        lab.sizeToFit()
        return lab
        
    }()
    
    //昵称
    lazy var tfNickName : TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x:  SW - 15 - 120, y: 75, width: 120, height: 30)
        
        //文字左对齐
//        lab.textAlignment = NSTextAlignment.left
//        lab.text = "昵称"
//        lab.plStrSize(str: "请输入您的昵称", holderColor: UIColor.gray, textFontSize: 13)
        lab.sizeToFit()
        return lab
        
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //取出高亮
        self.selectionStyle = .none
        
        
        addSubview(headImgLabel)

        addSubview(line)

        addSubview(headImg)
        
        addSubview(nickName)
        
        addSubview(tfNickName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//单机监听事件
extension PersonInfoCell {
    
    //验证码事件
    @objc fileprivate func seleImgSEL() -> Void {
    //暴漏出去的单机事件
        delegate?.seleImg()
    }
    
}
