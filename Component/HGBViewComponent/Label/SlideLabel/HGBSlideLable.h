//
//  HGBSlideLable.h
//  CTTX
//
//  Created by huangguangbao on 16/9/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
滚动标签
*/
typedef NS_ENUM(NSInteger, BBFlashCtntSpeed) {
    BBFlashCtntSpeedSlow = -1,
    BBFlashCtntSpeedMild,
    BBFlashCtntSpeedFast
};

/**
 滚动标签
 */
@interface HGBSlideLable : UIView

/**
 文字
 */
@property (nonatomic, strong) NSString *text;
/**
 字体大小默认:system(15)
 */
@property (nonatomic, strong) UIFont *font;
/**
 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) NSAttributedString *attributedText;

/**
 速度
 */
@property (nonatomic, assign) BBFlashCtntSpeed speed;

/**
 循环滚动次数(为0时无限滚动)
 */
@property (nonatomic, assign) NSUInteger repeatCount;

@property (nonatomic, assign) CGFloat leastInnerGap;

/**
 加载
 */
- (void)reloadView;//
/**
 结束
 */
-(void)stoploadView;

#pragma mark 点击事件
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
-(void)addTarget:(id)target action:(SEL)action;
@end
