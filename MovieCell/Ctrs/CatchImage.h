//
//  CatchImage.h
//  MovieCell
//
//  Created by chanyezhenghe on 16/5/25.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchImage : NSObject

/*
 *videoURL:视频地址(本地/网络)
 *time      :第N帧
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;


@end
