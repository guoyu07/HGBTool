//
//  HGBCustomEncryptTool.m
//  VirtualCard
//
//  Created by huangguangbao on 2017/6/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "HGBCustomEncryptTool.h"
#import "HGBEncryptTool.h"

#define RSAKEY @"hcdbhjsdbcdchsdb"
#define RSAcerPath @"hcdbhjsdbcdchsdb"
#define RSAp12Path @"hcdbhjsdbcdchsdb"

#define DESKEY @"hcdbhjsdbcdchsdb"
#define AESKEY @"hcdbhjsdbcdchsdb"
#define TTAlgorithmSM4_KEY @"hcdbhjsdbcdchsdb"
#define TTAlgorithmSM4_IV @"UISwD9fW6cFh9SNS"
#define SALTString @"SCHJxN49XQvaLM3YSasKeMQd090803sa1ds5"


@implementation HGBCustomEncryptTool

#pragma mark 特殊字符编码
/**
 特殊字符编码
 
 @param string 字符串
 @return 编码后字符串
 */
+ (NSString *)specialStringEncodingWithString:(NSString *)string{
    return [HGBEncryptTool specialStringEncodingWithString:string];
}
/**
 特殊字符解码
 
 @param string 字符串
 @return 编码后字符串
 */
+ (NSString *)specialStringDecodingWithString:(NSString *)string{
    return [HGBEncryptTool specialStringDecodingWithString:string];
}
#pragma mark Base64-string
/**
 Base64编码-string
 
 @param string 字符串
 @return 编码后字符串
 */
+(NSString *)encryptStringWithBase64:(NSString *)string{
    return [HGBEncryptTool encryptStringWithBase64:string];
}

/**
 Base64解码-string
 
 @param string 字符串
 @return 解码后字符串
 */
+(NSString *)decryptStringWithBase64:(NSString *)string{
    return [HGBEncryptTool decryptStringWithBase64:string];
}

#pragma mark Base64-DataToSting
/**
 Base64编码-DataToSting
 @param data 数据
 @return 编码后字符串
 */
+(NSString *)encryptDataToStringWithBase64:(NSData *)data{
    return [HGBEncryptTool encryptDataToStringWithBase64:data];
}

/**
 Base64解码-DataToSting
 
 @param string 字符串
 @return 解码后字符串
 */
+(NSData *)decryptStringToDataWithBase64:(NSString *)string{
    return [HGBEncryptTool decryptStringToDataWithBase64:string];
}

#pragma mark Base64-data
/**
 Base64编码-data
 @param data 数据
 @return 编码后字符串
 */
+(NSData *)encryptDataWithBase64:(NSData *)data{
   return [HGBEncryptTool encryptDataWithBase64:data];
}

/**
 Base64解码-data
 
 @param data 数据
 @return 解码后字符串
 */
+(NSData *)decryptDataWithBase64:(NSData *)data{
    return [HGBEncryptTool decryptDataWithBase64:data];
}

#pragma mark RSA-file
/**
 RSA加密－不编码
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithFileRSA:(NSString *)string{
    return [HGBEncryptTool encryptStringWithRSA:string andWithPath:RSAcerPath];
}

/**
 RSA加密－编码
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithFileRSAEncoding:(NSString *)string{
        return [HGBEncryptTool encryptStringWithRSAEncoding:string andWithPath:RSAcerPath];
}
/**
 RSA解密
 
 @param string 字符串
 @return 解密后字符串
 */
+(NSString *)decryptStringWithFileRSA:(NSString *)string{
    
    NSString* decryptString = [HGBEncryptTool decryptStringWithRSA:string andWithPath:RSAp12Path andWithPassWord:RSAKEY];
    return decryptString;
}
#pragma mark RSA-key
/**
 RSA加密－编码
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithKeyRSAEncoding:(NSString *)string{
    return [HGBEncryptTool encryptStringWithRSAEncoding:string andWithKey:RSAKEY];
}

/**
 RSA加密－不编码
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithKeyRSA:(NSString *)string{
    return [HGBEncryptTool encryptStringWithRSA:string andWithKey:RSAKEY];
}
/**
 RSA解密
 
 @param string 字符串
 @return 解密后字符串
 */
