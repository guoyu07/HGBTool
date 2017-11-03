//
//  HGBActionLable.h
//  CTTX
//
//  Created by huangguangbao on 16/9/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 可点击标签
 */
@interface HGBActionLable : UILabel
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
/**
 事件

 @param target 目标
 @param action 事件
 */
-(void)addTarget:(id)target action:(SEL)action;
@end
