//
//  DatePickerView.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/8.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  城市选择器

import UIKit

class DatePickerView: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   

    let addressArray = ["交易明细","中奖纪录","收获地址","分享有礼"]
    let cityArray = ["收获地址","分享有礼"]

    
    var pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let testCityData = CityData.shareInstance.cityName(provinceIndex: 0)
        
        
//        print(testCityData)
        
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: UIScreen.main.bounds.width - 130, width: UIScreen.main.bounds.width, height: 130))
        pickerView.backgroundColor = UIColor.blue
        view.addSubview(pickerView)
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DatePickerView {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.addressArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        print(cityDataSource.count)
//        return cityDataSource.count
        return 1
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {

        
        if(component == 0)
        {
            return self.addressArray[row]
        }
        else
        {
            return self.cityArray[row]
        }

    }
    
    //监听选择的行列
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\((#file as NSString).lastPathComponent):(\(#line)):(\("选择的行")))")
//        print(row)
        
//        print("\((#file as NSString).lastPathComponent):(\(#line)):(\("选择的列")))")
//        print(component)
    }
}
