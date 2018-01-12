//
//  DetailAddressCell.swift
//  Alili
//
//  Created by 郑东喜 on 2017/1/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

// MARK:- 设置代理
protocol DetailAddressCellDelegate {
    //    func showLogVC()
    func delSel(int : IndexPath)
    
    ///编辑按钮单机事件
    func editPassSEL(int : IndexPath)
    
    ///设置默认单机事件
    func defauPassSEL(int : IndexPath,btnSender : UIButton)
}

class DetailAddressCell: UITableViewCell {
    
    static let shared = DetailAddressCell()
    
    ///数据源
    lazy var dataArr : NSArray = {
        var data = NSArray()
        
        return data
    }()
    
    
    ///当前所有控件高度
    var height : CGFloat = 0.0
    
    //监听代理
    var delegate : DetailAddressCellDelegate?
    
    
    ///收货地址图标
    var addressIcon: UIImageView = {
        let lab = UIImageView()
        return lab
    }()
    
    ///默认按钮图标
    var defaultIcon: UIButton = {
        let lab = UIButton()
        return lab
    }()
    
    ///默认按钮图标
    var defaultLab: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    ////默认的图片
    var defaultLabIcon: UIImageView = {
        let lab = UIImageView()
        return lab
    }()
    
    ////默认的选中的图片
    var defaultLabSelectedIcon: UIImageView = {
        let lab = UIImageView()
        return lab
    }()
    
    ///收货地址文本
    var addressLab: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    ///删除图标
    var delIcon: UIImageView = {
        let lab = UIImageView()
        
        return lab
    }()
    
    ///编辑图标
    var editIcon: UIImageView = {
        let lab = UIImageView()
        return lab
    }()
    
    ///横线
    var line: UIView = {
        let lab = UIView()
        
        return lab
    }()
    
    ///名字
    var nameLabel: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    ///点好号码
    var telLab: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    ///地址
    var addLab: UILabel = {
        let lab = UILabel()
        
        return lab
    }()
    
    //退出按钮
    lazy var btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.gray
        btn.setTitle("删除", for: .normal)
        //退出按钮
        btn.frame = CGRect(x: Int(UIScreen.main.bounds.width - 30), y: 0, width: 60, height: 40)    //单机事件
        
        btn.addTarget(self, action: #selector(DetailAddressCell.deleteSEL), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        ///设置UI
        setUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
}

//单机监听事件
extension DetailAddressCell {
    @objc fileprivate func deleteSEL() -> Void {
        
        if #available(iOS 11.0, *) {
            
            for vi in (self.superview?.superview?.subviews)! {
                
                if let tbv = vi as? UITableView {
                    
                    self.delegate?.delSel(int: tbv.indexPath(for: self)!)
                }
            }
            
        } else {
            self.delegate?.delSel(int : (self.superview?.superview as! UITableView).indexPath(for: self)!)
        }
    }
    
    ///删除图标
    @objc fileprivate func editIconSel() -> Void {
        
        
        if #available(iOS 11.0, *) {
            
            for vi in (self.superview?.superview?.subviews)! {
                
                if let tbv = vi as? UITableView {
                    
                    self.delegate?.editPassSEL(int: tbv.indexPath(for: self)!)
                }
            }
        } else {
            
             self.delegate?.editPassSEL(int: (self.superview?.superview as! UITableView).indexPath(for: self)!)
        }
        
    }
    
    
    ///设置默认按钮事件
    @objc fileprivate func defauSEL(sender : UIButton) -> Void {
        
        if #available(iOS 11.0, *) {
            
            for vi in (self.superview?.superview?.subviews)! {
                
                if let tbv = vi as? UITableView {
                    
                    if tbv.indexPath(for: self) != nil {
                        
                        self.delegate?.defauPassSEL(int: tbv.indexPath(for: self)!, btnSender: sender)
                    }
                }
            }
        } else {
            self.delegate?.defauPassSEL(int: (self.superview?.superview as! UITableView).indexPath(for: self)!, btnSender: sender)
        }
        
        ///本地修改
    }
}


