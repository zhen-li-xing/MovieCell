//
//  LZButton.h
//  Button
//
//  Created by chanyezhenghe on 16/4/1.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZButton;

//myBlock 可以看做一个类,也可以看做指向一堆代码块的指针
typedef void (^myBlock)(LZButton * button);

@interface LZButton : UIButton

//定义一个具体的block ,可以理解为一个对象,必须用copy
@property (nonatomic,copy)myBlock tempBlock;

+ (LZButton *)addRect:(CGRect)frame Title:(NSString *)title andBlock:(myBlock)block;

- (void)changeName:(NSString *)name;


@end
