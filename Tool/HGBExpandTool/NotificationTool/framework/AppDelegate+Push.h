//
//  AppDelegate+Push.h
//  测试
//
//  Created by huangguangbao on 2017/8/6.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>  
@interface AppDelegate (Push)
#pragma mark 申请推送权限
/**
 推送权限

 @param application application
 */
-(void)registerPushNotificationAuthorityWithapplication:(UIApplication *)application;
#pragma mark 初次进入消息处理

/**
初次进入application获取到消息（状态栏点击消息进入）

 @param launchOptions 信息
 */
-(void)launchWithNotificationInfo:(NSDictionary *)launchOptions;
@end
