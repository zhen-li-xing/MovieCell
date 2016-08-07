//
//  GDtabbarCtr.m
//  Estate
//
//  Created by chanyezhenghe on 16/1/27.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "GDtabbarCtr.h"
#import "GDTabBarBtn.h"
#import "GDMyNavCtr.h"
@interface GDtabbarCtr ()

@property (nonatomic,strong)NSMutableArray * array;

@end

@implementation GDtabbarCtr

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏掉 tabbar 的子视图
    for (UIView * view in self.tabBar.subviews) {
        view.hidden = YES;
    }
    
    //自定义 button 继承于 UIview
    //imageview + label 组成
    for (int i = 0; i < self.viewControllers.count; i++) {
        CGFloat bwidth = [UIScreen mainScreen].bounds.size.width / 4;
        
        UIViewController * vc = self.viewControllers[i];
        NSLog(@"%@",vc.tabBarItem.title);
        GDTabBarBtn * btn = [[GDTabBarBtn alloc]initWithFrame:CGRectMake(i * bwidth, 0, bwidth, 50) Title:vc.tabBarItem.title image:vc.tabBarItem.image selectImage:vc.tabBarItem.selectedImage];
        
        btn.tag = 10 + i;
        [btn addtarger:self action:@selector(buttonClick:)];
        
        [self.tabBar addSubview:btn];
    }
    //设置第一个button是亮的
    GDTabBarBtn * currentBtn = (GDTabBarBtn *)[self.tabBar viewWithTag:self.selectedIndex + 10];
    currentBtn.selected = YES;
}

- (void)buttonClick:(GDTabBarBtn *)button{
    //取到当前亮的 button
    GDTabBarBtn * currentBtn = (GDTabBarBtn *)[self.tabBar viewWithTag:10 + self.selectedIndex];
    
    //取到所有不亮的 button
    if (button != currentBtn) {
        button.selected = YES;
        currentBtn.selected = NO;
    }
    self.selectedIndex = button.tag - 10;
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _array = [NSMutableArray array];
}

- (void)addviewCtrlString:(NSString *)ctrlName andTitle:(NSString *)title selectImage:(NSString *)selectImage image:(NSString *)image{
    
    Class classname = NSClassFromString(ctrlName);
    
    UIViewController * vc = [[classname alloc] init];
    
    GDMyNavCtr * nav = [[GDMyNavCtr alloc] initWithRootViewController:vc];
    
    vc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.title = title;
    
    NSLog(@"%@",vc.tabBarItem.title);
    
    [_array addObject:nav];
    
    self.viewControllers = _array;
    
    for (int i = 0; i < _array.count; i ++) {
        UIViewController * vc1 = self.viewControllers[i];
        NSLog(@"%@",vc1.tabBarItem.title);
    }
    
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
