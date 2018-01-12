//
//  PayConfirmingVC.swift
//  Alili
//
//  Created by 郑东喜 on 2016/12/16.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  支付结果确认中---

import UIKit

class PayConfirmingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CustomAlertView.shared.alertWithTitle(strTitle: "支付结果确认中...")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
