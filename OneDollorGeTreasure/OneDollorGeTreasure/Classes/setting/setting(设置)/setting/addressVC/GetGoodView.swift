//
//  GetGoodView.swift
//  DollBuy
//
//  Created by 郑东喜 on 2016/11/23.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

///按钮是否选择
var issetBtn : Bool = true

protocol GetGoodViewDelegate {
    func backToGood()
}

class GetGoodView: UIView,UITextFieldDelegate,UITextViewDelegate {
    
    var delegate : GetGoodViewDelegate?
        
    static let shared = GetGoodView()
    
    var addDic = NSDictionary()

    //收货人
    var tfName = UITextField()
    
    //手机号
    var tfNum = UITextField()
    
    //省份
    var tfProvince = UITextField()
    
    //城市
    var tfCity = UITextField()
    
    //地区
    var tfArea = UITextField()
    
    //详细地址
    var tfView = UITextView()
    
    ///收货地址按钮
    var defaultAddressBtn = UIButton()
    
    //城市选择器
    var v = PickerV()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension GetGoodView {
    fileprivate func setUI() -> Void {
        

        let arr = ["请输入您的姓名","请输入您的手机号","请选择省份","请选择城市","请选择地区","请输入您的详细地址","7","8"]
        let ladDataSource = ["收货人","联系方式","省份","城市","地区","详细地址",""]
        
        var line = UIView()
        
        var labelTitle = UILabel()
        
        //设置label的标题
        for i in 0..<ladDataSource.count {
            
            labelTitle = UILabel(frame: CGRect(x: 10.0, y: Double(50 * i + 10), width: 80, height: 30.0))
            
            labelTitle.font = UIFont.systemFont(ofSize: 14)
            labelTitle.text = ladDataSource[i]

            
            
            self.addSubview(labelTitle)
        }
        
        for i in 0..<arr.count {

            var tf = TfPlaceHolder()
            
            //布局前面。、中间
            if i < 5 {
                
                tf = TfPlaceHolder(frame: CGRect(x: 80 + 15 , y: 50 * i, width: Int(UIScreen.main.bounds.width - 80 - 30), height: 50))
                tf.tag = 100 + i
                
                tf.plStrSize(str: arr[i], holderColor: UIColor.gray, textFontSize: 13)
                //继承代理
                tf.delegate = self
                
                //添加工具栏
                let toolBar = ToolBar()
                toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(cancelBtn), target: self)
                tf.inputAccessoryView = toolBar
                
                self.addSubview(tf)
   
            }
            //i为6 时，为label
            var ttetView = MYQPlaceholderTextView()
            if i == 5 {
                
                ttetView = MYQPlaceholderTextView(frame: CGRect(x: 80 + 11 , y: 50 * i + 10, width: Int(UIScreen.main.bounds.width - 80 - 30), height: 50))
                
                if ttetView.text == "请输入您的详细地址" {
                    ttetView.font = UIFont.systemFont(ofSize: 13)
                } else {
                    ttetView.font = UIFont.systemFont(ofSize: 15)
                }
                ttetView.placeholder = "请输入您的详细地址"
//                ttetView.font = UIFont.systemFont(ofSize: 15)
                ttetView.backgroundColor = UIColor.clear
                ttetView.textColor = UIColor.black
                ttetView.tag = 400

                ttetView.delegate = self
            }
            
            if i == 6 {
                defaultAddressBtn = UIButton.init(frame: CGRect.init(x: 15, y: 50 * i + 10, width: 20, height: 20))
                
                defaultAddressBtn.layer.borderColor = commonBtnColor.cgColor
                defaultAddressBtn.layer.borderWidth = 1
                defaultAddressBtn.setBackgroundImage(UIImage.init(named: "correct"), for: .normal)
                
                defaultAddressBtn.addTarget(self, action: #selector(setDefaultSEl(sender:)), for: .touchUpInside)
                
                
                let agreeAddresLabel = UILabel.init(frame: CGRect.init(x: Int(defaultAddressBtn.RightX + 10), y: 50 * i + 8, width: Int(SW * 0.5), height: 25))
                agreeAddresLabel.text = "是否设置为默认地址"
                agreeAddresLabel.textColor = commonBtnColor
                agreeAddresLabel.font = UIFont.boldSystemFont(ofSize: 14)
                addSubview(defaultAddressBtn)
                addSubview(agreeAddresLabel)
            }
            
            //绘制线条
            if i == 1 || i == 2 || i == 3 || i == 4 || i == 5 || i == 6 {
                line = UIView(frame: CGRect(x: 0, y: 50 * i, width: Int(UIScreen.main.bounds.width), height: 1))
                
                line.backgroundColor = UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                
                self.addSubview(line)
                
                
            }

            
            let discolreImg = UIImageView()
            discolreImg.frame = CGRect(x: Int(UIScreen.main.bounds.width - 30), y:50 * i + 17, width: 15, height: 15)
            if i == 2 || i == 3 || i == 4 {
//                discolreImg.backgroundColor = UIColor.red
                discolreImg.contentMode = UIViewContentMode.scaleAspectFit
                discolreImg.image = UIImage.init(named: "triangle")
                
                
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.setPickerView))
                discolreImg.isUserInteractionEnabled = true
                discolreImg.addGestureRecognizer(tapGes)
                
                tf.frame = CGRect(x: 80 + 15 , y: 50 * i, width: Int(UIScreen.main.bounds.width - 80 - 30 - 40), height: 50)
            }
            
            self.addSubview(discolreImg)
            self.addSubview(ttetView)
            
            if i == 7 {
                
                //添加背景颜色视图--灰色
                let viewColor = UIView()
                viewColor.frame = CGRect(x: 0, y: 50 * i, width: Int(SW), height: Int(50 * i))
                viewColor.backgroundColor = UIColor.white
                self.addSubview(viewColor)
                
                ///默认按钮
                let defauBtn = UIButton.init(frame: CGRect(x: 10, y: viewColor.BottomY + 5, width: 15, height: 15))
                defauBtn.layer.borderColor = commonBtnColor.cgColor
                addSubview(defauBtn)
                

                
                let btn = UIButton()
                btn.frame = CGRect(x: 10, y: 50 * i + 20, width:  Int(UIScreen.main.bounds.width - 20), height: 40)
                
                btn.backgroundColor = commonBtnColor
                btn.setTitle("保存", for: .normal)
                btn.setTitle("保存", for: .highlighted)
                btn.addTarget(self, action: #selector(GetGoodView.save(sender:)), for: .touchUpInside)
                btn.layer.cornerRadius = 8
                //                btn.addTarget(self, action: #selector(GetGoodsView.touchI), for: .touchUpInside)
                self.addSubview(btn)
   
            }

        }
        
        
        
        //根据tag值赋值
        tfName = viewWithTag(100) as! UITextField
        tfNum = viewWithTag(101) as! TfPlaceHolder
        tfProvince = viewWithTag(102) as! UITextField
        tfCity = viewWithTag(103) as! UITextField
        tfArea = viewWithTag(104) as! UITextField
        tfView = viewWithTag(400) as! UITextView
        
        
        
        //为收获地址添加工具栏
        let textViewToolBar = ToolBar()
        textViewToolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(cancelBtn), target: self)
        tfView.inputAccessoryView = textViewToolBar
        
