//
//  HGBCompressedFileTool.m
//  HelloCordova
//
//  Created by huangguangbao on 2017/7/11.
//
//

#import "HGBCompressedFileTool.h"
#import <UIKit/UIKit.h>
#import "LZMAExtractor.h"
#import "SARUnArchiveANY.h"
#import "SSZipArchive.h"
#import "ZipArchive.h"

@interface HGBCompressedFileTool()
@end
@implementation HGBCompressedFileTool
/**
 解压
 
 @param filePath 文件路径
 @param password 密码
 @param destPath 目标地址
 */
+(void)unArchive: (NSString *)filePath andPassword:(NSString*)password toDestinationPath:(NSString *)destPath andWithCompleteBlock:(CompleteBlock)completeBlock{

    if(![HGBCompressedFileTool isExitAtFilePath:filePath]){
        completeBlock(NO,@"file not exist");
        return;
    }

    if(destPath&&[[destPath lastPathComponent] pathExtension].length!=0){
        destPath=[destPath stringByReplacingOccurrencesOfString:[[destPath lastPathComponent] pathExtension] withString:@""];

    }
    if(![HGBCompressedFileTool isExitAtFilePath:destPath]){
        [HGBCompressedFileTool createDirectoryPath:destPath];
    }

    NSAssert(filePath, @"can't find filePath");
    SARUnArchiveANY *unarchive = [[SARUnArchiveANY alloc]initWithPath:filePath];
    if (password != nil && password.length > 0) {
        unarchive.password = password;
    }
    
    if (destPath != nil)
        unarchive.destinationPath = destPath;
        unarchive.completionBlock = ^(NSArray *filePaths){
        NSLog(@"For Archive : %@",filePath);
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"US Presidents://"]]) {
            NSLog(@"US Presidents app is installed.");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"US Presidents://"]];
        }
        
        for (NSString *filename in filePaths) {
            NSLog(@"File: %@", filename);
        }
        completeBlock(YES,@"sucess");
    };
    unarchive.failureBlock = ^(){
        NSLog(@"Cannot be unarchived");
        completeBlock(NO,@"Cannot be unarchived");

    };
    [unarchive decompress];
}
#pragma mark 压缩
/**
  压缩
  @param filePaths 文件路径集合
  @param destPath 目标地址
  @param completeBlock 结果
*/
+(void)archiveToZipWithFilePaths: (NSArray *)filePaths toDestinationPath:(NSString *)destPath andWithCompleteBlock:(CompleteBlock)completeBlock{
    for(NSString *filePath in filePaths){
        if(![HGBCompressedFileTool isExitAtFilePath:filePath]){
            NSLog(@"%@",filePath);
            completeBlock(NO,@"file not exist");
            return;
        }
    }
    if(destPath&&[[destPath lastPathComponent] pathExtension].length!=0){
        destPath=[destPath stringByReplacingOccurrencesOfString:[[destPath lastPathComponent] pathExtension] withString:@"zip"];

    }else{
        destPath=[destPath stringByAppendingString:@"/归档.zip"];
    }
    if([HGBCompressedFileTool isExitAtFilePath:destPath]){
        completeBlock(NO,@"des file  exist");
        return;
    }

    NSString *basePath=[destPath stringByDeletingLastPathComponent];
    if(![HGBCompressedFileTool isExitAtFilePath:basePath]){
        [HGBCompressedFileTool createDirectoryPath:basePath];
    }

    NSString *baseCopyPath=[[HGBCompressedFileTool getTmpFilePath] stringByAppendingPathComponent:[[destPath lastPathComponent] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",[[destPath lastPathComponent] pathExtension]] withString:@""]];

    if([HGBCompressedFileTool isExitAtFilePath:baseCopyPath]){
        [HGBCompressedFileTool removeFilePath:baseCopyPath];
    }

    for(NSString *filePath in filePaths){
        [HGBCompressedFileTool copyFilePath:filePath ToPath:[baseCopyPath stringByAppendingPathComponent:[filePath lastPathComponent]]];
    }

    

    BOOL flag=[self doZipAtDirectoryPath:baseCopyPath to:destPath];
    if(flag){
         completeBlock(YES,@"sucess");
    }else{
         completeBlock(NO,@"Cannot be archived");
    }
     [HGBCompressedFileTool removeFilePath:baseCopyPath];
}

/**
 压缩文件

 @param sourceDirectoryPath 源文件夹
 @param destZipFile 目标文件
 @return 结果
 */
+(BOOL)doZipAtDirectoryPath:(NSString*)sourceDirectoryPath to:(NSString*)destZipFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    ZipArchive * zipArchive = [ZipArchive new];
    [zipArchive CreateZipFile2:destZipFile];
    NSArray *subPaths = [fileManager subpathsAtPath:sourceDirectoryPath];// 关键是subpathsAtPath方法
    for(NSString *subPath in subPaths){
        NSString *fullPath = [sourceDirectoryPath stringByAppendingPathComponent:subPath];
        BOOL isDir;
        if([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && !isDir)// 只处理文件
        {
            [zipArchive addFileToZip:fullPath newname:subPath];
        }
    }
    [zipArchive CloseZipFile2];
    return YES;
}
#pragma mark 文档通用
/**
  文档是否存在

  @param filePath 归档的路径
  @return 结果
*/
+(BOOL)isExitAtFilePath:(NSString *)filePath{
    if(filePath==nil||filePath.length==0){
        return NO;
    }
    NSFileManager *filemanage=[NSFileManager defaultManager];//创建对象
    BOOL isExit=[filemanage fileExistsAtPath:filePath];
    return isExit;
}
/**
 删除文档
 
 @param filePath 归档的路径
 @return 结果
 */
+ (BOOL)removeFilePath:(NSString *)filePath{
    if(filePath==nil||filePath.length==0){
        return YES;
    }
    NSFileManager *filemanage=[NSFileManager defaultManager];//创建对象
    BOOL isExit=[filemanage fileExistsAtPath:filePath];
    BOOL deleteFlag=NO;
    if(isExit){
        deleteFlag=[filemanage removeItemAtPath:filePath error:nil];
    }else{
        deleteFlag=NO;
    }
    return deleteFlag;
}
/**
  文件拷贝

  @param srcPath 文件路径
  @param filePath 复制文件路径
  @return 结果
*/
+(BOOL)copyFilePath:(NSString *)srcPath ToPath:(NSString *)filePath{
    if(![HGBCompressedFileTool isExitAtFilePath:srcPath]){
        return NO;
    }
    NSString *directoryPath=[filePath stringByDeletingLastPathComponent];
    if(![HGBCompressedFileTool isExitAtFilePath:directoryPath]){
        [HGBCompressedFileTool createDirectoryPath:directoryPath];
    }
    NSFileManager *filemanage=[NSFileManager defaultManager];//创建对象
    BOOL flag=[filemanage copyItemAtPath:srcPath toPath:filePath error:nil];
    if(flag){
        return YES;
    }else{
        return NO;
    }
}
#pragma mark 文件夹
/**
  创建文件夹

  @param directoryPath 路径
  @return 结果
*/
+(BOOL)createDirectoryPath:(NSString *)directoryPath{
    if([HGBCompressedFileTool isExitAtFilePath:directoryPath]){
        return YES;
    }
    NSFileManager *filemanage=[NSFileManager defaultManager];
    BOOL flag=[filemanage createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:nil];
    if(flag){
        return YES;
    }else{
        return NO;
    }
}

/**
 是否是文件夹

 @param path 路径
 @return 结果
 */
+(BOOL)isDirectoryAtPath:(NSString *)path{
    NSFileManager *filemanage=[NSFileManager defaultManager];//创建对象
    BOOL isDir,isExit;
    isExit=[filemanage fileExistsAtPath:path isDirectory:&isDir];
    if(isExit==YES&&isDir==YES){
        return YES;
    }else{
        return NO;
    }
}
/**
  获取沙盒tmp路径

  @return tmp路径
*/
+(NSString *)getTmpFilePath{
    NSString *tmpPath=NSTemporaryDirectory();
    return tmpPath;
}
@end
