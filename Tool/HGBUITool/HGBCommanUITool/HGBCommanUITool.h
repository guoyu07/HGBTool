//
//  HGBCommanUITool.h
//  CTTX
//
//  Created by huangguangbao on 16/11/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 数据加载处理-加载-错误-无数据
 */
@protocol  HGBCommanUIToolDelegate <NSObject>
/**
 加载出错按钮点击
 */
-(void)errorButtonClicked;
@end
@interface HGBCommanUITool : NSObject
+ (instancetype)sharedInstance;
#pragma mark NoData
/**
 添加无数据显示图

 @param parentView 父view
 */
+(void)addNodataViewInParentView:(UIView *)parentView;
/**
 去除无数据显示图
 */
+(void)removeNodataView;

/**
 设置无数据提示标题

 @param title 提示
 */
+(void)setPromptTitle:(NSString *)title;
#pragma mark 加载
/**
 加载图是否存在

 @return 存在状态
 */
+(BOOL)isLoadActivity;
/**
 加载

 @param delegate 加载代理
 @param parentView 父view
 */
+(void)loadingWithDelegate:(id<HGBCommanUIToolDelegate>)delegate InParentView:(UIView *)parentView;
/**
 加载出错
 */
+(void)loadingError;
/**
 加载成功
 */
+(void)loadingSucess;//
#pragma mark error
/**
 添加errorlabel

 @param error 错误提示信息
 @param table tableview
 @param view 父view
 @param y 位置
 */
+(void)addError:(NSString *)error ToTableView:(UITableView *)table InView:(UIView *)view WithY:(CGFloat)y;
/**
 删除errorlabel

 @param table tableview
 @param y 位置
 */
+(void)removeErrorLableToTableView:(UITableView *)table WithY:(CGFloat)y;
@end