        //城市、省份、地区
        setPickerView()
        
        //从单例中获取，若没有单例值，则从本地存储加载
        
//        if GetGoodModel.shared.addDic != nil {
//            
//            addDic = GetGoodModel.shared.addDic!
//            
//            tfName.text = addDic["shrname"] as? String
//            tfNum.text = addDic["shrphone"] as? String
//            tfProvince.text = addDic["province"] as? String
//            tfCity.text = addDic["city"] as? String
//            tfArea.text = addDic["area"] as? String
//            tfView.text = addDic["street"] as? String
//            
//
//        } else
//
        
        if detailAddindex == -1 {
            return
        } else {
            guard let readAdd = (localSave.object(forKey: addressArray) as? NSArray)?.mutableCopy() as? NSMutableArray else {
                return
            }
            
            let indexAdd : NSDictionary = (readAdd[detailAddindex] as? NSDictionary)!
            
            //XFLog(message: indexAdd)
            
            tfName.text = indexAdd["shrname"] as? String
            
            tfNum.text = indexAdd["shrphone"] as? String
            
            tfProvince.text = indexAdd["province"] as? String
            
            tfCity.text = indexAdd["city"] as? String
            
            tfArea.text = indexAdd["area"] as? String
            
            tfView.text = indexAdd["street"] as? String
            
            
            //成为第一响应
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.tfName.becomeFirstResponder()
            }

        }

    }
    
    //单机完成,键盘收缩
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        self.endEditing(true)
        switch textField.tag {
        case 100:
            self.tfName.resignFirstResponder()
            self.tfNum.becomeFirstResponder()
            break
            
        case 101:
            self.tfNum.resignFirstResponder()
            self.tfProvince.becomeFirstResponder()
            break
            
        case 102:
            self.tfProvince.resignFirstResponder()
            
            self.tfCity.becomeFirstResponder()
            break
        case 103:
            self.tfCity.resignFirstResponder()
            self.tfArea.becomeFirstResponder()
            self.endEditing(true)
            break
        default:
            
            self.endEditing(true)
            break
        }
        
        
        return true
    }
    
    
    //视图上移动
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.frame = self.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    //textview
    func textViewDidBeginEditing(_ textView: UITextView) {

        animateViewMoving(up: true, moveValue: 200)
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(cancelBtn), target: self)
        textView.inputAccessoryView = toolBar
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false, moveValue: 200)
        self.endEditing(true)
    }
    
}




