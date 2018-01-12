//
//  PickerV.swift
//  hangge_1169_2
//
//  Created by 郑东喜 on 2016/11/29.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  城市选择器

import UIKit

class PickerV: UIView {
    
    
    static let shared = PickerV()
    
    //外部闭包变量
    var getData:((_ _province:String,_ _city:String,_ _area:String)->Void)?
    
    
    //选择器
    var pickerView:UIPickerView!
    
    //所以地址数据集合
    var addressArray = [[String: AnyObject]]()
    
    //选择的省索引
    var provinceIndex = 0
    //选择的市索引
    var cityIndex = 0
    //选择的县索引
    var areaIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化界面
        initView()
        
        //设置背景色
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- UIPickerView 代理和方法
extension PickerV : UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            
            return UIScreen.main.bounds.width / 3
            
        default:
            break
        }
        
        return UIScreen.main.bounds.width / 3
    }
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents( in pickerView: UIPickerView) -> Int{
        return 3
    }
    
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return self.addressArray.count
        } else if component == 1 {
            let province = self.addressArray[provinceIndex]
            return province["cit"]!.count
        } else {
            let province = self.addressArray[provinceIndex]
            if let city = (province["cit"] as! NSArray)[cityIndex] as? [String: AnyObject] {
                return city["dis"]!.count
            } else {
                
                return 0
            }
        }
        
        
        /**
         <dict>
         <key>dis</key>
         <array>
         </array>
         <key>na</key>
         <string>上海辖县</string>
         </dict>
         */
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
            if component == 0 {
                
                return self.addressArray[row]["na"] as? String
            }else if component == 1 {
                let province = self.addressArray[provinceIndex] as NSDictionary
                
                let str = ((province["cit"] as! NSArray)[row] as! NSDictionary)["na"] as! String
                
                
                return str
                
            } else {
                let province = self.addressArray[provinceIndex]
                let city = (province["cit"] as! NSArray)[cityIndex] as! [String: AnyObject]
                
                
                return ((city["dis"] as! NSArray)[row] as! NSDictionary)["na"] as? String
            }
            
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //根据列、行索引判断需要改变数据的区域
        switch (component) {
        case 0:
            provinceIndex = row;
            cityIndex = 0;
            areaIndex = 0;
            pickerView.reloadComponent(1);
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 1, animated: true);
            pickerView.selectRow(0, inComponent: 2, animated: true);
        case 1:
            cityIndex = row;
            areaIndex = 0;
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 2, animated: true);
        case 2:
            areaIndex = row;
            
            
        default:
            break;
        }
    }
    
    //字体大小
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        if component == 0 {
            let a = self.addressArray[row]["na"] as? String
            label?.text = a
            
        }else if component == 1 {
            let province = self.addressArray[provinceIndex] as NSDictionary
            
            let str = ((province["cit"] as! NSArray)[row] as! NSDictionary)["na"] as! String
            
            label?.text = str
        } else {
            let province = self.addressArray[provinceIndex]
            let city = (province["cit"] as! NSArray)[cityIndex] as! [String: AnyObject]
            let c = ((city["dis"] as! NSArray)[row] as! NSDictionary)["na"] as? String
            label?.text = c
        }
        label?.textAlignment = NSTextAlignment.center
        label?.font = UIFont.systemFont(ofSize: 14)
        
        
        return label!
    }
    
    
}

// MARK:- 初始化
extension PickerV {
    func initView() -> Void {
        
        //初始化数据
        let path = Bundle.main.path(forResource: "city", ofType:"plist")
        self.addressArray = NSArray(contentsOfFile: path!) as! Array
        
        //创建选择器
        pickerView=UIPickerView()
        pickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        //将dataSource设置成自己
        pickerView.dataSource=self
        //将delegate设置成自己
        pickerView.delegate=self
        self.addSubview(pickerView)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button=UIButton(frame:CGRect(x: UIScreen.main.bounds.width * 0.5,y: UIScreen.main.bounds.height * 0.5,width: 100,height: 30))
        //        button.center=self.center
        button.backgroundColor=UIColor.blue
        button.setTitle("获取信息",for:UIControlState())
        button.addTarget(self, action:#selector(PickerV.getPickerViewValue),
                         for: UIControlEvents.touchUpInside)
    }
    
    
    //触摸按钮时，获得被选中的索引
    /**
     ## 输入选择的省份、城市、地区
     
     - _province    省份
     - _city        城市
     - _area        地区
     */
    @objc func getPickerViewValue(_getData:@escaping (_ _province:String,_ _city: String,_ _area : String)->Void) -> Void {
        
        //闭包传值
        self.getData = _getData
        
        
        //获取选中的省
        let p = self.addressArray[provinceIndex] as NSDictionary
        let province = p["na"] as! String
        
        //获取选中的市
        let c = (p["cit"] as! NSArray)[cityIndex] as! NSDictionary
        let city = c["na"] as! String
        
        //获取选中的县（地区）
        var area = ""
        
        
        if (c["dis"] as! NSArray).count == 0 {
            
            area = ""
            
            
        } else {
            if (((c["dis"] as! NSArray)[areaIndex]) as! NSDictionary).count > 0 {
                
                let dic = (((c["dis"] as! NSArray)[areaIndex]) as! NSDictionary)["na"] as! String
                
                area = dic
            }
        }
        
        
        //拼接输出消息
        let message = "索引：\(provinceIndex)-\(cityIndex)-\(areaIndex)\n"
            + "值：\(province) - \(city) - \(area)"
        
        self.getData!(province,city,area)
        
        //消息显示
        let alertController = ZDXAlertController(title: "您选择了",
                                                 message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //        self.present(alertController, animated: true, completion: nil)
        //        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        //        print("省份，城市，地区",province,city,area)
        
        
    }
    
}
