//
//  AppDelegate+Push.m
//  测试
//
//  Created by huangguangbao on 2017/8/6.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "AppDelegate+Push.h"

#define WidthScale [UIScreen mainScreen].bounds.size.width/375
#define HeightScale [UIScreen mainScreen].bounds.size.height/667
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation AppDelegate (Push)
#define AlertFlag NO

#pragma mark 申请推送权限
/**
 推送权限

 @param application application
 */
-(void)registerPushNotificationAuthorityWithapplication:(UIApplication *)application{
    //注册
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
//        本地通知
        [application registerUserNotificationSettings:setting];
//        远程通知
        [application registerForRemoteNotifications];
    }
}

#pragma mark 本地通知
/**
 本地通知注册成功

 @param application application
 @param notificationSettings 配置
 */
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"local:sucess");
    if(AlertFlag){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"local" message:@"sucess" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }
}
/**
 收到本地通知

 @param application application
 @param notification 消息
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"local:%@-%@-%@",notification.alertTitle,notification.alertBody,notification.userInfo);
    if(AlertFlag){
        NSString *string=[NSString stringWithFormat:@"%@-%@-%@",notification.alertTitle,notification.alertBody,[self ObjectToJSONString:notification.userInfo]];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"local" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }

}
/**
 本地通知事件

 @param application application
 @param identifier 标识
 @param notification 消息
 @param completionHandler 完成
 */
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
     NSLog(@"local-action:%@-%@-%@",notification.alertTitle,notification.alertBody,notification.userInfo);
    if(AlertFlag){
        NSString *string=[NSString stringWithFormat:@"action:%@-%@-%@",notification.alertTitle,notification.alertBody,[self ObjectToJSONString:notification.userInfo]];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"local" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }

}
#pragma mark 远程通知

/**
 注册远程通知成功

 @param application application
 @param deviceToken token
 */
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSString *dvsToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    //============保存dvsToken===========================
    NSString *formatToekn = [dvsToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@",formatToekn);
    if(AlertFlag){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"remote:token" message:nil preferredStyle:UIAlertControllerStyleAlert];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {

            textField.text =formatToekn;
        }];

        UIAlertAction *a=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:a];
        [[self currentViewController] presentViewController:alert animated:YES completion:nil];

    }
}
/**
 注册远程通知失败

 @param application application
 @param error 错误
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"remote:failed");
    if(AlertFlag){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"remote" message:@"failed" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }
}

/**
 收到远程通知

 @param application application
 @param userInfo 信息
 @param completionHandler 完成
 */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{


    NSLog(@"remote:%@",userInfo);
    if(AlertFlag){
        NSString *string=[NSString stringWithFormat:@"%@",[self ObjectToJSONString:userInfo]];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"remote" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }


    // 1.打开后台模式 2.告诉系统是否有新内容的更新 3.发送的通知有固定的格式("content-available":"1")
    // 2.告诉系统有新内容
    completionHandler(UIBackgroundFetchResultNewData);
}
/**
 远程通知事件

 @param application application
 @param identifier 标识
 @param userInfo 消息
 @param completionHandler 完成
 */
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    NSLog(@"remote-action:%@",userInfo);
    if(AlertFlag){
        NSString *string=[NSString stringWithFormat:@"action:%@",[self ObjectToJSONString:userInfo]];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"remote" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }
}
#pragma mark 初次进入消息处理

/**
 初次进入application获取到消息（状态栏点击消息进入）

 @param launchOptions 信息
 */
-(void)launchWithNotificationInfo:(NSDictionary *)launchOptions{
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSDictionary* localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotification){
         NSLog(@"local-first:%@",localNotification);
        if(AlertFlag){
            NSString *string=[NSString stringWithFormat:@"first:%@",[self ObjectToJSONString:localNotification]];
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"local:" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
        }
    }
    if(remoteNotification){
         NSLog(@"remote-first:%@",remoteNotification);
        if(AlertFlag){
            NSString *string=[NSString stringWithFormat:@"first:%@",[self ObjectToJSONString:remoteNotification]];
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"remote" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
        }
    }
}

#pragma mark 获取当前控制器
- (UIViewController *)findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
#pragma mark 返回根视图控制器
- (UIViewController *)currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}
#pragma mark 工具
/**
 把Json对象转化成json字符串

 @param object json对象
 @return json字符串
 */
- (NSString *)ObjectToJSONString:(id)object
{
    if(!([object isKindOfClass:[NSDictionary class]]||[object isKindOfClass:[NSArray class]]||[object isKindOfClass:[NSString class]])){
        return @"";
    }
    if([object isKindOfClass:[NSString class]]){
        return object;
    }
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return myString;
}
@end
