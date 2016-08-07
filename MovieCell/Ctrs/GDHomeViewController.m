//
//  GDHomeViewController.m
//  Estate
//
//  Created by chanyezhenghe on 16/1/27.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "GDHomeViewController.h"
#import "SubChildViewController.h"
#import "SlideHeadView.h"
#import "VideoViewController.h"

@interface GDHomeViewController ()


@property (nonatomic,strong)UIProgressView * progressview;

@end

@implementation GDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"达拉达拉";
    
    //完成以下步骤即可
    //初始化SlideHeadView，并加进view
    SlideHeadView *slideVC = [[SlideHeadView alloc]init];
    [self.view addSubview:slideVC];
    
    //    初始化子控制器，使用-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle方法
    SubChildViewController *firstVC = [[SubChildViewController alloc]init];
    SubChildViewController *secondVC = [[SubChildViewController alloc]init];
    SubChildViewController *threeVC = [[SubChildViewController alloc]init];
    SubChildViewController *fourVC = [[SubChildViewController alloc]init];
    SubChildViewController *fiveVC = [[SubChildViewController alloc]init];
    SubChildViewController *sixVC = [[SubChildViewController alloc]init];
    
    SubChildViewController *sevenVC = [[SubChildViewController alloc]init];
    SubChildViewController *eightVC = [[SubChildViewController alloc]init];
    VideoViewController *nineVC = [[VideoViewController alloc]init];
    SubChildViewController *tenVC = [[SubChildViewController alloc]init];
    
    
    NSArray *titleArr = @[@"首页",@"懂中国",@"全球眼",@"新金融",@"股市通",@"房产",@"汽车",@"科技",@"影视",@"文化"];
    slideVC.titlesArr = titleArr;
    
    //
    [slideVC addChildViewController:firstVC title:titleArr[0]];
    [slideVC addChildViewController:secondVC title:titleArr[1]];
    [slideVC addChildViewController:threeVC title:titleArr[2]];
    [slideVC addChildViewController:fourVC title:titleArr[3]];
    [slideVC addChildViewController:fiveVC title:titleArr[4]];
    [slideVC addChildViewController:sixVC title:titleArr[5]];
    [slideVC addChildViewController:sevenVC title:titleArr[6]];
    [slideVC addChildViewController:eightVC title:titleArr[7]];
    [slideVC addChildViewController:nineVC title:titleArr[8]];
    [slideVC addChildViewController:tenVC title:titleArr[9]];
    
    
    //最后再调用setSlideHeadView  完成
    [slideVC setSlideHeadView];

}
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}



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
