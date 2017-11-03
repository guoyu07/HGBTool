//
//  HGBSlideLable.m
//  CTTX
//
//  Created by huangguangbao on 16/9/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "HGBSlideLable.h"

@interface HGBSlideLable()
{
    BOOL seted;
    
    BOOL moveNeed;
    
    CGFloat rate;
}

@property (nonatomic, strong) UIView *innerContainer;
@end

@implementation HGBSlideLable


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.font = [UIFont systemFontOfSize:15];
    self.textColor = [UIColor blackColor];
    self.speed = BBFlashCtntSpeedMild;
    self.repeatCount = 0;
    self.leastInnerGap = 10.f;
    self.clipsToBounds = YES;
    rate = 80.f;
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor blackColor];
        self.speed = BBFlashCtntSpeedMild;
        self.repeatCount = 0;
        self.leastInnerGap = 10.f;
        self.clipsToBounds = YES;
        [self setup];
    }
    return self;
}

- (void)setSpeed:(BBFlashCtntSpeed)speed
{
    _speed = speed;
    switch (_speed) {
        case BBFlashCtntSpeedFast:
            rate = 90.;
            break;
        case BBFlashCtntSpeedMild:
            rate = 75;
            break;
        case BBFlashCtntSpeedSlow:
            rate = 40.;
            break;
        default:
            break;
    }
    [self reloadView];
}

- (void)setLeastInnerGap:(CGFloat)leastInnerGap
{
    _leastInnerGap = leastInnerGap;
    [self reloadView];
}

- (void)setText:(NSString *)text
{
    _text = text;
    _attributedText = nil;
    [self reloadView];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = [self setAttributedTextDefaultFont:attributedText];
    _text = nil;
    [self reloadView];
}

- (NSAttributedString *)setAttributedTextDefaultFont:(NSAttributedString *)attrText
{
    NSMutableAttributedString *rtn = [[NSMutableAttributedString alloc] initWithAttributedString:attrText];
    void (^enumerateBlock)(id, NSRange, BOOL *) = ^(id value, NSRange range, BOOL *stop) {
        if (!value || [value isKindOfClass:[NSNull class]]) {
            
            [rtn addAttribute:NSFontAttributeName
                        value:self.font
                        range:range];
        }
    };
    [rtn enumerateAttribute:NSFontAttributeName
                    inRange:NSMakeRange(0, rtn.string.length)
                    options:0
                 usingBlock:enumerateBlock];
    return rtn;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self reloadView];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self reloadView];
}

- (void)setup
{
    if (seted) {
        return ;
    }
    self.innerContainer = [[UIView alloc] initWithFrame:self.bounds];
    self.innerContainer.backgroundColor = [UIColor clearColor];
    self.innerContainer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.innerContainer];
    
    seted = YES;
}

- (void)reloadView
{
    [self.innerContainer.layer removeAnimationForKey:@"move"];
    for (UIView *sub in self.innerContainer.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            [sub removeFromSuperview];
        }
    }
    CGFloat width = [self evaluateContentWidth];
    moveNeed = width > self.bounds.size.width;
    CGRect f = CGRectMake(0, 0, width, self.bounds.size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:f];
    label.backgroundColor = [UIColor clearColor];
    if (self.text) {
        label.text = self.text;
        label.textColor = self.textColor;
        label.font = self.font;
    } else {
        label.attributedText = self.attributedText;
    }
    
    [self.innerContainer addSubview:label];
    if (moveNeed) {
        CGRect f1 = CGRectMake(width + self.leastInnerGap, 0, width, f.size.height);
        UILabel *next = [[UILabel alloc] initWithFrame:f1];
        next.backgroundColor = [UIColor clearColor];
        if (self.text) {
            next.text = self.text;
            next.textColor = self.textColor;
            next.font = self.font;
        } else {
            next.attributedText = self.attributedText;
        }
        
        [self.innerContainer addSubview:next];
        
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        moveAnimation.keyTimes = @[@0., @0.191, @0.868, @1.0];
        moveAnimation.duration = width / rate;
        moveAnimation.values = @[@0, @0., @(- width - self.leastInnerGap)];
        moveAnimation.repeatCount = self.repeatCount == 0 ? INT16_MAX : self.repeatCount;
        moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        [self.innerContainer.layer addAnimation:moveAnimation forKey:@"move"];
    }
}
-(void)stoploadView{
    
}
- (CGFloat)evaluateContentWidth
{
    CGFloat width = 0.f;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    if (_text.length > 0) {
        NSDictionary *attr = @{NSFontAttributeName : self.font};
        CGSize size = [_text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:options attributes:attr context:nil].size;
        width = size.width;
        
    } else if (_attributedText.length > 0) {
        CGSize size = [_attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:options context:nil].size;
        width = size.width;
    }
    
    return width;
}
#pragma mark 点击事件
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
