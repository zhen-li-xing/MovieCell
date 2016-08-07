//
//  LZButton.m
//  Button
//
//  Created by chanyezhenghe on 16/4/1.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "LZButton.h"

@implementation LZButton

+ (LZButton *)addRect:(CGRect)frame Title:(NSString *)title andBlock:(myBlock)block{
    
    
    LZButton * button = [[LZButton alloc] initWithFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //block 相当于 vc 传过来的一堆代码
    //vc 最后需要执行这一堆代码
    button.tempBlock = block;
    
    return button;
}

- (void)changeName:(NSString *)name{
    
}

- (void)buttonClick:(LZButton *)button{
    //将 vc 传过来的代码 再传回去
    button.tempBlock(button);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
