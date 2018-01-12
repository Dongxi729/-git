
//
//  ShareViewController.swift
//  PresentView
//
//  Created by 郑东喜 on 2016/12/5.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  分享视图控制器

import UIKit

protocol ShareVCDelegate {
    func shareType(__data : Int) -> Void
}

class ShareViewController: UIViewController,ShareViewDelegate {
    
    static let shared = ShareViewController()
    
    var delegate : ShareVCDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.modalPresentationStyle = .custom
        

        setUI()
        
    }
    
    /// 单机视图消失
    ///
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func dismiss() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK:- 设置UI
extension ShareViewController {
    func setUI() -> Void {
        let shareV = ShareView()
        shareV.frame = view.bounds
        shareV.delegate = self
        view.addSubview(shareV)
    }
    
    
    /// 传递分享平台（类型）
    ///
    /// - Parameter __data: 平台类型
    func shareType(__data: Int) {
        
        self.delegate?.shareType(__data: __data)
    }
}
