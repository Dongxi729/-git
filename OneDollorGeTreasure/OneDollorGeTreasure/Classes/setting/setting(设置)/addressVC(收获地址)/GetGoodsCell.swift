//
//  GetGoodsCell.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/20.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  收货地址的cell

import UIKit

//代理传值
protocol GetGoodsCellDelegate {
    func savePersonInfoSEL()
}

class GetGoodsCell: UITableViewCell {
    //监听代理
    var delegate : GetGoodsCellDelegate?
    
    
    //cell的提示内容
    var nameLabel: TfPlaceHolder = {
        let lab = TfPlaceHolder()
        lab.frame = CGRect(x: 95, y: 7.5, width: 200, height: 30)
        
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    //前置标题
    lazy var labelDesc: UILabel = {
        let lab = UILabel()
        //自适应放大
        lab.frame = CGRect(x: 15, y: 7.5, width: 55, height: 30)
        //文字左对齐
        lab.textAlignment = NSTextAlignment.left
        lab.font = UIFont.systemFont(ofSize: 13)

        return lab
    }()
    
    //分割线
    lazy var line : UIView = {
        let lin = UIView()
        lin.frame = CGRect(x: 0, y: 45, width: UIScreen.main.bounds.size.width, height: 0.5)
        lin.backgroundColor = UIColor.lightGray
        return lin
    }()
    
    //退出按钮
    lazy var btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.setTitle("保存", for: .normal)
        //退出按钮
        btn.frame = CGRect(x: 15, y: 0, width: Int(UIScreen.main.bounds.width - 30), height: 40)
        //单机事件
        
        btn.addTarget(self, action: #selector(GetGoodsCell.touched), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    //尖角
    lazy var disclosureImg : UIImageView = {
        let img = UIImageView()
        
        img.contentMode = UIViewContentMode.scaleAspectFit
        img.frame = CGRect(x: UIScreen.main.bounds.width - 30, y: 7.5, width: 15, height: 30)
        img.backgroundColor = UIColor.black
        return img
    }()
    
    //详细地址文本域
    lazy var detailTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.gray
        tv.frame = CGRect(x: 15, y: 45, width: SW - 30, height: 55)
//        tv.backgroundColor = UIColor.black

        return tv
    }()
    
    
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        addSubview(nameLabel)
        addSubview(labelDesc)
        addSubview(line)
        addSubview(btn)
        addSubview(disclosureImg)
        addSubview(detailTextView)
        
        //去除高亮效果
        self.selectionStyle = .none
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
}

//暴漏代理方法
extension GetGoodsCell {
    @objc fileprivate func touched() -> Void {

        delegate?.savePersonInfoSEL()
    }
}