+(NSString *)decryptStringWithKeyRSA:(NSString *)string{
    return [HGBEncryptTool decryptStringWithRSA:string andWithKey:RSAKEY];
}
#pragma mark DES
/**
 DES加密
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithDES:(NSString *)string{
    return [HGBEncryptTool encryptStringWithDES:string andWithKey:DESKEY];
}
/**
 DES解密
 
 @param string 字符串
 @return 解密后字符串
 */
+(NSString *)decryptStringWithDES:(NSString *)string{
    return  [HGBEncryptTool decryptStringWithDES:string andWithKey:DESKEY];
}
#pragma mark AES256-string
/**
 AES256加密
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithAES256:(NSString *)string{
    return [HGBEncryptTool encryptStringWithAES256:string andWithKey:AESKEY];
}
/**
 AES256解密
 
 @param string 字符串
 @return 解密后字符串
 */
+(NSString *)decryptStringWithAES256:(NSString *)string{
    return [HGBEncryptTool decryptStringWithAES256:string andWithKey:AESKEY];
}

#pragma mark AES256-data
/**
 AES256加密
 
 @param data 数据
 @return 加密后数据
 */
+(NSData *)encryptDataWithAES256:(NSData *)data{
    return [HGBEncryptTool encryptDataWithAES256:data andWithKey:AESKEY];
}
/**
 AES256解密
 
 @param data 数据
 @return 解密后数据
 */
+(NSData *)decryptDataWithAES256:(NSData *)data{
    return [HGBEncryptTool decryptDataWithAES256:data andWithKey:AESKEY];
}

#pragma mark  MD5
/**
 MD5加密-32小写
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithMD5_32LOW:(NSString *)string{
    return [HGBEncryptTool encryptStringWithMD5_32LOW:string];
}
/**
 MD5加密-32大写
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithMD5_32UP:(NSString *)string{
    return [HGBEncryptTool encryptStringWithMD5_32UP:string];
}
#pragma mark  MD5-16
/**
 MD5加密-16小写
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithMD5_16LOW:(NSString *)string{
    return [HGBEncryptTool encryptStringWithMD5_16LOW:string];
}
/**
 MD5加密-16大写
 
 @param string 字符串
 @return 加密后字符串
 */
+(NSString *)encryptStringWithMD5_16UP:(NSString *)string{
    return [HGBEncryptTool encryptStringWithMD5_16UP:string];
}
#pragma mark sha1加密
/**
 *  sha1加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString*)encryptStringWithsha1:(NSString*)string{
    return [HGBEncryptTool encryptStringWithsha1:string];
}

#pragma mark 哈希字符串拼接
/**
 哈希字符串拼接
 
 @param dic 字典
 @return hash字符串
 */
+(NSString *)transDicToHashString:(NSDictionary *)dic andWithSalt:(NSString *)salt{
    return [HGBEncryptTool transDicToHashString:dic andWithSalt:SALTString];
}
#pragma mark 国密算法-CBC

/**
 *  TTAlgorithmSM4-CBC加密
 *
 *  @param string 要保存的value值
 */
+ (NSString *)encryptStringWithTTAlgorithmSM4_CBC:(NSString *)string{
    return [HGBEncryptTool encryptStringWithTTAlgorithmSM4_CBC:string andWithKey:TTAlgorithmSM4_KEY andWithIV:TTAlgorithmSM4_IV];
}
/**
 *  TTAlgorithmSM4-CBC解密
 *
 *  @return 获取的对象
 */

+(NSString *)decryptStringWithTTAlgorithmSM4_CBC:(NSString *)string{
    return [HGBEncryptTool decryptStringWithTTAlgorithmSM4_CBC:string andWithKey:TTAlgorithmSM4_KEY andWithIV:TTAlgorithmSM4_IV];
}
#pragma mark 国密算法-ECB

/**
 *  TTAlgorithmSM4-ECB加密
 *
 *  @param string 要保存的value值
 */
+ (NSString *)encryptStringWithTTAlgorithmSM4_ECB:(NSString *)string{
    return [HGBEncryptTool encryptStringWithTTAlgorithmSM4_ECB:string andWithKey:TTAlgorithmSM4_KEY];
}
/**
 *  TTAlgorithmSM4-ECB解密
 *
 *  @return 获取的对象
 */

+(NSString *)decryptStringWithTTAlgorithmSM4_ECB:(NSString *)string{
    return [HGBEncryptTool decryptStringWithTTAlgorithmSM4_ECB:string andWithKey:TTAlgorithmSM4_KEY];
}
@end
