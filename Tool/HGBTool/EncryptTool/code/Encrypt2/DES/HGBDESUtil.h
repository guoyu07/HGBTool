//
//  HGBDESUtil.h
//  测试app
//
//  Created by huangguangbao on 2017/7/6.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 DES加密
 */
@interface HGBDESUtil : NSObject{
    
}

/**
 加密方法
 
 @param plainText 原始字符串
 @param key key
 @return 加密字符串
 */
+ (NSString*)encrypt:(NSString*)plainText WithKey:(NSString *)key;


/**
 解密方法
 
 @param encryptText  加密字符串
 @param key key
 @return 解密字符串
 */
+ (NSString*)decrypt:(NSString*)encryptText WithKey:(NSString *)key;

@end
