//
//  HttpRequest.m
//  Estate
//
//  Created by chanyezhenghe on 16/1/25.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "GDHttpRequest.h"

@implementation GDHttpRequest

+ (void)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
    
    
    
    //1.构造操作对象管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    //2.设置解析格式，默认json
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //设置相应内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/html", @"text/javascript", @"text/json", @"application/x-www-form-urlencoded; charset=utf-8", nil];
    
    ///存储格式为二进制
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    
    
    //3.判断网络状况
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            
            //showAlert
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络链接错误,请检查网络链接" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil]show];
            
            return;
            
        }else if (status == AFNetworkReachabilityStatusUnknown){
            
            //NSLog(@"未知网络");
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            
            //NSLog(@"WiFi");
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
            //NSLog(@"手机网络");
            
        }
        
    }];
    
    
    // 4.get请求
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        
        [manager GET:requestURL
         parameters:parmas
           progress:^(NSProgress * _Nonnull downloadProgress) {
               
           }
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success != nil)
                {
                    success(responseObject);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail != nil) {
                    fail(error);
                }
            }];
        
        
        // 5.post请求不带文件 和post带文件
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        
        
        if (files == nil) {
            
            [manager POST:requestURL
              parameters:parmas
                progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                }
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     if (success) {
                         success(responseObject);
                     }
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (fail) {
                         fail(error);
                     }
                 }];
            
            
        } else {
            
               [manager POST:requestURL
                 parameters:parmas
  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      
    NSArray *array = [files allKeys];
      
      int i = 0;
      
      for (id key in array) {
          
          //获取上传的所有图片
          NSData *Imagearr = files[key];
          
          NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
          
          NSTimeInterval a=[dat timeIntervalSince1970]*1000;
          //转为字符型
          NSString *timeString = [NSString stringWithFormat:@"%f", a];
          
          NSString *filename = [NSString stringWithFormat:@"%@.png",timeString];
          
          [formData appendPartWithFileData:Imagearr
                                      name:key
                                  fileName:filename
                                  mimeType:@"image/png"];
          
          i++;
      }
      
  }                progress:^(NSProgress * _Nonnull uploadProgress) {
      
  }                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
      if (success) {
          success(responseObject);
      }
      
  }                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
      if (fail) {
          fail(error);
      }
      
  }];
            
            
        }
        
    }
    
    
}


@end