// MARK:- 设置控件
extension DetailAddressCell {
    func setUI() -> Void {
        ///收货地址图标
        addressIcon.frame = CGRect(x: 15, y: 6, width: 20, height: 20)
        addressIcon.image = UIImage.init(named: "address")
        addSubview(addressIcon)
        
        ///收货地址文本
        addressLab.frame = CGRect(x: addressIcon.RightX + 5, y: 8, width: self.defaultLab.Width + 10 + self.defaultIcon.Width, height: 20)
        addressLab.text = "收货地址"
        addressLab.font = UIFont.boldSystemFont(ofSize: 14)
        addressLab.sizeToFit()
        addSubview(addressLab)
        
        
        
        
        
        
        
        ///默认图标按钮
        defaultIcon.frame = CGRect(x: addressLab.RightX + 15, y: 6, width: 20, height: 20)
        
        addSubview(defaultIcon)
        
        ///默认图标、
        defaultLabIcon.frame = defaultIcon.frame
        defaultLabIcon.image = UIImage.init(named: "select")
        addSubview(defaultLabIcon)
        
        
        ///默认文本
        defaultLab.frame = CGRect(x: defaultIcon.RightX + 5, y: 6, width: 40, height: 20)
        defaultLab.text = "默认"
        
        defaultLab.font = UIFont.boldSystemFont(ofSize: 14)
        
        defaultLab.textColor = commonBtnColor
        addSubview(defaultLab)
        
        
        ///编辑图标
        editIcon.frame = CGRect(x: SW - 35, y: 6, width: 25, height: 25)
        editIcon.image = UIImage.init(named: "edit")
        
        ///添加交互事件
        editIcon.isUserInteractionEnabled = true
        
        ///添加手势
        let editIconGes = UITapGestureRecognizer.init(target: self, action: #selector(editIconSel))
        
        editIcon.addGestureRecognizer(editIconGes)
        
        addSubview(editIcon)
        
        ///删除图标
        delIcon.frame = CGRect(x:  SW - 75, y: 6, width: 25, height: 25)
        delIcon.image = UIImage.init(named: "trash")
        
        ///添加交互事件
        delIcon.isUserInteractionEnabled = true
        
        ///添加手势
        let delIconGes = UITapGestureRecognizer.init(target: self, action: #selector(deleteSEL))
        
        delIcon.addGestureRecognizer(delIconGes)
        addSubview(delIcon)
        
        
        ///横线
        line.frame = CGRect(x: 15, y: addressIcon.BottomY + 10, width: SW - 30, height: 0.5)
        line.backgroundColor = UIColor.lightGray
        addSubview(line)
        
        ///名字
        nameLabel.frame = CGRect(x: 15, y: line.BottomY + 10, width: 100, height: 20)
        
        nameLabel.text = "ghjklkjhghjklkjhn"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.sizeToFit()
        
        ///获取实时文本的大小
        let nameSize : CGSize = nameLabel.sizeThatFits(CGSize(width: nameLabel.frame.size.width, height: CGFloat(MAXFLOAT)))
        nameLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y, width: nameLabel.frame.size.width, height: nameSize.height)
        
        addSubview(nameLabel)
        
        ///电话号码
        telLab.frame = CGRect(x: nameLabel.RightX + 10, y: line.BottomY + 9, width: 100, height: 20)
        telLab.text = "3432432432432"
        telLab.sizeToFit()
        telLab.font = UIFont.boldSystemFont(ofSize: 14)
        addSubview(telLab)
        
        ///地址
        addLab.frame = CGRect(x: 15, y: nameLabel.BottomY + 5, width: SW - 30, height: 20)
        addLab.font = UIFont.boldSystemFont(ofSize: 14)
        addLab.text = "的很多卡是肯定会说阿萨德家看撒娇了的很多卡是肯定会说阿萨德家看撒娇了"
        
        ///设置地址label的自适应高度
        addLab.numberOfLines = 0
        ///自动换行
        addLab.lineBreakMode = .byCharWrapping
        
        ///获取实时文本的大小
        let addSize : CGSize = addLab.sizeThatFits(CGSize(width: addLab.frame.size.width, height: CGFloat(MAXFLOAT)))
        addLab.frame = CGRect(x: addLab.frame.origin.x, y: addLab.frame.origin.y, width: addLab.frame.size.width, height: addSize.height)
        addSubview(addLab)
        
        //去除高亮效果
        self.selectionStyle = .none
        
        ///设置行透明view
        let cellView = UIView.init(frame: CGRect(x: 0, y: addLab.BottomY + 5, width: SW, height: 10))
        
        
        cellView.backgroundColor = commonBgColor
        addSubview(cellView)
        
        /////////////////////////////////////////////////////////////////////////////////////////////
        let holeBtn = UIButton.init(frame: CGRect.init(x: defaultIcon.LeftX, y: 10, width: defaultIcon.Width + 10 + defaultLab.Width + 10 , height: 40))
        
        holeBtn.addTarget(self, action: #selector(defauSEL(sender:)), for: .touchUpInside)
        
        addSubview(holeBtn)
        
        ///获取高度
        self.height = 45 + 1 + 15 + telLab.Height + addLab.Height
        
        
        
        
    }
}




