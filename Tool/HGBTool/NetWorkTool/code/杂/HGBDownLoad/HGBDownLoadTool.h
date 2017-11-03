//
//  HGBDownLoadTool.h
//  HelloCordova
//
//  Created by huangguangbao on 2017/7/11.
//
//

#import <Foundation/Foundation.h>
#import "HGBDownLoadTool.h"
@interface HGBDownLoadTool : NSObject
/**
 下载

 @param urlPath 下载链接
 @param path 存储地址
 @param completeBlock 结果
 */

+(void)downLoadAndDecompressWith:(NSString *)urlPath andWithStoreFile:(NSString *)path andWithCompleteBlock:(void (^)(BOOL state))completeBlock;
@end
