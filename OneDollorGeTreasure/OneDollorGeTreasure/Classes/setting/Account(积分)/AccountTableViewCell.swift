//
//  AccountTableViewCell.swift
//  MD5
//
//  Created by 郑东喜 on 2016/11/24.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    static let shared = AccountTableViewCell()
    
    lazy var dataArr : NSArray = {
        var data = NSArray()
        
        return data
    }()
    
    //左上
    lazy var tfLeftUp : UILabel = {
        let tf = UILabel().labelWithBigText()
        tf.frame = CGRect(x: 10, y: 5, width: UIScreen.main.bounds.width, height: 30)

        return tf
    }()
    
    //左下
    lazy var tfLeftDown : UILabel = {
        let tf = UILabel().labelWithSamllText()
        tf.frame = CGRect(x: 10, y: 35, width: UIScreen.main.bounds.width, height: 20)

        return tf
    }()
    
    //右中
    lazy var tfRightCenter : UILabel = {
        let tf = UILabel().labelRight()
        
        tf.frame = CGRect(x: UIScreen.main.bounds.width - 80 - 15, y: 20, width: 80, height: 20)

        return tf
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            for i in 0..<dataArr.count {

                tfLeftUp.text = (dataArr[i] as! NSDictionary)["reason"] as? String
                tfLeftDown.text = (dataArr[i] as! NSDictionary)["result"] as? String
                tfRightCenter.text = (dataArr[i] as! NSDictionary)["time"] as? String

            }

//        }

        addSubview(tfLeftUp)
        addSubview(tfLeftDown)
        addSubview(tfRightCenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK:- label扩展
extension UILabel {
    
    //文字颜色
    func txtColor() -> UILabel {
        let lab = UILabel()
        if NSString(string: lab.text!).contains("-") {
        }

        return lab
    }
    
    //右文字
    func labelRight() -> UILabel {
        let lab = UILabel()
        
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textAlignment = NSTextAlignment.right
        return lab
    }
    
    //大文字
    func labelWithBigText() -> UILabel {
        let lab = UILabel()
        
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }
    
    //小文字
    func labelWithSamllText() -> UILabel {
        let lab = UILabel()
        
        lab.textColor = UIColor.lightGray
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }
}
