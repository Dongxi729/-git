//
//  GetCardCell.swift
//  Alili
//
//  Created by 郑东喜 on 2017/10/26.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class GetCardCell: UITableViewCell {
    
    
    
    lazy var getCard_moneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 12 * SCREEN_SCALE, y: SCREEN_SCALE * (12 + 5), width: SCREEN_SCALE * self.Width * 0.15, height: 10 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 13)
        d.textColor = commonBtnColor
        d.text = "Y3.8"
        return d
    }()
    
    /// 满多少金额可用
    lazy var getCard_moneyDesLab: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x:  SCREEN_SCALE * 5, y: SCREEN_SCALE * (self.getCard_moneyLabel.BottomY + 5), width: self.getCard_moneyLabel.Width * SCREEN_SCALE, height: 10 * SCREEN_SCALE))
        d.text = "满39元可用"
        d.textAlignment = .center
        d.font = UIFont.systemFont(ofSize: 7.5 * SCREEN_SCALE)
        return d
    }()
    
    /// 新手红包
    lazy var getCard_freshMeat: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.getCardDescLabel.LeftX, y: self.Height * 0.24 * SCREEN_SCALE, width: self.Width * 0.6 * SCREEN_SCALE, height: 10 * SCREEN_SCALE))
        d.font = UIFont.boldSystemFont(ofSize: 11 * SCREEN_SCALE)
        d.text = "新手红包"
        return d
    }()
    
    lazy var getcard_CaRDATE: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.23 * SCREEN_SCALE, y: self.Height * 0.55 * SCREEN_SCALE, width: self.Width * 0.6 * SCREEN_SCALE, height: 10 * SCREEN_SCALE))
        d.text = "阿萨德撒多撒多"
        d.font = UIFont.systemFont(ofSize: 10)
        return d
    }()
    
    lazy var getCardDescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.23 * SCREEN_SCALE, y: self.Height * 0.5 , width: self.Width * 0.4, height: 60))
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.numberOfLines = 0
        d.lineBreakMode = .byWordWrapping
        d.text = "2017-10-31到期"
        return d
    }()
    
    /// 立即领取
    lazy var getCard_NowBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.5 * SCREEN_SCALE + self.Width * 0.075 * SCREEN_SCALE, y: 28.89475 / 1.4 * SCREEN_SCALE, width: self.Width * 0.15 * SCREEN_SCALE, height: 18 * SCREEN_SCALE))
        d.layer.cornerRadius = 7.5 * SCREEN_SCALE
        d.clipsToBounds = true
        d.titleLabel?.font = UIFont.systemFont(ofSize: 8.5)
        d.setTitle("立即领取", for: .normal)
        d.isUserInteractionEnabled = true
        d.backgroundColor = commonBtnColor
        return d
    }()
    
    lazy var getCardCell_BgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width * 0.75 * SCREEN_SCALE, height: SCREEN_SCALE * (self.Width) * (81 / 342) * 0.75))
        d.image = #imageLiteral(resourceName: "getCardCellBg")
        return d
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        layer.backgroundColor = UIColor.red.cgColor
        addSubview(getCardCell_BgImg)
        addSubview(getCard_moneyLabel)
        addSubview(getCard_moneyDesLab)
        
//        addSubview(getcard_CaRDATE)
        addSubview(getCardDescLabel)
        
        addSubview(getCard_freshMeat)
        addSubview(getCard_NowBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