// MARK:- 城市选择器

extension GetGoodView {
    
    @objc func setPickerView() -> Void {
        

        v = PickerV(frame: CGRect(x: 0, y: UIScreen.main.bounds.width - 100, width: UIScreen.main.bounds.width, height: 200))
        v.backgroundColor = .white
        
        
        let toolBar = ToolBar()
        
        toolBar.seToolBar(confirmTitle: "确定", cancelTitle: "取消", comfirmSEL: #selector(donePicker), cancelSEL: #selector(cancelBtn), target: self)
        
        tfProvince.inputView = v
        tfCity.inputView = v
        tfArea.inputView = v
        tfProvince.inputAccessoryView = toolBar
        tfCity.inputAccessoryView = toolBar
        tfArea.inputAccessoryView = toolBar

    }
    
    /// 现在城市
    @objc func donePicker() {
        // Put something here
        self.endEditing(true)
        
        v.getPickerViewValue { (province, city, area) in

                self.tfProvince.text = province
                self.tfCity.text = city
                self.tfArea.text = area
            
            if self.tfArea.text?.characters.count == 0 {
               self.tfArea.text = "  "
            }
        }
    }
    
    /// 工具类取消按钮
    @objc func cancelBtn() {
        // Put something here
        self.endEditing(true)
        
    }
}

// MARK:- 城市选择器单机事件


// MARK:- 单击事件
extension GetGoodView {
    
    //保存信息
    @objc func save(sender : UIButton) -> Void {

        
        self.endEditing(true)

        //动画
        addPopSpringAnimate(_view: sender)
        
        //延时
        sender.zhw_acceptEventInterval = 1
        
        GetGoodModel.shared.goodInfo(tfName: tfName, tfNum: tfNum, tfProvince: tfProvince, tfCity: tfCity, tfcityLocal: tfCity, tfArea: tfArea, tfDetailAddress: tfView) { (result) in
            
            if result == "修改地址成功" {
                self.delegate?.backToGood()

                //保存后显示在单例中
                GetGoodModel.shared.shrName = self.tfName.text
                GetGoodModel.shared.shrphone = self.tfNum.text
                GetGoodModel.shared.province = self.tfProvince.text
                GetGoodModel.shared.city = self.tfCity.text
                GetGoodModel.shared.area = self.tfArea.text
                GetGoodModel.shared.street = self.tfView.text

            } else if result == "添加地址成功" {
                self.delegate?.backToGood()
            }
        }
    }
}

// MARK:- 默认地址事件
extension GetGoodView {
     @objc fileprivate func setDefaultSEl(sender : UIButton) -> Void {
        
        
        
        
        sender.isSelected = !sender.isSelected
        
        
        if sender.isSelected {
        
            issetBtn = false
            sender.setBackgroundImage(UIImage.init(), for: .normal)
        } else {
            issetBtn = true
            sender.setBackgroundImage(UIImage.init(named: "correct"), for: .normal)
        }
        
        //XFLog(message: issetBtn)
    }
}

















