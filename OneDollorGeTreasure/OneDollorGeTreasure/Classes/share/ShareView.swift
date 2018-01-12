//
//  ShareView.swift
//  PresentView
//
//  Created by 郑东喜 on 2016/12/5.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  分享自定义视图（原生presnt半透明效果）

import UIKit

protocol ShareViewDelegate {
    func shareType(__data : Int) -> Void
}

class ShareView: UIView {
    
    
    var delegate : ShareViewDelegate?
    
    
    //按钮
    var btn = UIButton()
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}

extension ShareView {
    func setUI() -> Void {
        //边框设置
        let v = UIView()
        v.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width, height: 150)
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 4
        self.addSubview(v)
        
        //label设置
        let label = UILabel()
        label.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: 30)
        
        
        label.text = "分享至"
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        v.addSubview(label)
        
        
        //横线
        let line = UIView()
        line.frame = CGRect(x: 10, y: 35, width: UIScreen.main.bounds.width - 20, height: 0.4)
        line.backgroundColor = UIColor.gray
        v.addSubview(line)
        
        let dataArray = ["QQ","QQ空间","微信朋友圈","微信好友"]
        
        //按钮
        for i in 0..<dataArray.count {
            btn = CenTitImg()
            let w = UIScreen.main.bounds.width / 4.0
        
            btn.setTitle(dataArray[i], for: .normal)
            btn.setTitle(dataArray[i], for: .highlighted)
            btn.addTarget(self, action: #selector(shareSEL(sender:)), for: .touchUpInside)
            btn.tag = 100 + i
            btn.frame = CGRect(x: w * CGFloat(i) , y: 50, width: w, height: w)

            v.addSubview(btn)
            
            
            if btn.tag == 100 {
                btn.setImage(UIImage.init(named: "s_QQ"), for: .normal)
                btn.setImage(UIImage.init(named: "s_QQ"), for: .highlighted)
            }
            if btn.tag == 101 {
                btn.setImage(UIImage.init(named: "s_QZone"), for: .normal)
                btn.setImage(UIImage.init(named: "s_QZone"), for: .highlighted)
            }
            if btn.tag == 102 {
                btn.setImage(UIImage.init(named: "wx_Fri"), for: .normal)
                btn.setImage(UIImage.init(named: "wx_Fri"), for: .highlighted)
            }
            if btn.tag == 103 {
                btn.setImage(UIImage.init(named: "wx_Zone"), for: .normal)
                btn.setImage(UIImage.init(named: "wx_Zone"), for: .highlighted)
            }
        }
    }
    
    @objc func shareSEL(sender : CenTitImg) -> Void {
        
        self.delegate?.shareType(__data: sender.tag)
        

    }
}
