//
//  HGBActionLable.m
//  CTTX
//
//  Created by huangguangbao on 16/9/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "HGBActionLable.h"

@implementation HGBActionLable
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
    }
    return self;
}
#pragma mark 添加功能
-(void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //如果self.target表示的对象中, self.action表示的方法存在的话
    if([self.target respondsToSelector:self.action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
    }
}
@end
