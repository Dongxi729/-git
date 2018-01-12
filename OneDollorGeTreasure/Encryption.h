//
//  Encryption.h
//  RunningDog
//
//  Created by 郑东喜 on 2016/10/29.
//  Copyright © 2016年 郑东喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject

//md5加密方法
+ (NSString *)md5EncryptWithString:(NSString *)string;


#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;



@end
