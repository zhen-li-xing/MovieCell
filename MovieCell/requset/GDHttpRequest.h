//
//  HttpRequest.h
//  Estate
//
//  Created by chanyezhenghe on 16/1/25.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface GDHttpRequest : NSObject

/**
 *  数据请求
 *
 *  @param urlstring URL
 *  @param method    get or Post
 *  @param parmas    请求参数
 *  @param files     请求文件(图片)
 *  @param success   请求成功的block
 *  @param fail      请求失败的block
 */


+ (void)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;


@end
