//
//  PlayerView.m
//  MovieCell
//
//  Created by chanyezhenghe on 16/4/22.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()

@property (nonatomic,strong)AVPlayer * player;



@property (nonatomic,strong)UIView * bottomView;

@property (nonatomic,strong)UIButton * playOrPauseBtn;

@property (nonatomic,strong)UIButton * fullBtn;

@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,strong)UISlider * progressSilder;

@property (nonatomic,assign)BOOL isShowButtomView;

@property (nonatomic,strong)UIView * view;

@property (nonatomic,strong)NSTimer * videoTimer;

@property (nonatomic,strong)UIButton * closeBtn;



@end


@implementation PlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 单击 显示或者隐藏工具栏
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame PlayUrl:(NSString *)url{
    if (self = [self initWithFrame:frame]) {
        [self addUI];
        [self createFrame];
        
        
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
        self.playerItem = item;
        //加载view时自动播放
        [self removeVideoTimer];
        [self addVideoTimer];
        
        self.playOrPauseBtn.selected = YES ;
    }
    return self;
}

- (void)addUI{
    
    _view = [[UIView alloc] initWithFrame:self.bounds];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    UIImage * img = [UIImage imageNamed:@"logo.png"];
    _bgImageView.image = img;
//    _bgImageView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.2];
    _bgImageView.backgroundColor = [UIColor blackColor];
    [self addSubview:_bgImageView];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    _closeBtn.hidden = YES;
    [_closeBtn addTarget:self action:@selector(closePlayer:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeBtn];
    
    self.player= [[AVPlayer alloc]init];
    self.playerLayer = [ AVPlayerLayer playerLayerWithPlayer:self.player ];
    [_bgImageView.layer addSublayer:self.playerLayer];
    _bottomView = [[UIView alloc] init];
    [self addSubview:_bottomView];
    
    _playOrPauseBtn = [[UIButton alloc] init];
    [_playOrPauseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playOrPauseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [_playOrPauseBtn addTarget:self action:@selector(playOrPauseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_playOrPauseBtn];
    
    _fullBtn = [[UIButton alloc] init];
    [_fullBtn setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
    [_fullBtn setImage:[UIImage imageNamed:@"nonfullscreen"] forState:UIControlStateSelected];
    [_fullBtn addTarget:self action:@selector(fullOrNOrmal:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_fullBtn];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.text = @"00:00/00:00";
    _timeLabel.textColor = [UIColor whiteColor];
    [_bottomView addSubview:_timeLabel];
    
    _progressSilder = [[UISlider alloc] init];
    [_progressSilder addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventTouchUpInside];
    [_progressSilder addTarget:self action:@selector(pressDown:) forControlEvents:UIControlEventTouchDown];
    [_progressSilder addTarget:self action:@selector(sliderChangeValue:) forControlEvents:UIControlEventValueChanged];
    [_bottomView addSubview:_progressSilder];
    
    self.playerLayer.frame = self.bounds;
    
    _bottomView.alpha = 0;
    _isShowButtomView = NO;
    _progressSilder.value = 0;
    
}

-(void)createFrame{
    
//    [super layoutSubviews];
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.bgImageView).offset(0);
        make.right.equalTo(self.bgImageView).offset(0);
        make.bottom.equalTo(self.bgImageView).offset(0);
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView).offset(5);
        make.top.equalTo(self.bgImageView).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(0);
        make.height.mas_equalTo(_bottomView);
        make.centerY.equalTo(_bottomView);
        make.width.mas_equalTo(50);
    }];
    
    [_fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView).offset(0);
        make.height.mas_equalTo(_bottomView);
        make.centerY.equalTo(_bottomView);
        make.width.mas_equalTo(50);
    }];
    
    [_progressSilder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_playOrPauseBtn.mas_right).offset(10);
        make.right.equalTo(_timeLabel.mas_left).offset(-10);
        make.centerY.equalTo(_bottomView);
        
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fullBtn.mas_left).offset(10);
        make.centerY.equalTo(_bottomView);
    }];
    
    
    
}

