//
//  AutoSolVC.swift
//  Alili
//
//  Created by 郑东喜 on 2017/1/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  解决蜂窝网络权限

import UIKit

class AutoSolVC: BaseViewController,UIScrollViewDelegate {
    
    var scrollView: UIScrollView?
    
    var images: NSMutableArray = NSMutableArray(capacity: 2)
    
    var numLab = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.navigationController?.viewControllers.count)! > 0 {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.black]
            
            UIApplication.shared.statusBarStyle = .default
            
        } else {
            
            self.navigationController?.navigationBar.barTintColor = commonBtnColor
            
            //文字颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            UIApplication.shared.statusBarStyle = .lightContent
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "解决方案"

        // Do any additional setup after loading the view.
        
        let rect = CGRect(x: 15, y: 15, width: SW - 30, height: SH * 0.3 - 20)
        
        let teextView = UITextView.init(frame: rect)
        
        //不可编辑
        teextView.isEditable = false
        
        ///设置文字
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 20.0
        paragraphStyle.maximumLineHeight = 20.0
        paragraphStyle.minimumLineHeight = 20.0
        let ats = [NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 15.0)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]
        teextView.attributedText = NSAttributedString(string: "1. 前往设置-蜂窝移动网络-锐掌商城,并将开关打开,返回本应用重新下拉刷新即可,若下拉无效可尝试重新开启本应用。\n2. 单击右上角按钮前往设置菜单进行设置。", attributes: ats)
        
        
        teextView.font = UIFont.systemFont(ofSize: 14)
        
        
        view.addSubview(teextView)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "设置", style: .plain, target: self, action: #selector(setCullular))
        
        let scrollRect = CGRect(x: 0, y: SH * 0.3 + 32, width: SW, height: SH * 0.5)
        scrollView = UIScrollView(frame: scrollRect)
        
        self.view.addSubview(scrollView!)
        
       
        //不显示滚动条
        
        scrollView?.showsHorizontalScrollIndicator = false
        
        scrollView?.showsVerticalScrollIndicator = false
        
        //设置分页显示
        
        scrollView?.isPagingEnabled = true
        
        //设置内容视图大小
        
        scrollView?.contentSize = CGSize(width: self.view.frame.size.width * 3, height: SH * 0.5)
        
        scrollView?.delegate = self
        
        numLab = UILabel.init(frame: CGRect(x: 0, y: (scrollView?.BottomY)! + 10, width: SW, height: 30))
        
        numLab.textColor = commonBtnColor
        numLab.textAlignment = .center
        
        numLab.text = "1/3"
        self.view.addSubview(numLab)
        
        //加载图片
        
        for index in 0...2 {

            let image: UIImage! = UIImage(named: "\(index)")
            
            //XFLog(message: index)
            
            let photoScrollView:PhotoScrollView! = PhotoScrollView(frame: CGRect(x: self.view.frame.size.width * CGFloat(index), y: 0, width: SW, height: SH * 0.5))
            
            photoScrollView.tag = 200 + index
            
            photoScrollView.image = image
            photoScrollView.contentMode = .scaleAspectFit
            
            self.scrollView?.addSubview(photoScrollView)
            
        }
    }
    
    
    ///改变文本的值
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        

        let index : Int = Int(scrollView.contentOffset.x) / Int(SW)
        switch index {
        case 0:
            numLab.text = "1/3"
            break
        case 1:
            numLab.text = "2/3"
            break
        case 2:
            numLab.text = "3/3"
            break
        default:
            break
        }
    }


    @objc func setCullular() -> Void {
        let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
        
        if UIApplication.shared.openURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        }
    }
}
