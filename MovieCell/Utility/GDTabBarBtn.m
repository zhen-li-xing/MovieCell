//
//  GDTabBarBtn.m
//  Estate
//
//  Created by chanyezhenghe on 16/1/27.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "GDTabBarBtn.h"

@implementation GDTabBarBtn

- (id)initWithFrame:(CGRect)frame Title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        self.selectImage = selectImage;
        
        
        //图片
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.image = image;
        imageview.tag = 101;
        imageview.frame = self.bounds;
        
        [self addSubview:imageview];
        
        //标题
        UILabel * label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor yellowColor];
        label.frame = CGRectMake(0, 30, self.bounds.size.width, 20);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:20];
        label.tag = 202;
        [self addSubview:label];
        
        
        //点击方法,给imageview加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        imageview.userInteractionEnabled = YES;
        [imageview addGestureRecognizer:tap];
    }
    return self;
}
//重写selected setter方法
- (void)setSelected:(BOOL)selected{
    if (_selected != selected) {
        _selected = selected;
    }
//    通过selected 改变图片文字的颜色
    UIImageView * imageview = (id)[self viewWithTag:101];
    UILabel * label = (id)[self viewWithTag:202];
    
    if (_selected) {
        imageview.image = self.selectImage;
        label.textColor = [UIColor greenColor];
        
    }else{
        imageview.image = self.image;
        label.textColor = [UIColor blackColor];
    }
    
}

- (void)addtarger:(id)targer action:(SEL)action{
    self.targer = targer;
    self.action = action;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    //让编译器对一些警告闭嘴
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.targer performSelector:self.action withObject:self];
#pragma clang diagnostic pop

    //制造警告
    //#warning performSelector  有警告

    
}









@end
