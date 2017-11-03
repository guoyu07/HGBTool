//
//  HGBShowViewController.h
//  CTTX
//
//  Created by huangguangbao on 16/12/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 带标题文本
 */
@interface HGBShowViewController : UIViewController
/**
 内容标题
 */
@property(nonatomic,strong)NSString *name;
/**
 内容
 */
@property(strong,nonatomic)NSString *promptStr;
/**
 导航栏创建

 @param title 标题
 */
-(void)createNavigationItemWithTitle:(NSString *)title;
@end
