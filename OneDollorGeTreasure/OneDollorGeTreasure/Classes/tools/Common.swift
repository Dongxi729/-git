//
//  ViewController.swift
//  DollarBuy
//
//  Created by 郑东喜 on 2016/11/1.
//  Copyright © 2016年 郑东喜. All rights reserved.
//  pch文件

import Foundation
import UIKit

let comStrURL = "yungou.ie1e.com"

//let comStrURL = "shop.ie1e.com"
//let comStrURL = "www.chengyishangwu2017.com"

//QQID
let QQAppID = "1105783215"


//微信应用app iD
let WXPatient_App_ID = "wx72ef50bd213b7232"
let WXPatient_App_Secret = "fca39841591b0823da05b59bfb77f0a1"
///商户ID
let wxPartnerId = "1435473602"


let WX_ACCESS_TOKEN = "access_token"
let WX_OPEN_ID = "openid"
let WX_REFRESH_TOKEN = "refresh_token"
let WX_UNION_ID = "unionid"
let WX_BASE_URL = "https://api.weixin.qq.com/sns"

///接口前缀
let urlPrefix = "http://\(comStrURL)/ifs/"

///网页前缀
let netPrefix = "http://\(comStrURL)/app/"

// MARK:- 网页拦截地址
//首页
let mainPageURl = "\(netPrefix)\("index.aspx?devtype=1")"

//服务区
let fwqURL = "\(netPrefix)\("fwq.aspx")"

//交流区
let jlqURL = "\(netPrefix)\("jlq.aspx")"

// MARK:- 请求地址

///分类--第一级别
let categorOne = "\(urlPrefix)\("class_one.ashx")"

///分类--第二级别
let categorTwo = "\(urlPrefix)\("class_two.ashx")"


///发送验证码
let sendMsgUrl = "\(urlPrefix)\("sendcode.ashx")"

///注册reg.ashx
let rigisterUrl = "\(urlPrefix)\("reg.ashx")"

///忘记密码pwdfind.ashx
let forgetPassUrl = "\(urlPrefix)\("pwdfind.ashx")"

///登陆login.ashx
//let loginUrl = "\(urlPrefix)\("login.ashx")"
let loginUrl = "\(urlPrefix)\("login.ashx")"

///收货地址address.ashx
let addressUrl = "\(urlPrefix)\("address.ashx")"

///修改密码pwdchange.ashx
let xgPass = "\(urlPrefix)\("pwdchange.ashx")"

///退出接口logout.ashx
let logoutURL = "\(urlPrefix)\("logout.ashx")"

///第三方接口oauth.ashx
let oauthURL = "\(urlPrefix)\("oauth.ashx")"

///设备ID，暂时未定值
let deviceID = "zdx123"

///设备类型设备类型 0：Android 1：IOS
let deviceTpye = 1

//保存个人信息baseinfo.ashx
let baseinfoURL = "\(urlPrefix)\("baseinfo.ashx")"

///修改个人信息updpersoninfo.ashx
let updpersoninfoURL = "\(urlPrefix)\("updpersoninfo.ashx")"


///修改个人头像upphoto.ashx
let upphotoURL = "\(urlPrefix)\("upphoto.ashx")"

///绑定bd.ashx
let bdURL = "\(urlPrefix)\("bd.ashx")"


///设置账号密码（用于第三方登陆）setacct.ashx
let setacctURL = "\(urlPrefix)\("setacct.ashx")"

///积分
let integrallogURL = "\(urlPrefix)\("integrallog.ashx")"

///购物车
let shooppingCarURL = "http://\(comStrURL)/app/cart.aspx"

///交易明细
let jiaoyiURL = "http://\(comStrURL)/app/user_jymx.aspx"

///中奖记录
let awardURL = "http://\(comStrURL)/app/user_zjjl.aspx"

///兑换记录
let changeRocordURL = "http://\(comStrURL)/app/user_dhjl.aspx"

///分享有礼
let shareGiftURL = "http://www.feng.com/"

// MARK:- 支付回调地址

//支付成功
let paySuccessURL = "http://\(comStrURL)/app/pay_result_ok.aspx"

//支付失败
let payFailURL = "http://\(comStrURL)/app/pay_result_error.aspx"

//注册协议链接
let rigURL = "http://\(comStrURL)/app/fwq_list_edit.aspx?id=1"


/// 服务区链接
let category_URL = "http://\(comStrURL)/app/fwq.aspx"

/// 首页链接
let firPage_URL = "http://\(comStrURL)/app/index.aspx"

/// 交流区
let server_URL = "http://\(comStrURL)/app/jlq.aspx"

