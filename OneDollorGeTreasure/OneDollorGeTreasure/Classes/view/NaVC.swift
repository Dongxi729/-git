//
//  NaVC.swift
//  Alili
//
//  Created by 郑东喜 on 2016/12/20.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

import UIKit

class NaVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }

    
}
