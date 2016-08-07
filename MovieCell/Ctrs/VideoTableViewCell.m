//
//  VideoTableViewCell.m
//  MovieCell
//
//  Created by chanyezhenghe on 16/4/25.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.backgroundColor = [UIColor redColor];
        
        [self initSubView];
        
        [self createFrame];
    }
    return self;
}

- (void)initSubView{
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_bgView];
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    _imgView.layer.masksToBounds = YES;
    _imgView.contentMode = UIViewContentModeCenter;
    [self.bgView addSubview:_imgView];
    
    _playBtn = [[UIButton alloc] init];
    [_playBtn setImage:[UIImage imageNamed:@"video_play_btn_bg@2x"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_playBtn];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"一年前";
    [self.contentView addSubview:_timeLabel];
    
    _commentBtn = [[UIButton alloc] init];
//    [_commentBtn setTitle:@"comment" forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"pinflun"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commentBtn];
    
    
    _shareBtn = [[UIButton alloc] init];
//    [_shareBtn setBackgroundColor:[UIColor redColor]];
    [_shareBtn setTitle:@"share" forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_shareBtn];
    
}

- (void)createFrame{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-50);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-50);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-3);
        
    }];

    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shareBtn.mas_left).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-3);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.contentView).offset(-3);
    }];
    
    _imgView.frame = _bgView.frame;
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.centerY.equalTo(_bgView);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
}

- (void)playClicked:(UIButton *)btn{
    _playClick(btn);
}

- (void)commentClicked:(UIButton *)btn{
    _commentClick(btn);
}

- (void)shareClicked:(UIButton *)btn{
    _shareClick(btn);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