/// 优惠券地址链接
let coupon_URl = "http://\(comStrURL)/app/coupon.aspx"

/// 兑换优惠券链接
let couponReceive_URl = "http://\(comStrURL)/app/coupon_receive.aspx"

/// 优惠券请求接口地址
let couponURL = "\(urlPrefix)\("coupon.ashx")"

// MARK:- 提示语
//提示语
let setPassSuc = "设置密码成功"
let tfNumIsNull = "手机号不能为空"
let tfNumNotCor = "手机号格式不对"
let tfPassNull = "密码不能为空"
let tfAutoNull = "验证码不能为空"
let passTwoChekc = "两次密码不一致"
let tfAuthWrong = "验证码错误"
let loginSuccess = "恭喜您登录成功"
let changePassSuccess = "密码修改成功"
let rigSuccess = "注册成功，恭喜您成为一元预购的新成员"
let msgSengWrong = "发送失败,请重试"
let passAndAccountNot = "帐号与密码不匹配"
let numUsed = "手机号已被注册"
let msgSended = "短信发送成功,请查收"
let confirPassNotNull = "确认密码不能为空"
let authNumWrong = "短信验证码错误"
let netWrong = "服务器繁忙,请重试..."
let agressLawing = "请同意协议"
let changePasSuccess = "你的密码修改成功"
let passNotCor = "原始密码错误"
let confirmPassNull = "确认密码为空"
let passNewNil = "新密码不能为空"
let tokenNotifi = "tokenNotifi"
let phoneNotExist = "手机号不存在"
let loginError = "该账号已在异地登录，请重新登录"
let addressAddSuccess = "添加地址成功"
let addresUpdateSuccess = "修改地址成功"
let changeAddressFail = "尝试修改地址失败"
let loginFirst = "请先登陆"
let bindSuccess = "绑定成功"
let nickNameNotNull = "昵称不为空"
let bindPassSuccess = "密码设置成功"
let logoutSuccess = "退出成功"
let uploadHeadImgSuccess = "上传头像成功"
let setPerInfoSuc = "设置用户信息成功"
let nickNameWrong = "缺少昵称"
let authSuccess = "授权登陆成功"
let phoneHaved = "该手机号已存在"
let addPeronNotNull = "收货人地址不能为空"
let provinceNull = "省份不能为空"
let cityNull = "城市不能为空"
let areaNull = "地区不能为空"
let detailAddNull = "详细地址不能为空"

let unKnown = "未知错误"

// MARK:- 第三方登陆返回信息
//qq openID
let qqopenID = "qqopenID"

//qq headimg
let qqHeadImg = "qqHeadImg"

//qq nickName
let qqNickName = "qqNickName"


//微信 openID
let wxopenID = "wxopenID"

//微信头像地址
let wxHeadImgURL = "wxHeadImgURL"


//微信昵称
let wxNickName = "wxNickName"

//第三方平台
enum thirdLoginType : Int {
    case qq
    case weixin
    case weibo
}


// MARK:- 本地信息存储
//用户动态标识ID
let userToken = "userToken"

//本地存储
let localSave = UserDefaults.standard

//同意协议
let agreeLaw = "agreeLaw"

//非uiviewcontroller控制器
let nav = UIApplication.shared.keyWindow?.rootViewController

//用户个人信息
let personInfo = "personInfo"

//用户收货地址
let personAddData = "personAddData"




//登陆用户名
let localName = "localName"
//登陆用户名密码
let localPass = "localPass"

//头像本地缓存
let headImgCache = "headImgCache"

//头像微信缓存
let wxheadImgCache = "wxheadImgCache"

//QQ微信缓存
let qqheadImgCache = "qqheadImgCache"

//表头视图tag -- 头像
let myHeadImgTag = 112
//表头视图tag -- 账号
let myHeadTelTag = 111
////退出tag
//let myheadLogout = 113

//授权登陆是否有设置密码
let thirdHavePass = "thirdHavePass"

///积分
let jifenArray = "jifenArray"

///积分
let addressArray = "addressArray"

// MARK:- 第三方授权后的信息
let u_qName = "u_qName"

//qq授权后的图片地址
let u_qheadImgURL = "u_qheadImgURL"

//微信授权后的名称
let wx_qName = "wx_qName"

//微信授权后的图片地址
let wx_qheadImgURL = "wx_qheadImgURL"

//第三方登陆后信息
let thirdLoginInfo = "thirdLoginInfo"


// MARK:- 第三方登陆通知
//qq登陆通知名称
let qqNotifi = "qqNotifi"

