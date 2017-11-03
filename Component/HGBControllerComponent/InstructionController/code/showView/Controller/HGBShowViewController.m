//
//  HGBShowViewController.m
//  CTTX
//
//  Created by huangguangbao on 16/12/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "HGBShowViewController.h"
#import "HGBShowView.h"
#import "HGBShowHeader.h"
@interface HGBShowViewController ()
/**
 view
 */
@property(strong,nonatomic)HGBShowView *showView;
@end

@implementation HGBShowViewController
#pragma mark life
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _showView=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewSetUp];//UI
    
}
#pragma mark 导航栏
-(void)createNavigationItemWithTitle:(NSString *)title
{
    //导航栏
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:245.0/256 green:62.0/256 blue:42.0/256 alpha:1]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_NavigationBar"] forBarMetrics:UIBarMetricsDefault];
    //标题
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 136*wScale, 16)];
    titleLab.font=[UIFont boldSystemFontOfSize:16];
    titleLab.text=title;
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=titleLab;
    
    //左键
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"Btn_Back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(returnhandler)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}
//返回
-(void)returnhandler{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark viewSetUp
-(void)viewSetUp{
    self.showView=[[HGBShowView alloc]initWithFrame:self.view.bounds andWithTitle:self.name andWithPrompt:self.promptStr];
    self.showView.name=self.name;
    self.showView.promptStr=self.promptStr;
    [self.view addSubview:self.showView];
}
@end
