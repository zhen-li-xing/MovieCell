//
//  GDListViewController.m
//  Estate
//
//  Created by chanyezhenghe on 16/1/27.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "GDListViewController.h"
#import "PlayerView.h"
#import "CatchImage.h"

#define AV_url @"http://flv2.bn.netease.com/videolib3/1604/26/tCvbI0910/SD/tCvbI0910-mobile.mp4"


@interface GDListViewController ()

@end

@implementation GDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    self.navigationItem.title = @"逗你玩";
    
    
    PlayerView * view = [[PlayerView alloc] initWithFrame:CGRectMake(0, 64, LScreen_Width, 200) PlayUrl:nil];
    [self.view addSubview:view];
    
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 280, LScreen_Width, 200)];
    [imageView setImage:[CatchImage thumbnailImageForVideo:[NSURL URLWithString:AV_url] atTime:100]];
    [self.view addSubview:imageView];
}

- (void)click{
    
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
