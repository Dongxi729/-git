////
////  WKBaseViewController.swift
////  DollBuy
////
////  Created by 郑东喜 on 2016/12/9.
////  Copyright © 2016年 郑东喜. All rights reserved.
////  WKWebView基础类
//
//import UIKit
//import WebKit
//
//import CoreTelephony
//
//var _symbolForH5chosssedef : String = "false"
//
//var shopList : String?
//
///// 当用户留言完毕后，出发此函数，跳转至交流区最初页面
//protocol WKBaseDelegate {
//    func server()
//}
//
//class WKBaseViewController: BaseViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate {
//    
//    var replaceView : UIView = UIView()
//    
//    
//    
//    var webView: WKWebView!
//    
//    //修补所用的view
//    var compassView : UIView = UIView()
//    
//    static let shared = WKBaseViewController()
//    
//    // MARK:- 全局链接变量
//    var url : String = ""
//    
//    // MARK:- 为网络状态
//    var netStatus : String = ""
//    
//    // MARK:- 刷新控件
//    var refreshControl = UIRefreshControl()
//    
//    // MARK:- 进度条
//    var progressView = UIProgressView()
//    
//    // MARK:- 网络加载的路径
//    var urlRequestCache = NSURLRequest()
//    
//    // MARK: - 优惠券
//    let userDefault = UserDefaults.standard
//    var loll = false
//    
//    // MARK:- 分享变量
//    var titleStr : String = ""
//    var desc : String = ""
//    var link : String = ""
//    var imgURL : String = ""
//    
//    // MARK:- 检查刷新加载
//    var situationMark = "loadFailed"
//    
//    // MARK:- 权限按钮
//    let AutoCellularbtn = UIImageView()
//    
//    // MARK:- 刷新图片
//    var imgView = UIImageView()
//    
//    // MARK:- token
//    var token : String = ""
//    
//    //代理
//    var wkDelegate : WKBaseDelegate?
//    
//    /// 网络状态
//    var netThrough = false
//    
//    /// 断网图片单机刷新事件
//    @objc func imgSEL() -> Void {
//        
//        if isLoded {
//            self.webView.reload()
//        } else {
//            self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
//        }
//    }
//    
//    // MARK:- 移除蜂窝权限图片，界面消失的时候
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        self.imgView.isHidden = true
//        AutoCellularbtn.removeFromSuperview()
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if MemModel.isGotoCard {
//            if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
//                if let nav = self.navigationController {
//                    nav.popToRootViewController(animated: true)
//                    MemModel.isGotoCard = false
//                }
//            }
//        }
//        
//        if NetStatusModel.netStatus == 0 {
//            
//            if !self.isLoded {
//                self.imgView.isHidden = false
//            }
//        }
//        
//        
//        if #available(iOS 9.0, *) {
//            
//            let culluarData = CTCellularData()
//            
//            culluarData.cellularDataRestrictionDidUpdateNotifier = { (state : CTCellularDataRestrictedState) -> Void in
//                
//                ///网络受限
//                if state.hashValue == 1 {
//                    
//                    DispatchQueue.main.async {
//                        self.AutoCellularbtn.frame = CGRect(x:SW * 0.25 , y: SH * 0.25, width: SW * 0.5, height: SW * 0.5)
//                        
//                        self.AutoCellularbtn.image = UIImage.init(named: "sulution")
//                        self.AutoCellularbtn.isUserInteractionEnabled = true
//                        self.imgView.isHidden = true
//                        
//                        let soluGes = UITapGestureRecognizer.init(target: self, action: #selector(WKBaseViewController.gotoSet))
//                        
//                        self.AutoCellularbtn.addGestureRecognizer(soluGes)
//                        
//                        self.view.addSubview(self.AutoCellularbtn)
//                        
//                        return
//                    }
//                    
//                    ///网络未受限
//                } else {
//                    self.token = localSave.object(forKey: userToken) as? String ?? ""
//                }
//            }
//        }
//        //取出本地token，进行拼接,token为空不为空，均传到服务器
//        self.token = localSave.object(forKey: userToken) as? String ?? ""
//        
//        /// 监听重新登录的通知
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterLogin), name: NSNotification.Name(rawValue: "reloadWebVewNeed"), object: nil)
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.SETUI()
//        
//        self.imgView.frame = CGRect.init(x: 0, y: 0, width: SW * 0.35, height: SW * 0.35)
//        self.imgView.center = view.center
//        self.imgView.image = #imageLiteral(resourceName: "lostNet4s")
//        let tag = UITapGestureRecognizer.init(target: self, action:#selector(WKBaseViewController.imgSEL))
//        self.imgView.isUserInteractionEnabled = true
//        self.imgView.addGestureRecognizer(tag)
//        view.addSubview(imgView)
//        self.imgView.isHidden = true
//        
//        if let navCount = self.navigationController?.viewControllers.count {
//            
//            if navCount > 1 {
//                if SH == 812 {
//                    self.webView.frame = CGRect.init(x: 0, y:0, width: SW, height: SH - (self.navigationController?.navigationBar.Height)! - (self.tabBarController?.tabBar.Height)!)
//                }
//            }
//        }
//    }
//    
//    @objc func reloadAfterLogin() {
//        
//        if MemModel.shouldReloadFromOrigin {
//            CCog(message: MemModel.tmpUrl)
//            if MemModel.tmpUrl.contains("token=") {
//                var dddA : NSString  = MemModel.tmpUrl as NSString
//                dddA = dddA.replacingCharacters(in: NSRange.init(location: dddA.length - 10, length: 10), with: "") as NSString
//                let finalString : String = dddA as String + (localSave.object(forKey: userToken) as? String ?? "")
//                self.webView.load(URLRequest.init(url: URL.init(string: finalString)!))
//                MemModel.shouldReloadFromOrigin = false
//            } else {
//                self.webView.load(URLRequest.init(url: URL.init(string: commaddURl(adUrl: MemModel.tmpUrl))!))
//            }
//        }
//    }
//    
//    // MARK:- 监听进度条值变化
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if (keyPath == "estimatedProgress") { // listen to changes and updated view
//
//            CCog(message: webView.estimatedProgress)
//            progressView.isHidden = webView.estimatedProgress == 1
//            progressView.setProgress(Float(webView.estimatedProgress), animated: false)
//        }
//    }
//    
//    
//    // MARK:- wkwebview代理方法
//    /// 没网络发起
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        
//        let errrNS : NSError = error as NSError
//        CCog(message: errrNS.code)
//        
//        if errrNS.code == NSURLErrorCancelled {
//            return
//        } else {
//            if !AutoCellularbtn.isHidden == false {
//            } else {
//                if !self.isLoded {
//                    self.imgView.isHidden = false
//                }
//            }
//        }
//    }
//    
//    
//    
//    var isLoded  = false
//    
//    // MARK:- webview加载完成
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        CCog(message: "====")
//        self.imgView.isHidden = true
//        self.navigationItem.title = webView.title
//        self.isLoded = true
//    }
//    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        CCog(message: "didStartProvisionalNavigation")
//    }
//    
//    
//    // MARK:- js交互
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        let msg = message.name
//        
//        if msg == "gotoCart" {
//            
//            jumpToShop()
//            
//        } else if msg == "login" {
//            
//            if let userToken = localSave.object(forKey: userToken) as? String {
//                CCog(message: userToken.count)
//                let alertVC = UIAlertController.init(title: "提示", message: loginError, preferredStyle: .alert)
//                alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
//                    /// 删除本地的个人信息
//                    MemModel.shouldReloadFromOrigin = true
//                    if let nav = self.navigationController {
//                        alertVC.dismiss(animated: true, completion: nil)
//                        nav.pushViewController(LoginView(), animated: true)
//                    }
//                }))
//                
//                alertVC.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
//                
//                if let nav = self.navigationController {
//                    nav.present(alertVC, animated: true, completion: nil)
//                }
//            } else {
//                let alertVC = UIAlertController.init(title: "提示", message: "您尚未登录，请登录", preferredStyle: .alert)
//                alertVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: { (action) in
//                    if let nav = self.navigationController {
//                        alertVC.dismiss(animated: true, completion: nil)
//                        nav.pushViewController(LoginView(), animated: true)
//                    }
//                }))
//                
//                alertVC.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
//                
//                if let nav = self.navigationController {
//                    nav.present(alertVC, animated: true, completion: nil)
//                }
//            }
//            
//            
//        } else if msg == "submit" {
//            
//            self.navigationController?.popViewController(animated: true)
//            
//        } else if msg == "detailRocord" {
//            
//            jumpDetaiRecord()
//            
//        } else if msg == "backToMain" {
//            
//            backToMain()
//            
//            //调到购物车
//        } else if msg == "getCartList" {
//            
//            shopList = message.body as? String
//            
//            ///选择地址
//        } else if msg == "refreshWeb" {
//            
//            self.webView.reload()
//        } else if msg == "personInfo" {
//            
//            gotoPerson()
//        } else if msg == "backToIndex" {
//            gotoMain()
//        }
//    }
//    
//    var rightFooBarButtonItem : UIBarButtonItem?
//    
//    private var keyPath : Int = 0
//    
//    // MARK:- 交互函数
//    /// 返回首页
//    func jumpDetaiRecord() -> Void {
//        let vc = ChangedRecordVC()
//        vc.url = changeRocordURL
//        vc.changeLoadNormal = true
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    // MARK:- 返回首页
//    @objc func backToMain() -> Void {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
//    
//    // MARK:- 跳转到购物车页面
//    func jumpToShop() -> Void {
//        
//        if NSStringFromClass(self.classForCoder).contains("ShoppingViewController") {
//            self.navigationController?.popToRootViewController(animated: true)
//        }
//        
//        if NSStringFromClass(self.classForCoder).contains("MainPageViewController") {
//            CCog()
//            self.tabBarController?.selectedIndex = 3
//            MemModel.isGotoCard = true
//        }
//    }
//    
//    // MARK:- 刷新函数
//    @objc func refreshWebView(sender: UIRefreshControl) {
//        if isLoded {
//            self.webView.reload()
//            sender.endRefreshing()
//        } else {
//            self.webView.load(URLRequest.init(url: URL.init(string: self.url)!))
//            CCog(message: self.url)
//            sender.endRefreshing()
//        }
//    }
//}
//
//// MARK:- 处理收到内存警告---释放webview
//extension WKBaseViewController {
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        self.webView = nil
//    }
//}
//
//// MARK:- 购物车交互事件
//extension WKBaseViewController {
//    ///个人中心
//    func gotoPerson() -> Void {
//        let tabbarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//        tabbarController.selectedIndex = 3
//        
//        Animated.vcWithTransiton(vc: tabbarController, animatedType: "kCATransitionFade", timeduration: 0.5)
//    }
//    
//    ///前往首页
//    func gotoMain() -> Void {
//        let tabbarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//        tabbarController.selectedIndex = 0
//        
//        Animated.vcWithTransiton(vc: tabbarController, animatedType: "kCATransitionFade", timeduration: 0.5)
//    }
//    
//}
//
//// MARK:- 接收支付宝app接收结果
//extension WKBaseViewController {
//    @objc func info(notification : NSNotification) -> Void {
//        
//        if let dic = notification.userInfo as NSDictionary? {
//            if let result = dic["re"] as? String {
//                
//                switch result {
//                case "用户中途取消":
//                    let vc = PayFailViewController()
//                    vc.url = payFailURL
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    break
//                    
//                case "支付成功":
//                    //清楚购物车信息
//                    shopList = nil
//                    let vc = PaySuccessVC()
//                    vc.url = paySuccessURL
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    break
//                    
//                case "正在处理中":
//                    CustomAlertView.shared.alertWithTitle(strTitle: "正在处理中")
//                    break
//                    
//                case "网络连接出错":
//                    CustomAlertView.shared.alertWithTitle(strTitle: "网络连接出错")
//                    break
//                    
//                case "订单支付失败":
//                    let vc = PayFailViewController()
//                    vc.url = payFailURL
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    break
//                default:
//                    break
//                }
//            }
//            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "123"), object: nil)
//        }
//    }
//}
//
//// MARK:- 解决蜂窝网受限
//extension WKBaseViewController {
//    @objc func gotoSet() -> Void {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.navigationController?.pushViewController(AutoSolVC(), animated: true)
//    }
//    
//}
//
//// MARK:- 设置webview
//extension WKBaseViewController {
//    @objc func setWebView() -> Void {
//        self.webView = WKWebView.init(frame: self.view.bounds)
//        view.addSubview(self.webView)
//    }
//}
//
//// MARK:- 设置界面
//extension WKBaseViewController {
//    func SETUI() -> Void {
//        // Do any additional setup after loading the view.
//        
//        
//        self.setWebView()
//        ///http://www.jianshu.com/p/879fe48b0eb7
//        ///edgesForExtendedLayout------见网页链接
//        self.edgesForExtendedLayout = UIRectEdge()
//        
//        //配置webview
//        let configuration = WKWebViewConfiguration()
//        let userContentController = WKUserContentController()
//        
//        //添加交互条目
//        //登陆
//        userContentController.add(self as WKScriptMessageHandler, name: "login")
//        
//        //跳转到购物车
//        userContentController.add(self as WKScriptMessageHandler, name: "gotoCart")
//        
//        //确认提交建议
//        userContentController.add(self as WKScriptMessageHandler, name: "submit")
//        
//        //交易记录
//        userContentController.add(self as WKScriptMessageHandler, name: "detailRocord")
//        
//        //返回首页
//        userContentController.add(self as WKScriptMessageHandler, name: "backToMain")
//        
//        //购物车列表
//        userContentController.add(self as WKScriptMessageHandler, name: "getCartList")
//        
//        ///选择地址
//        userContentController.add(self as WKScriptMessageHandler, name: "chooseAddress")
//        
//        ///刷新网页 - refreshWeb
//        userContentController.add(self as WKScriptMessageHandler, name: "refreshWeb")
//        
//        ///个人中心
//        userContentController.add(self as WKScriptMessageHandler, name: "personInfo")
//        ///随便逛逛（首页）
//        userContentController.add(self as WKScriptMessageHandler, name: "backToIndex")
//        
//        configuration.userContentController = userContentController
//        
//        // 设置偏好设置
//        let preferences = WKPreferences()
//        // 在iOS上默认为NO，表示不能自动通过窗口打开
//        preferences.javaScriptCanOpenWindowsAutomatically = true
//        preferences.minimumFontSize = 10.0
//        configuration.preferences = preferences
//        configuration.preferences.javaScriptEnabled = true
//        configuration.processPool = WKProcessPool()
//        
//        
//        // 禁止选择CSS
//        let css = "body{-webkit-user-select:none;-webkit-user-drag:none;}"
//        
//        // CSS选中样式取消
//        let javascript = NSMutableString.init()
//        
//        javascript.append("var style = document.createElement('style');")
//        javascript.append("style.type = 'text/css';")
//        javascript.appendFormat("var cssContent = document.createTextNode('%@');", css)
//        javascript.append("style.appendChild(cssContent);")
//        javascript.append("document.documentElement.style.webkitUserSelect='none';")
//        javascript.append("document.documentElement.style.webkitTouchCallout='none';")
//
//        
//        
//        // javascript注入
//        let noneSelectScript = WKUserScript.init(source: javascript as String, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
//        
//        userContentController.addUserScript(noneSelectScript)
//        
//        if let nav = self.navigationController?.viewControllers.count  {
//            if nav >= 2 {
//                let rect = CGRect(x: 0, y: 0, width: SW, height: SH - 64)
//                webView = WKWebView.init(frame: rect, configuration: configuration)
//            } else {
//                let rect = CGRect(x: 0, y: 0, width: SW, height: SH - 112)
//                webView = WKWebView.init(frame: rect, configuration: configuration)
//                
//            }
//        }
//        
//        
//        ///配置wkwebview代理
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        
//        view.addSubview(webView)
//        
//        //添加进度条
//        self.progressView = UIProgressView()
//        
//        self.progressView.frame = view.bounds
//        view.addSubview(self.progressView)
//        
//        //默认进度条
//        self.progressView.progressTintColor = commonBtnColor
//        
//        
//        //添加刷新控件8
//        self.refreshControl = UIRefreshControl()
//        
//        //设置刷新控件的位置
//        let offset = -0
//        self.refreshControl.bounds = CGRect(x: refreshControl.bounds.origin.x, y: CGFloat(offset),
//                                            width: refreshControl.bounds.size.width,
//                                            height: refreshControl.bounds.size.height)
//        self.refreshControl.addTarget(self, action: #selector(refreshWebView(sender:)), for: UIControlEvents.valueChanged)
//        self.webView.scrollView.addSubview(refreshControl)
//        
//        //监听KVO进度条进度
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil) // add observer for key path
//    }
//}
//
//class LeakAvoider : NSObject, WKScriptMessageHandler {
//    weak var delegate : WKScriptMessageHandler?
//    init(delegate:WKScriptMessageHandler) {
//        self.delegate = delegate
//        super.init()
//    }
//    
//    
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        self.delegate?.userContentController(
//            userContentController, didReceive: message)
//    }
//    
//}

