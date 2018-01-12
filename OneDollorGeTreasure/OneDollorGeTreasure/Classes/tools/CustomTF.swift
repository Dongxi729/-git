//
//  CustomTF.swift
//  Fuck
//
//  Created by 郑东喜 on 2016/12/10.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

class CustomTF : UITextField,UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    //限定最大字数
    var maxLenth : Int = 40
    
    //看到密码图片
    var seePassImg = UIImageView()
    
    var rect : CGRect?
    /**
     ## 重写placeholder的大小
     */
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 2.5, width: self.bounds.width, height: self.bounds.height)
    }
    
    /**
     ## 为UITextfield添加方法，修改placeholder 字体的大小
     
     - str              placeholder文字
     - holderColor      placeholder文字颜色
     - textFontSize     placeholder文字大小
     */
    func plStrSize(str : String,holderColor : UIColor,textFontSize : CGFloat) -> Void {
        
        self.attributedPlaceholder = NSAttributedString(string:str,
                                                        attributes:[NSAttributedStringKey.foregroundColor: holderColor,
                                                                    NSAttributedStringKey.font :UIFont(name: "Arial", size: textFontSize)!])
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //在编辑时，隐藏
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        
        seePassImg = UIImageView()
        seePassImg.frame = CGRect(x: UIScreen.main.bounds.width - 15, y: 8.0, width: 15, height: 15)
        //        seePassImg.layer.cornerRadius = 7.5
        seePassImg.isHidden = true
        //添加手势
        seePassImg.isUserInteractionEnabled = true
        
        self.addSubview(seePassImg)
        
        //继承代理
        self.delegate = self
        
        
    }
    
    
    
    func setPass(setSecure : Bool,maxInput : Int) -> Void {
        
        self.maxLenth = maxInput
        self.isSecureTextEntry = setSecure
        self.maxLenth = maxInput
        
    }
    
    
    @objc func tag(sender : UITapGestureRecognizer) -> Void {
        
        if self.isSecureTextEntry == true {
            self.isSecureTextEntry = false
            seePassImg.image = UIImage.init(named: "ico_eyeed")
        } else {
            self.isSecureTextEntry = true
            seePassImg.image = UIImage.init(named: "ico_eye")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    //统计文字个数
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:      NSRange, replacementString string: String) -> Bool {
        
        if self.isSecureTextEntry == true {
            seePassImg.isHidden = false
            
            self.rightViewMode = UITextFieldViewMode.always
            self.rightView = seePassImg
            seePassImg.image = UIImage.init(named: "ico_eye")
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tag(sender:)))
            
            self.rightView?.addGestureRecognizer(tapGes)
        }
        
        //限定最大字数(默认40个字符)
        let maxLength = self.maxLenth
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= maxLength
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        seePassImg.isHidden = true
    }
}
