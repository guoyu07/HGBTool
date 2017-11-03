//
//  HGBShowView.h
//  CTTX
//
//  Created by huangguangbao on 16/12/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 带标题文本
 */
@interface HGBShowView : UIView
@property(nonatomic,strong)NSString *name;
/**
 提示字符串
 */
@property(strong,nonatomic)NSString *promptStr;
/**
 init方法
 */
- (instancetype)initWithFrame:(CGRect)frame andWithTitle:(NSString *)title andWithPrompt:(NSString *)prompt;
@end
