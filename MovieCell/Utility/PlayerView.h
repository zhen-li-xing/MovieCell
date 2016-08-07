//
//  PlayerView.h
//  MovieCell
//
//  Created by chanyezhenghe on 16/4/22.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVfoundation.h>


@protocol PlayerViewDelegate <NSObject>

@optional
-(void)videoplayViewSwitch:(UIButton *)btn;

@end


@interface PlayerView : UIView

@property (nonatomic,strong)AVPlayerLayer * playerLayer;

@property (nonatomic ,strong)UIImageView * bgImageView;

@property(weak ,nonatomic)id<PlayerViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame PlayUrl:(NSString *)url;

- (void)toFullScreenWithInterfaceOrientation;

- (void)reduction:(UIView *)view;

- (void)toSmallScreen;

-(void)releaseWMPlayer;

//@property (nonatomic,copy) void(^fullClick)(UIButton * btn);

@property (nonatomic,copy) void(^closeClick)(UIButton * btn);

@property(nonatomic,strong) AVPlayerItem *playerItem;

@property (nonatomic,assign)BOOL isFullScreen;



@end
