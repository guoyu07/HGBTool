//
//  HGBDownLoadTool.m
//  HelloCordova
//
//  Created by huangguangbao on 2017/7/11.
//
//

#import "HGBDownLoadTool.h"
#import <UIKit/UIKit.h>
#import "HGBCompressedFileTool.h"
@implementation HGBDownLoadTool
/**
 下载
 
 @param urlPath 下载链接
 @param path 存储地址
 @param completeBlock 返回内容
 */

+(void)downLoadAndDecompressWith:(NSString *)urlPath andWithStoreFile:(NSString *)path andWithCompleteBlock:(void (^)(BOOL state))completeBlock{
    NSURL *url=[NSURL URLWithString:urlPath];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //获取下载文件的名称
        NSString *fileName=[url lastPathComponent];
        
        NSString *copyFilePath=[[HGBDownLoadTool getDocumentFilePath] stringByAppendingPathComponent:fileName];
        
        NSFileManager *f=[NSFileManager defaultManager];
       
        [f copyItemAtPath:[location path] toPath:copyFilePath error:nil];
        
        fileName=[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",[fileName pathExtension]] withString:@""];
        
        NSLog(@"%@",[location path]);
        
        NSString *filePath=[[HGBDownLoadTool getDocumentFilePath] stringByAppendingPathComponent:fileName];
        if(path&&path.length!=0){
            filePath=[[HGBDownLoadTool getDocumentFilePath] stringByAppendingPathComponent:path];
        }
        [HGBCompressedFileTool unArchive:copyFilePath andPassword:nil toDestinationPath:filePath];
        NSLog(@"%@",filePath);
                    
    }];
    
    [NSThread sleepForTimeInterval:3];
    [downloadTask resume];
}
#pragma mark 沙盒
/**
 获取沙盒Document路径
 
 @return Document路径
 */
+(NSString *)getDocumentFilePath{
    NSString  *path_huang =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    return path_huang;
}
@end
