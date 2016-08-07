//
//  GDMyNavCtrlV.m
//  Estate
//
//  Created by chanyezhenghe on 16/1/27.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "GDMyNavCtr.h"

@interface GDMyNavCtr ()

@end

@implementation GDMyNavCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    
    //更新状态栏的风格
    [self setNeedsStatusBarAppearanceUpdate];
}

//返回状态栏的风格
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