//设置播放的视频
- (void)setPlayerItem:(AVPlayerItem *)playerItem{
    
    if (self.playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
       
    }
    _playerItem = playerItem;
    [self removeVideoTimer];
    [self addVideoTimer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
    
    
    self.playOrPauseBtn.selected = YES ;
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
}

- (void)finishMovie:(NSNotification *)notice{
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        
        [weakSelf.progressSilder setValue:0.0 animated:YES];
        weakSelf.playOrPauseBtn.selected = YES;
        //播放完成后的通知
        //1.创建一个通知
        NSNotification * notice = [[NSNotification alloc] initWithName:@"movieFinished" object:nil userInfo:nil];
        //2.发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }];

}

//slider滑动
- (void)sliderClick:(UISlider *)slider{
    [self addVideoTimer];
    
    //当前时间 = 时长 * 进度条的value值
    NSTimeInterval currenTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSilder.value;
    
    //设置当前播放时间,从某个地点开始播放
    [self.player seekToTime:CMTimeMakeWithSeconds(currenTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    [self.player play];
    
    self.playOrPauseBtn.selected = YES;
}
//
- (void)pressDown:(UISlider *)slider{
    [self removeVideoTimer];
}
//
- (void)sliderChangeValue:(UISlider *)slider{
    
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration)*self.progressSilder.value;
    
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    
    self.timeLabel.text = [self stringWithCurrentTime:currentTime duration:duration];
}

//开始或者暂停
- (void)playOrPauseBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.player play];
        [self addVideoTimer];
    }else{
        [self.player pause];
        [self removeVideoTimer];
    }
}

//关闭视频
- (void)closePlayer:(UIButton *)btn{
    _closeClick(btn);
}

//是否全屏
- (void)fullOrNOrmal:(UIButton *)btn{
    btn.selected = !btn.selected;
    
//    _fullClick(btn);
    
    if ([self.delegate respondsToSelector:@selector(videoplayViewSwitch:)]) {
        [self.delegate videoplayViewSwitch:btn];
    }
    
}


-(void)toSmallScreen{
    //放widow上
    [self removeFromSuperview];
    
    _closeBtn.hidden = NO;
    self.transform = CGAffineTransformIdentity;
    self.frame = CGRectMake(LScreen_Width, LScreen_Height - ((LScreen_Width/2)*0.65), LScreen_Width/2, (LScreen_Width/2)*0.65);
    self.playerLayer.frame =  self.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self createFrame];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [UIView animateWithDuration:0.5f animations:^{
        CGRect newframe = self.frame;
        newframe.origin.x = LScreen_Width - self.frame.size.width;
        self.frame = newframe;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)reduction:(UIView *)view
{
    [self removeFromSuperview];
    
    _closeBtn.hidden = YES;
    [view addSubview:self];
    [view bringSubviewToFront:self];
    self.bgImageView.alpha= 0;

    [UIView animateWithDuration:0.5f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = view.bounds;
        _playerLayer.frame =  self.bounds;
        _bgImageView.frame = self.bounds;
        
        [self createFrame];
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7f animations:^{
            self.bgImageView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
        self.isFullScreen = NO;
        self.fullBtn.selected = NO;
    }];
}


- (void)toFullScreenWithInterfaceOrientation{
    [self removeFromSuperview];

    [self createFrame];
    
    self.fullBtn.selected = YES;
    self.isFullScreen = YES;
}

//是否显示工具栏
- (void)tapAction:(UITapGestureRecognizer *)sender {
    
    NSLog(@"点击了");
    [UIView animateWithDuration:0.5 animations:^{
        if (self.isShowButtomView) {
            self.bottomView.alpha = 0;
            self.isShowButtomView = NO;
        }else{
            self.bottomView.alpha = 1;
            self.isShowButtomView = YES;
        }
    }];
}
#pragma mark -- 定时器
//定时器
- (void)addVideoTimer{
    self.videoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressSlider) userInfo:nil repeats:YES];
}

- (void)updateProgressSlider{
    
    _timeLabel.text = [self timeString];
    
    self.progressSilder.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    [[NSRunLoop mainRunLoop] addTimer:self.videoTimer forMode:NSRunLoopCommonModes];
    
}

//返回目前的时间
- (NSString *)timeString{
    NSTimeInterval durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currenTime = CMTimeGetSeconds(self.player.currentTime);
    return [self stringWithCurrentTime:currenTime duration:durationTime];
}

- (void)removeVideoTimer{
    [self.videoTimer invalidate];
    self.videoTimer = nil;
}







//时间格式
- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTimer duration:(NSTimeInterval)duration{
    //
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = currentTimer / 60;
    NSInteger cSec = (NSInteger)currentTimer % 60;
    
    NSString * durationString = [NSString stringWithFormat:@"%02ld:%02ld",dMin,dSec];
    NSString * currentString = [NSString stringWithFormat:@"%02ld:%02ld",cMin,cSec];
    
    NSString * str = [NSString stringWithFormat:@"%@/%@",currentString,durationString];
    
    return str;
}

-(void)releaseWMPlayer{
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.player pause];
    [self removeFromSuperview];
    [self.playerLayer removeFromSuperlayer];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    self.playerItem = nil;
    self.playOrPauseBtn = nil;
    self.playerLayer = nil;
}



@end