//微信登陆通知名称
let wxNotifi = "wxNotifi"

//退出登陆
let logoutNotifi = "logout"

//上传头像成功
let uploadHeadSucces = "uploadHeadSucces"

//绑定手机号成功
let bindPhoneSuc = "bindPhoneSuc"

///背景颜色
let commonBgColor = UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)

///统一按钮颜色
let commonBtnColor = #colorLiteral(red: 0.9450980392, green: 0.3254901961, blue: 0.3254901961, alpha: 1)



// MARK:- 常量
//宽度--获取当前屏幕宽度
let SW = UIScreen.main.bounds.size.width

//宽度--获取当前屏幕高度
let SH = UIScreen.main.bounds.size.height

// MARK:- 微信请求的参数、openID 、头像地址、昵称
let wid = "wxopenID"
let wHUrl = "wxheadImgUrl"
let wNickName = "wNickName"

// MARK:- QQ请求的参数、openID 、头像地址、昵称
let qid = "qqopenID"
let qHUrl = "qqheadImgUrl"
let qNickName = "qNickName"

// MARK:- 网络工具类
//POST请求
func postWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
    
    
    //(1）设置请求路径
    let url:NSURL = NSURL(string:path)!//不需要传递参数
    
    //(2) 创建请求对象
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL) //默认为get请求
    request.timeoutInterval = 5.0 //设置请求超时为5秒
    request.httpMethod = "POST"  //设置请求方法
    
    
    //设置请求体
    //拼接URL
    var i = 0
    var address: String = ""
    
    if let paras = paras {
        
        for (key,value) in paras {
            
            if i == 0 {
                
                address += "\(key)=\(value)"
            }else {
                
                address += "&\(key)=\(value)"
            }
            
            i += 1
        }
    }
    
    //把拼接后的字符串转换为data，设置请求体
    request.httpBody = address.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
    
    //(3) 发送请求
    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
        //返回主线程执行
        DispatchQueue.main.sync {
            
            if let data = data {
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    
                    success(result)
                    
                }
                
            }else {
                failure(error!)
            }
            
        }
    }
}

// MARK:- get请求
func getWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
    
    var i = 0
    var address = path
    if let paras = paras {
        
        for (key,value) in paras {
            
            if i == 0 {
                
                address += "?\(key)=\(value)"
            }else {
                
                address += "&\(key)=\(value)"
            }
            
            i += 1
        }
    }
    
    let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: url!) { (data, respond, error) in
        
        if let data = data {
            
            if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                
                success(result)
            }
        }else {
            
            failure(error!)
        }
    }
    dataTask.resume()
    
}


///上传图片
/**
 ## 上传图片（二进制流）
 
 
 - imgData      转换好的图片二进制流
 - paras        上传的参数
 - path         上传接口
 */
func postWithImageWithData(imgData : Data ,path: String,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
    
    
    //(1）设置请求路径
    let url:NSURL = NSURL(string:path)!//不需要传递参数s
    
    //1.创建可变请求
    let request = NSMutableURLRequest.init(url: url as URL)
    
    
    //2.设置上传
    request.httpBody = imgData
    request.timeoutInterval = 20.0 //设置请求超时为5秒
    request.httpMethod = "POST"  //设置请求方法
    
    
    //(3) 发送请求
    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
        //返回主线程执行
        DispatchQueue.main.sync {
            
            if let data = data {
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    
                    success(result)
                }
                
            }else {
                failure(error!)
            }
            
        }
    }
}


///剪切图片
/**
 ## 剪切图片
 - img     图片
 - size    图片裁剪大小
 */
func scaleToSize(img : UIImage,size :CGSize) -> UIImage {
    UIGraphicsBeginImageContext(size)
    img.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let endImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return endImage!
    
}

/**
 扩展String的 MD5加密
 */
extension String
{
    func md5() -> String
    {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
}


// MARK:- uiview分类扩展
extension UIView {

