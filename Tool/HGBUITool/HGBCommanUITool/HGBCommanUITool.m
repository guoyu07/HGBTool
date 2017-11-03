//
//  HGBCommanUITool.m
//  CTTX
//
//  Created by huangguangbao on 16/11/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "HGBCommanUITool.h"
#import "HGBCommanUIToolHeader.h"
@interface HGBCommanUITool()
{
    double _angle;//角度
}

@property(strong,nonatomic)id<HGBCommanUIToolDelegate>delegate;
#pragma mark Nodata
@property(strong,nonatomic)UIView *NoDataBackView;//无数据显示
@property(strong,nonatomic)UILabel *nameLab;//提示信息
@property(strong,nonatomic)UIImageView *promptImageV;//提示图
#pragma mark 加载

@property(strong,nonatomic)UIView *backloadView;//加载
@property (nonatomic,strong)UIImageView *loadingImageView;//加载图
@property (nonatomic,strong)UILabel *loadingLabel;//加载图标
@property (nonatomic,strong)CADisplayLink *displayLink;//定时器
@property (nonatomic,strong)UIButton *errorButton;//出错按钮
@property (nonatomic,strong)UILabel *errorNoLabel;//出错信息
#pragma mark error
@property(strong,nonatomic)UILabel *errorLabel;//错误信息
@property(assign,nonatomic)CGFloat y;//位置
@end
@implementation HGBCommanUITool
static HGBCommanUITool *instance=nil;
+ (instancetype)sharedInstance
{
    //这段代码只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HGBCommanUITool alloc]init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewSetUp];
    }
    return self;
}
#pragma mark viewSetUp
-(void)viewSetUp{
    [self NoDataViewSetUp];
    [self LoadViewSetUp];
    [self errorLabelSetUp];
}
//错误信息
-(void)errorLabelSetUp{
    
    //错误提示
    self.errorLabel = [[UILabel alloc]init];
    self.errorLabel.frame = CGRectMake(0,0, kWidth, 64 * hScale);
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.errorLabel.textColor = [UIColor colorWithRed:246.0/256 green:66.0/256 blue:44.0/256 alpha:1];
    self.errorLabel.font = [UIFont systemFontOfSize:14.0];
    self.errorLabel.backgroundColor =[UIColor colorWithRed:255.0/256 green:237.0/256 blue:237.0/256 alpha:1] ;
    self.errorLabel.text = @"获取数据失败，请手动刷新";
}
//无数据显示
-(void)NoDataViewSetUp{
    self.NoDataBackView=[[UIView alloc]initWithFrame:CGRectMake(0,0, kWidth, kHeight-64)];
    self.NoDataBackView.backgroundColor=[UIColor whiteColor];
    self.promptImageV=[[UIImageView alloc]initWithFrame:CGRectMake(265*wScale, 216*hScale, 220*wScale, 338*hScale)];
    self.promptImageV.image=[UIImage imageNamed:@"cttxcar"];
    self.promptImageV.backgroundColor=[UIColor colorWithRed:245.0/256 green:242.0/256 blue:242.0/256 alpha:1];
    [self.NoDataBackView addSubview:self.promptImageV];
    
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0*wScale, 598*hScale,kWidth, 21)];
    self.nameLab.textAlignment=NSTextAlignmentCenter;
    self.nameLab.textColor=[UIColor colorWithRed:166.0/256 green:166.0/256 blue:166.0/256 alpha:1];
    self.nameLab.font=[UIFont systemFontOfSize:18.8];
    self.nameLab.text=@"提示信息";
    
    [self.NoDataBackView addSubview:self.nameLab];
}
//加载数据
-(void)LoadViewSetUp{
    self.backloadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.backloadView.backgroundColor=[UIColor colorWithRed:245.0/256 green:242.0/256 blue:242.0/256 alpha:1];
    
    self.loadingImageView = [[UIImageView alloc]init];
    self.loadingImageView.frame = CGRectMake(331 * wScale, 340 * hScale, 87.9 * wScale, 87.9 * wScale);
    self.loadingImageView.image = [UIImage imageNamed:@"HGBCommanUIToolBundle.bundle/icon_loading"];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    self.loadingLabel = [[UILabel alloc]init];
    self.loadingLabel.frame = CGRectMake(0, CGRectGetMaxY(self.loadingImageView.frame) + 73.9 * hScale, kWidth, 16);
    self.loadingLabel.textColor = [UIColor colorWithRed:166.0/256 green:166.0/256 blue:166.0/256 alpha:1];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.font = [UIFont systemFontOfSize:16.0];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.text = @"正在努力查询中，请稍后...";
    
    
    self.errorButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.errorButton.frame = CGRectMake(331 * wScale, 340 * hScale, 87.9 * wScale, 87.9 * wScale);
    [self.errorButton setBackgroundImage:[UIImage imageNamed:@"HGBCommanUIToolBundle.bundle/btn_normal_try"] forState:(UIControlStateNormal)];
    [self.errorButton setBackgroundImage:[UIImage imageNamed:@"HGBCommanUIToolBundle.bundle/btn_press_try"] forState:(UIControlStateSelected)];
    [self.errorButton addTarget:self action:@selector(errorButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.errorNoLabel = [[UILabel alloc]init];
    self.errorNoLabel.frame = CGRectMake(0, CGRectGetMaxY(self.loadingImageView.frame) + 73.9 * hScale, kWidth, 16);
    self.errorNoLabel.textColor = [UIColor colorWithRed:166.0/256 green:166.0/256 blue:166.0/256 alpha:1];
    self.errorNoLabel.textAlignment = NSTextAlignmentCenter;
    self.errorNoLabel.font = [UIFont systemFontOfSize:16.0];
    self.errorNoLabel.text = @"获取数据失败,请点击重试";
}
#pragma mark error
+(void)addError:(NSString *)error ToTableView:(UITableView *)table InView:(UIView *)view WithY:(CGFloat)y{
    [HGBCommanUITool sharedInstance];
    [instance.errorLabel removeFromSuperview];
    if(error&&error.length!=0){
        instance.errorNoLabel.text = error;
    }else{
         instance.errorNoLabel.text = @"获取数据失败,请点击重试";
    }
    table.frame=CGRectMake(0,y, kWidth, table.frame.size.height);
    [view addSubview:instance.errorLabel];
}
+(void)removeErrorLableToTableView:(UITableView *)table WithY:(CGFloat)y{
    [HGBCommanUITool sharedInstance];
    table.frame=CGRectMake(0,y, kWidth, table.frame.size.height);
    [instance.errorLabel removeFromSuperview];
}
#pragma mark NoData
//添加
+(void)addNodataViewInParentView:(UIView *)parentView{
    [HGBCommanUITool sharedInstance];
    [instance.NoDataBackView removeFromSuperview];
    [instance.NoDataBackView addSubview:instance.promptImageV];
    [instance.NoDataBackView addSubview:instance.nameLab];
    [parentView addSubview:instance.NoDataBackView];
    
}
//去除
+(void)removeNodataView{
    [HGBCommanUITool sharedInstance];
    if([instance.NoDataBackView superview]){
        [instance.promptImageV removeFromSuperview];
        [instance.nameLab removeFromSuperview];
       [instance.NoDataBackView removeFromSuperview];
    }
}
#pragma mark 设置提示信息
+(void)setPromptTitle:(NSString *)title{
    [HGBCommanUITool sharedInstance];
    instance.nameLab.text=title;
}
#pragma mark load
//加载
+(void)loadingWithDelegate:(id<HGBCommanUIToolDelegate>)delegate InParentView:(UIView *)parentView{
    [HGBCommanUITool sharedInstance];
    
    [instance loadingWithDelegate:delegate InParentView:parentView];
}
-(void)loadingWithDelegate:(id<HGBCommanUIToolDelegate>)delegate InParentView:(UIView *)parentView{
    [HGBCommanUITool sharedInstance];
    [instance.backloadView removeFromSuperview];
    instance.delegate=delegate;
    [instance.backloadView addSubview:instance.loadingImageView];
    [instance.backloadView addSubview:instance.loadingLabel];
    [instance.errorButton removeFromSuperview];
    [instance.errorNoLabel removeFromSuperview];
    [parentView addSubview:instance.backloadView];
    
}
//加载失败
+(void)loadingError{
    [HGBCommanUITool sharedInstance];
    [instance.loadingImageView removeFromSuperview];
    [instance.loadingLabel removeFromSuperview];
    [instance.backloadView addSubview:instance.errorButton];
    [instance.backloadView addSubview:instance.errorNoLabel];
}
//加载成功
+(void)loadingSucess{
    [HGBCommanUITool sharedInstance];
     [instance.backloadView removeFromSuperview];
}
#pragma mark 等待图片旋转
- (void)handleDisplayLink:(CADisplayLink *)displaylink
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(_angle * (M_PI_4 / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _loadingImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        _angle += 10;
        
    }];
    
}
#pragma mark 重新获取数据
- (void)errorButtonAction:(UIButton *)sender
{
    [instance.errorButton removeFromSuperview];
    [instance.errorNoLabel removeFromSuperview];
    [instance.backloadView addSubview:instance.loadingImageView];
    [instance.backloadView addSubview:instance.loadingLabel];
    if(instance
       &&[instance.delegate respondsToSelector:@selector(errorButtonClicked)]){
        [instance.delegate errorButtonClicked];
    }
    
}
+(BOOL)isLoadActivity{
    if([instance.backloadView superview]){
        return YES;
    }else{
        return NO;
    }
}
@end
