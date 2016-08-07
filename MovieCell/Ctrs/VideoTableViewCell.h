//
//  VideoTableViewCell.h
//  MovieCell
//
//  Created by chanyezhenghe on 16/4/25.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell

@property (nonatomic,strong)UIButton * playBtn;

@property (nonatomic,strong)UIImageView * imgView;

@property (nonatomic,strong)UIView * bgView;

@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,strong)UIButton * commentBtn;

@property (nonatomic,strong)UIButton * shareBtn;

@property (nonatomic,copy) void(^playClick)(UIButton * btn);

@property (nonatomic,copy) void(^commentClick)(UIButton * btn);

@property (nonatomic,copy) void(^shareClick)(UIButton * btn);


@end
