//
//  HGBCompressedFileTool.h
//  HelloCordova
//
//  Created by huangguangbao on 2017/7/11.
//
//

#import <Foundation/Foundation.h>
typedef void(^CompleteBlock)(BOOL status,NSString *prompt);

@interface HGBCompressedFileTool : NSObject
/**
 解压
 @param filePath 文件路径
 @param password 密码
 @param destPath 目标地址
 @param completeBlock 结果
*/
+(void)unArchive: (NSString *)filePath andPassword:(NSString*)password toDestinationPath:(NSString *)destPath andWithCompleteBlock:(CompleteBlock)completeBlock;
/**
  压缩
  @param filePaths 文件路径集合
  @param destPath 目标地址 
  @param completeBlock 结果
*/
+(void)archiveToZipWithFilePaths: (NSArray *)filePaths toDestinationPath:(NSString *)destPath andWithCompleteBlock:(CompleteBlock)completeBlock;
@end
