//
//  VideoViewController.m
//  MovieCell
//
//  Created by chanyezhenghe on 16/4/25.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoTableViewCell.h"
#import "PlayerView.h"
#import "TestViewController.h"
#import "FullViewController.h"
#import "CatchImage.h"

#define AV_url @"http://flv2.bn.netease.com/videolib3/1604/26/tCvbI0910/SD/tCvbI0910-mobile.mp4"

@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,PlayerViewDelegate>

@property (nonatomic,strong)UITableView * myTableView;

@property (nonatomic,strong)VideoTableViewCell * videoCell;
@property (strong, nonatomic)NSIndexPath *currentIndexPath;
@property (nonatomic,strong)PlayerView * playerView;

@property (assign, nonatomic)BOOL isSmallScreen;

@property (nonatomic,assign)BOOL isfullscreen;

@property (nonatomic,strong)FullViewController * fullVc;

@end

@implementation VideoViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotice:) name:@"scrollViewTitle" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinished:) name:@"movieFinished" object:nil];
}

- (void)receiveNotice:(NSNotification *)notice{
    NSLog(@"%@",notice);
    NSDictionary * dic = notice.userInfo;
    if ([dic[@"title"] isEqualToString:@"影视"]) {
        
    }else{
        if (_playerView) {
            [self releaseWMPlayer];
        }
    }
}

- (void)movieFinished:(NSNotification *)notice{
    if (_playerView.isFullScreen) {
        [self toCell];//先变回cell
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _playerView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_playerView removeFromSuperview];
        [self releaseWMPlayer];
    }];
    
}

- (void)createTableView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LScreen_Width, LScreen_Height - 64 - 49- 44) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        VideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bannerImage"];
        if (!cell) {
            cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bannerImage"];
        }
    cell.imgView.image = [CatchImage thumbnailImageForVideo:[NSURL URLWithString:AV_url] atTime:15];
    
    [cell setPlayClick:^(UIButton * btn) {
        btn.tag = indexPath.row;
        [self playClick:btn];
        
    }];
    
    [cell setCommentClick:^(UIButton * btn) {
        TestViewController * test = [[TestViewController alloc] init];
        [self.navigationController pushViewController:test animated:YES];
    }];
    
    [cell setShareClick:^(UIButton * btn) {
        
    }];
    
    return cell;
}

- (void)playClick:(UIButton *)btn{
    
    _currentIndexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    self.videoCell = (VideoTableViewCell *)[self.myTableView cellForRowAtIndexPath:_currentIndexPath];
    
    NSString * str = @"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4";
    
    NSString * str1 = @"http://flv2.bn.netease.com/videolib3/1604/26/tCvbI0910/SD/tCvbI0910-mobile.mp4";
    if (_playerView) {
        [_playerView removeFromSuperview];

        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:str1]];
        [_playerView setPlayerItem:item];

    }else{
        _playerView = [[PlayerView alloc] initWithFrame:self.videoCell.bgView.bounds PlayUrl:str];
        _playerView.delegate = self;
    }
    
    [self.videoCell.bgView addSubview:_playerView];
    [self.videoCell.bgView bringSubviewToFront:_playerView];
    
    
    if (_isSmallScreen) {
        [self toCell];
    }

    _isSmallScreen = NO;
    
    [self.myTableView reloadData];
    
    
    __weak VideoViewController * VC;
    VC = self;
//    [_playerView setFullClick:^(UIButton * btn) {
//        
//        
//        if (btn.selected) {
//            
//            VC.isfullscreen = YES;
//            [VC toFullScreen:UIInterfaceOrientationLandscapeLeft];
//        }else{
//            [VC toCell];
//            VC.isfullscreen = NO;
//        }
//        
//        
//    }];
    
    [_playerView setCloseClick:^(UIButton * btn) {
        [VC closePlayer];
    }];
    
    
}

- (void)closePlayer{
    [UIView animateWithDuration:0.3 animations:^{
        _playerView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_playerView removeFromSuperview];
        [self releaseWMPlayer];
    }];
}

-(void)toFullScreen:(UIInterfaceOrientation )interfaceOrientation{
    //放在controller中起效
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    [_playerView toFullScreenWithInterfaceOrientation:interfaceOrientation];
}

-(void)toCell{
    
    self.videoCell = (VideoTableViewCell *)[self.myTableView cellForRowAtIndexPath:_currentIndexPath];
    [_playerView reduction:self.videoCell.bgView];
    _isSmallScreen = NO;
    //放在controller中起效
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.myTableView reloadData];
}

- (void)toSmallScreen{
    //放widow上
    [_playerView toSmallScreen];
    _isSmallScreen = YES;
}



- (void)reduction:(UIView *)view{
    [_playerView reduction:_videoCell.bgView];
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.myTableView){
        if (_playerView == nil) return;
        
        if (_playerView.superview) {
            CGRect rectInTableView = [self.myTableView rectForRowAtIndexPath:_currentIndexPath];
            CGRect rectInSuperview = [self.myTableView convertRect:rectInTableView toView:[self.myTableView superview]];
            
            
            if (rectInSuperview.origin.y - 64 <-self.videoCell.bgView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height) {//往上拖动
                
                if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:_playerView]) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if (![self.videoCell.bgView.subviews containsObject:_playerView]) {
                    [self toCell];
                }
            }
        }
        
    }
}



-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_playerView) {
       [self releaseWMPlayer];
    }
    
    
}

-(void)releaseWMPlayer{
    
    [_playerView releaseWMPlayer];
    _playerView = nil;
    _currentIndexPath = nil;
    
    
}

//切换屏幕方向的代理
-(void)videoplayViewSwitch:(UIButton *)btn
{
    
    if (btn.selected) {
        
        self.isfullscreen = YES;
        
        [self presentViewController:self.fullVc animated:YES completion:^{
            [_playerView toFullScreenWithInterfaceOrientation];
            self.playerView.frame = self.fullVc.view.bounds;
            _playerView.bgImageView.frame = self.fullVc.view.bounds;
            _playerView.playerLayer.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:_playerView];
            NSLog(@"%@",_playerView);

            
        }];
    }else{
        
        [self.fullVc dismissViewControllerAnimated:YES completion:^{
            [self toCell];
            self.isfullscreen = NO;
        }];
        
    }
    

    
}

#pragma mark - 懒加载代码
-(FullViewController *)fullVc
{
    if(_fullVc == nil){
        self.fullVc=[[FullViewController alloc] init];
    }
    return _fullVc;
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
