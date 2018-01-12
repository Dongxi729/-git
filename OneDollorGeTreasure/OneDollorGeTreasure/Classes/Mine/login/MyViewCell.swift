//
//  MyViewCell.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/24.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  我的模块下半部分 视图

import UIKit

/// 代理传递下面四个cell的点击事件
protocol MyViewCellDelegate {
    func cellOne()
    func cellTwo()
    func cellThree()
    func cellFour()
//    func cellFive()
}

class MyViewCell: UIView {
    //闭包
    var comfun:((_ sender:Int)->Void)?

    //代理
    var delegate : MyViewCellDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyViewCell {
    fileprivate func setUI() -> Void {

        let ladDataSource = ["订单管理","收货地址","帮助中心","设置"]
        
        let qzImgName = ["buyDetail","address","help","mine-setting-iconN"]
        
        var line = UIView()
        
        var labelTitle = UILabel()
        
        //前置图片
        var frontImg = UIImageView()
        
        //尖叫图片
        var discolreImg = UIImageView()
        
        //单机按钮
        var clickBtn = UIButton()
        
        //背景视图
        let bgView = UIView()
        
        addSubview(bgView)
        
        //设置label的标题
        for i in 0..<ladDataSource.count {
            
            //冒充表格的cell
            clickBtn = UIButton(frame: CGRect(x: 0, y: 45 * i, width: Int(UIScreen.main.bounds.width), height: Int(44.9)))
            
            clickBtn.tag = 500 + i
            clickBtn.backgroundColor = UIColor.white
            
            clickBtn.addTarget(self, action: #selector(self.clickBtnIndex(sender:)), for: .touchUpInside)
            
            self.addSubview(clickBtn)
            
            //标题
            labelTitle = UILabel(frame: CGRect(x: 40.0, y: Double(45 * i + 10), width: 80, height: 30.0))
            
            labelTitle.font = UIFont.systemFont(ofSize: 14)
            labelTitle.text = ladDataSource[i]
            
            labelTitle.tag = 200 + i
            //后缀图片
            frontImg = UIImageView(frame: CGRect(x: 10.0, y: Double(45 * i + 15), width: 30, height: 30))
            discolreImg = UIImageView(frame: CGRect(x: Int(UIScreen.main.bounds.width - 30), y:45 * i + 13, width: 20, height: 20))
            self.addSubview(discolreImg)
            self.addSubview(labelTitle)
            discolreImg.image = UIImage.init(named: "closuerimg")
            //线条
            if i == 1 || i == 2 || i == 3 || i == 4 {
                line = UIView(frame: CGRect(x: 0, y: 45 * i, width: Int(UIScreen.main.bounds.width), height: Int(0.7)))
                line.backgroundColor = UIColor.gray
                self.addSubview(line)
            }
            
            bgView.frame = CGRect(x: 0, y: 0, width: Int(SW), height: 45 * ladDataSource.count)
            bgView.backgroundColor = UIColor.lightGray
        }
        
        for j in 0..<qzImgName.count {
            //前置图片
            frontImg = UIImageView(frame: CGRect(x: 10.0, y: Double(45 * j + 15), width: 20, height: 20))
            frontImg.image = UIImage.init(named: qzImgName[j])
            frontImg.contentMode = UIViewContentMode.scaleAspectFit
            self.addSubview(frontImg)
        }
    }
}


// MARK:- 下面四个cell的单机事件
extension MyViewCell {
    @objc func clickBtnIndex(sender : UIButton) -> Void {
        switch sender.tag {
        case 500:
            self.delegate?.cellOne()
            break
        case 501:
            self.delegate?.cellTwo()
            
            break
        case 502:
            self.delegate?.cellThree()
            
            break
        case 503:
            self.delegate?.cellFour()
            
            break
//        case 504:
//            self.delegate?.cellFive()
//            print("504")
//            break
        default:
            break
        }
    }
}
