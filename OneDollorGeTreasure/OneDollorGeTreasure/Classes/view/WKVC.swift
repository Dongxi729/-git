//
//  WKVC.swift
//  OneDollorGeTreasure
//
//  Created by 郑东喜 on 2018/1/12.
//  Copyright © 2018年 郑东喜. All rights reserved.
//  新的网页webview

import UIKit
import WebKit
import CoreTelephony

class WKBaseViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIGestureRecognizerDelegate {
    
    // MARK:- token
    lazy var token: String = {
        let d : String = String()
        let ddd = localSave.object(forKey: userToken) as? String ?? ""
        return ddd
    }()
    
    /// 是否加载
    private var isLoded = false
    
    //MARK:处理交互
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let msg = message.name
        CCog(message: msg)
        if msg == "login" {
            jsLogin()
        }
        
        if msg == "gotoCart" {
            jumpToShop()
            /// 改变标识
            MemModel.isGotoCard = true
        }
        
        if msg == "submit" {
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            }
        }
    }
    
    // MARK:- 跳转到购物车页面
    @objc private func jumpToShop() -> Void {
        
        if NSStringFromClass(self.classForCoder).contains("ShoppingViewController") {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
            CCog()
            self.tabBarController?.selectedIndex = 3
            MemModel.isGotoCard = true
        }
    }
    
    //MARK:JS-登录
    @objc func jsLogin() {
        if let userToken = localSave.object(forKey: userToken) as? String {
            CCog(message: userToken.count)
            let alertVC = UIAlertController.init(title: "提示", message: loginError, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                /// 删除本地的个人信息
                MemModel.clearUserLocalDefaultData()
                if let nav = self.navigationController {
                    alertVC.dismiss(animated: true, completion: nil)
                    nav.pushViewController(LoginView(), animated: true)
                }
            }))
            
            alertVC.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
            
            if let nav = self.navigationController {
                nav.present(alertVC, animated: true, completion: nil)
            }
        } else {
            let alertVC = UIAlertController.init(title: "提示", message: "您尚未登录，请登录", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
                if let nav = self.navigationController {
                    alertVC.dismiss(animated: true, completion: nil)
                    nav.pushViewController(LoginView(), animated: true)
                }
            }))
            
            alertVC.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
            
            if let nav = self.navigationController {
                nav.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    // MARK:- 全局链接变量
    var url : String = ""
    
    lazy var webView: WKWebView = {
        
        //配置webview
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        //登录
        userContentController.add(self, name: "login")
        // 调往购物车
        userContentController.add(self, name: "gotoCart")
        
        // 提交留言交互 submit
        userContentController.add(self, name: "submit")
        configuration.userContentController = userContentController
        
        let d : WKWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: SW, height: SH - (self.navigationController?.navigationBar.Height)!), configuration: configuration)
        
        /// 添加交互事件
        d.uiDelegate = self
        d.navigationDelegate = self
        d.scrollView.addSubview(refreshControl)
        
        //监听KVO进度条进度
        d.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil) // add observer for key path
        return d
    }()
    
    /// 断网图片
    lazy var lostNetImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SW * 0.35, height: SW * 0.35))
        d.center = view.center
        d.image = #imageLiteral(resourceName: "lostNet4s")
        let tag = UITapGestureRecognizer.init(target: self, action:#selector(self.imgSEL))
        d.isUserInteractionEnabled = true
        d.addGestureRecognizer(tag)
        return d
    }()
    
    /// 网络权限受限制图片
    lazy var autoNetForbid: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SW * 0.35, height: SW * 0.35))
        d.image = UIImage.init(named: "sulution")
        d.center = self.view.center
        d.isUserInteractionEnabled = true
        let soluGes = UITapGestureRecognizer.init(target: self, action: #selector(self.gotoSet))
        d.addGestureRecognizer(soluGes)
        return d
    }()
    
    var isNetForbidMark = false
    
    /// 检测网络是否受限
    @objc func isNetForbid() {
        
        if #available(iOS 9.0, *) {
            let culluarData = CTCellularData()
            
            culluarData.cellularDataRestrictionDidUpdateNotifier = { (state : CTCellularDataRestrictedState) -> Void in
                CCog(message: state.hashValue)
                ///网络受限
                if state.hashValue == 1 {
                    self.isNetForbidMark = true
                } else {
                    self.isNetForbidMark = false
                }
            }
        }
    }
    
    
    /// 断网刷新情况
    @objc private func imgSEL() {
        
        self.lostNetImg.isHidden = true
        
        isNetForbid()
        
        if isNetForbidMark {
            self.autoNetForbid.isHidden = false
        }
        
        if !isNetForbidMark {
            if isLoded {
                self.webView.reload()
            } else {
                self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
            }
        }
        
    }
    
    /// 前往网络设置
    @objc func gotoSet() -> Void {
        self.lostNetImg.isHidden = false
        self.autoNetForbid.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(AutoSolVC(), animated: true)
    }
    
    //MARK:刷新
    lazy var refreshControl: UIRefreshControl = {
        let d : UIRefreshControl = UIRefreshControl.init(frame: self.view.bounds)
        d.addTarget(self, action: #selector(refreshControlSEL(sender:)), for: .valueChanged)
        return d
    }()
    
    @objc func refreshControlSEL(sender : UIRefreshControl) {
        if isLoded {
            self.webView.reload()
            sender.endRefreshing()
        } else {
            self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
            CCog(message: self.url)
            sender.endRefreshing()
        }
    }
    
    
    
    lazy var progressView: UIProgressView = {
        let d:UIProgressView = UIProgressView.init(frame: CGRect.init(x: 0, y: 0, width: SW, height: 20))
        d.tintColor = commonBtnColor
        return d
    }()
    
    // MARK:- 监听进度条值变化
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") { // listen to changes and updated view
            
            CCog(message: webView.estimatedProgress)
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MemModel.isGotoCard {
            if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
                if let nav = self.navigationController {
                    nav.popToRootViewController(animated: true)
                    MemModel.isGotoCard = false
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.webView.navigationDelegate = nil
        self.webView.uiDelegate = nil
        
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(webView)
        view.addSubview(progressView)
        view.addSubview(lostNetImg)
        view.addSubview(autoNetForbid)
        lostNetImg.isHidden = true
        autoNetForbid.isHidden = true
        
        /// 添加返回
        let leftNar = UIBarButtonItem.init(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backSEl))
        if let nav = self.navigationController {
            if nav.viewControllers.count > 1 {
                self.navigationItem.leftBarButtonItem = leftNar
            }
        }
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc func backSEl() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.navigationItem.title = "正在加载中~~~"
    }
    
    //MARK:网页代理
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        isLoded = true
        lostNetImg.isHidden = true
        
        if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
            if let navCounts = self.navigationController?.viewControllers.count {
                CCog(message: navCounts)
                if navCounts > 1 {
                    webView.frame = CGRect.init(x: 0,
                                                y: 0,
                                                width: SW,
                                                height: SH - (self.navigationController?.navigationBar.Height)! - UIApplication.shared.statusBarFrame.height)
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let errrNS : NSError = error as NSError
        CCog(message: errrNS.code)
        
        if errrNS.code == NSURLErrorCancelled {
            return
        } else {
            self.lostNetImg.isHidden = false
        }
    }
    
    // MARK:- 允许拦截
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        url = (navigationAction.request.url?.absoluteString)!
        
        MemModel.tmpUrl = (navigationAction.request.url?.absoluteString) ?? ""
        
        if (navigationAction.request.url?.absoluteString)!.starts(with: "http://" + comStrURL) {
            url = (navigationAction.request.url?.absoluteString)!
            
        } else {
            webView.stopLoading()
            self.lostNetImg.isHidden = false
        }
        
        // MARK: - 分类
        if NSStringFromClass(self.classForCoder).contains("CategoryVC") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated  {
                CCog(message: self.url)
                self.url = commaddURl(adUrl: self.url)
                
                jumpComm(jumpVC: CategoryVC(), str: self.url)
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: CategoryVC())
                decisionHandler(.allow)
            }
        }
        
        
        // MARK: - 首页
        if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
            
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if self.url.contains(firPage_URL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: MainPageViewController(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: MainPageViewController())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 购物车
        if NSStringFromClass(self.classForCoder).contains("ShoppingViewController") {
            if navigationAction.navigationType == WKNavigationType.linkActivated  {
                if self.url.contains(shooppingCarURL) {
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    CCog(message: self.url)
                    
                    jumpComm(jumpVC: ShoppingViewController(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                commJump(yy: ShoppingViewController())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 服务区
        if NSStringFromClass(self.classForCoder).contains("ServiceViewController") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                if self.url.contains(fwqURL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: ServiceViewController(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: ServiceViewController())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 支付失败
        if NSStringFromClass(self.classForCoder).contains("PaySuccessVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if self.url.contains(paySuccessURL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: PaySuccessVC(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: PaySuccessVC())
                decisionHandler(.allow)
            }
        }
        
        if NSStringFromClass(self.classForCoder).contains("PayFailViewController") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if self.url.contains(payFailURL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: PayFailViewController(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: PayFailViewController())
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 兑换纪录  ChangedRecordVC ChangedReplaceView
        if NSStringFromClass(self.classForCoder).contains("ChangedRecordVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                self.url = commaddURl(adUrl: self.url)
                
                if self.url.contains("user_dhjl.aspx?state=0") ||
                    self.url.contains("user_dhjl.aspx?state=1") ||
                    self.url.contains(changeRocordURL) {
                    webView.load(URLRequest.init(url: URL.init(string: self.url)!))
                } else {
                    
                    jumpComm(jumpVC: ChangedRecordVC(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                commJump(yy: ChangedRecordVC())
                
                decisionHandler(.allow)
            }
        }
        
        // MARK: - 中奖记录  ChangedRecordVC ChangedReplaceView
        if NSStringFromClass(self.classForCoder).contains("AwardVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                self.url = commaddURl(adUrl: self.url)
                
                if self.url.contains("user_dhjl.aspx?state=0") ||
                    self.url.contains("user_dhjl.aspx?state=1") ||
                    self.url.contains(changeRocordURL) {
                    webView.load(URLRequest.init(url: URL.init(string: self.url)!))
                } else {
                    jumpComm(jumpVC: AwardVC(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                commJump(yy: AwardVC())
                decisionHandler(.allow)
            }
        }
        
        
        
        if NSStringFromClass(self.classForCoder).contains("RigisterAgreeWebView") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if self.url.contains(rigURL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: RigisterAgreeWebView(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: RigisterAgreeWebView())
                decisionHandler(.allow)
            }
        }
        
        if NSStringFromClass(self.classForCoder).contains("ServerVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if self.url.contains(server_URL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: RigisterAgreeWebView(), str: self.url)
                }
                decisionHandler(.cancel)
                
            } else {
                
                commJump(yy: JiaoYIVC())
                decisionHandler(.allow)
            }
        }
        
        if NSStringFromClass(self.classForCoder).contains("JiaoYIVC") {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                
                if self.url.contains(jiaoyiURL) {
                    
                } else {
                    self.url = commaddURl(adUrl: self.url)
                    
                    jumpComm(jumpVC: JiaoYIVC(), str: self.url)
                }
                decisionHandler(.cancel)
            } else {
                commJump(yy: JiaoYIVC())
                decisionHandler(.allow)
            }
        }
    }
    
    
    @objc func commaddURl(adUrl : String) -> String {
        
        token = localSave.object(forKey: userToken) as? String ?? ""
        var aaa = ""
        if adUrl.contains("?") {
            aaa = adUrl + ("&devtype=1&token=") + (token)
        } else {
            aaa = adUrl + ("?devtype=1&token=") + (token)
        }
        
        return aaa
    }
    
    /// 处理跳出去的域名方法
    ///
    /// - Parameter yy: 传递的控制器
    @objc func commJump(yy : UIViewController) {
        
        if self.url.contains("faqtype=1") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("faqtype=2") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("faqtype=3") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("faqtype=4") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("faqtype=5") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("product_list.aspx") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        /// 订单界面
        if self.url.contains("user_dhjl") && !self.url.contains("token=") {
            webView.stopLoading()
            webView.load(URLRequest.init(url: URL.init(string: commaddURl(adUrl: self.url))!))
        }
        
        
        if self.url.contains("buynow") && !self.url.contains("token=") {
            webView.stopLoading()
        }
        
        if self.url.contains("Informationdetail.aspx")  && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("order_pay") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        if self.url.contains("orderdetail.aspx") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
        
        /// message.aspx
        if self.url.contains("message.aspx") && !self.url.contains("token=") {
            webView.stopLoading()
            jumpComm(jumpVC: yy, str: commaddURl(adUrl: self.url))
        }
    }
    
    
    //MARK:- 控制器跳转
    /// 控制器跳转
    func jumpComm(jumpVC : Any ,str : String) {
        
        // MARK: - 分类
        if NSStringFromClass(self.classForCoder).contains("CategoryVC") {
            let vc = CategoryVC()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        /// 交流区
        if NSStringFromClass(self.classForCoder).contains("ServerVC") {
            let vc = ServerVC()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: - 首页
        if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
            let vc = MainPageViewController()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: - 服务区ServiceViewController
        if NSStringFromClass(self.classForCoder).contains("ServiceViewController") {
            let vc = ServiceViewController()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: - 支付失败PayFailViewController PaySuccessVC
        if NSStringFromClass(self.classForCoder).contains("PaySuccessVC") {}
        
        if NSStringFromClass(self.classForCoder).contains("PayFailViewController") {}
        
        // MARK: - 购物车ShoppingViewController  ShoppingReplaceView  RepplaceVC
        
        if NSStringFromClass(self.classForCoder).contains("ShoppingViewController") {
            let vc = ShoppingViewController()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if NSStringFromClass(self.classForCoder).contains("AwardVC") {
            let vc = AwardVC()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // MARK: - 兑换纪录  ChangedRecordVC ChangedReplaceView
        if NSStringFromClass(self.classForCoder).contains("ChangedRecordVC") {
            let vc = ChangedRecordVC()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // MARK: - 交易明细  JiaoYIVC
        if NSStringFromClass(self.classForCoder).contains("JiaoYIVC") {
            let vc = JiaoYIVC()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if NSStringFromClass(self.classForCoder).contains("RigisterAgreeWebView") {
            let vc = RigisterAgreeWebView()
            vc.url = str
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadFirst(loadURl :String,firstUrl :  String) {
        
        if let nav = navigationController?.viewControllers.count {
            CCog(message: nav)
            if nav == 1 {
                self.url = firstUrl
            }
        }
        
        if let nav = self.navigationController?.viewControllers.count {
            
            if NSStringFromClass(self.classForCoder).contains("ChangedRecordVC") ||
                NSStringFromClass(self.classForCoder).contains("ServiceViewController") ||
                NSStringFromClass(self.classForCoder).contains("RigisterAgreeWebView")
                ||
                NSStringFromClass(self.classForCoder).contains("JiaoYIVC")
            {
                if nav > 2 {
                    self.loadUrlWithNetStatus(loadUrl: loadURl)
                } else {
                    self.loadUrlWithNetStatus(loadUrl: self.commaddURl(adUrl: firstUrl))
                }
            } else {
                if nav > 1 {
                    self.loadUrlWithNetStatus(loadUrl: loadURl)
                } else {
                    self.loadUrlWithNetStatus(loadUrl: self.commaddURl(adUrl: firstUrl))
                }
            }
        }
    }
    
    @objc func loadUrlWithNetStatus(loadUrl : String) {
        
        self.webView.load(URLRequest.init(url: URL.init(string: loadUrl)!))
        
    }
}
