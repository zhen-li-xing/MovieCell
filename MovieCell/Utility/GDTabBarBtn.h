//
//  GDTabBarBtn.h
//  Estate
//
//  Created by chanyezhenghe on 16/1/27.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTabBarBtn : UIView

@property (nonatomic,strong)UIImage * image;
@property (nonatomic,strong)UIImage * selectImage;

@property (nonatomic,assign)id targer;
@property (nonatomic,assign)SEL action;

@property (nonatomic,assign)BOOL selected;

- (id)initWithFrame:(CGRect)frame Title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage;

- (void)addtarger:(id)targer action:(SEL)action;


@end