    var LeftX: CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    var RightX: CGFloat {
        get {
            return self.frame.origin.x + self.bounds.width
        }
    }
    var TopY: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    var BottomY: CGFloat {
        get {
            return self.frame.origin.y + self.bounds.height
        }
    }
    var Width: CGFloat {
        get {
            return self.bounds.width
        }
    }
    var Height: CGFloat {
        get {
            return self.bounds.height
        }
    }

}

///存放网页URL--首页
var mainIndexArray = NSMutableArray()

///存放网页URL--服务区
var fwqArray = NSMutableArray()

///存放网页URL--交流区
var commuArray = NSMutableArray()

///购物车URL -- 购物车
var shoppingCarArray = NSMutableArray()


///交易明细
var jiaoYIArray = NSMutableArray()

///中奖纪录
var zhongjiangArray = NSMutableArray()

///兑换有礼
var duihuanArray = NSMutableArray()

///分享有礼
var fenxiangArray = NSMutableArray()

///分类数组
var separateArrey = NSMutableArray()

var dicc = ["-1" : "系统错误",
            "0":"请求成功",
            "4000":"需要GET请求",
            "4001":"需要POST请求",
            "40002": "缺少设备标识符参数",
            "40003": "缺少用户名参数",
            "40004": "缺少类型参数",
            "40005": "缺少用户标识符参数",
            "40006": "缺少验证码参数",
            "40007": "缺少手机号码参数",
            "40008": "缺少身份标识参数",
            "40009": "缺少生日参数",
            "40010": "缺少信用卡参数",
            "40011": "缺少密码参数",
            "40012": "缺少性别参数",
            "40013": "缺少旧密码参数",
            "40014": "缺少新密码参数",
            "40015": "缺少图片参数",
            "40016": "缺少省份参数",
            "40017": "缺少城市参数",
            "40018": "缺少地区参数",
            "40019": "缺少street参数",
            
            //登陆注册
            "40100": "帐号与密码不匹配",
            "40101": "手机号已经被注册",
            "40102": "发送短信失败",
            "40103": "注册短信验证码错误",
            "40104": "注册帐号失败",
            "40105": "手机号不存在",
            "40107": "该账号已在异地登录，请重新登录",
            //个人资料
            "40106": "原始密码错误",
            "40200": "修改密码失败",
            "40201": "所在地区不在覆盖范围",
            "40202": "修改个人资料失败",
            "40203": "获取个人资料失败",
            "40204": "找回密码失败",
            "40205": "上传用户头像失败",
            
            "404" : "不可设置密码"
        ]




extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}


func XFLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):line:\(lineNumber)]- \(message)")
        
    #endif
}

/// 输出日志
///
/// - Parameters:
///   - message: 输出日志
///   - logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
///   - file: 文件名
///   - method: 方法名
///   - line: 代码行数
func CCog(message : Any,
          logError: Bool = false,
          file: String = #file,
          method: String = #function,
          line: Int = #line)
{
    if logError {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        
        print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method) : \(message)")
    } else {
        #if DEBUG
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm:ss"
            print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method) : \(message)")
        #endif
    }
}

/// 输出日志记录
///
/// - Parameters:
///   - logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
///   - file: 文件名
///   - method: 方法名
///   - line: 代码行数
func CCog(logError: Bool = false,
          file: String = #file,
          method: String = #function,
          line: Int = #line)
{
    if logError {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        
        print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method)")
    } else {
        #if DEBUG
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm:ss"
            print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method)")
        #endif
    }
}


//检车机型
public extension UIDevice {
    var modelName: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString = String()
        
        if DEVICE_IS_SIMULATOR == true
        {
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
            
           
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8 , value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        switch machineString {
        case "iPod4,1":                                 return "iPod Touch 4G"
        case "iPod5,1":                                 return "iPod Touch 5G"
        case "iPod7,1":                                 return "iPod Touch 6G"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone 9,4":                 return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7 inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9 inch)"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}

// MARK:- 屏幕放大比例
let screenScale = UIScreen.main.bounds.width / 320

/// 按钮动画效果
///
/// - Parameter _view: 添加到的按钮
func addPopSpringAnimate(_view : UIView) -> Void {
    let sprintAnimation : POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPViewScaleY)
    sprintAnimation.velocity = NSValue.init(cgPoint: CGPoint.init(x: 8, y: 8))
//    _view.cs_acceptEventInterval = 1
    sprintAnimation.springBounciness = 25
    _view.pop_add(sprintAnimation, forKey: "sendAnimation")
}

func _leftRight(_view : UIView) -> Void {
    let sprintAnimation : POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerPositionX)

    sprintAnimation.springBounciness = 20
    sprintAnimation.velocity = 3000
    _view.pop_add(sprintAnimation, forKey: "shakePassword")
}

// MARK:- 提示语
func showWithAlert(alertStr : String) {
    MBManager.showBriefAlert(alertStr)
}


// MARK:- 屏幕放大比例
let SCREEN_SCALE = UIScreen.main.bounds.width / 320

/// 提示语言
///
/// - Parameter alrtMSg: <#alrtMSg description#>
func toast(alrtMSg : String) {
    MBManager.showBriefAlert(alrtMSg)
}
