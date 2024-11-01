//
//  MXMHttpManager.h
//  MapxusMapSDK
//
//  Created by Chenghao Guo on 2018/7/17.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@interface MXMHttpManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

+ (NSURLSessionDataTask *)MXMGET:(NSString *)URLString
                      parameters:(NSDictionary *)dic
                         success:(void (^)(NSDictionary *content))success
                         failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDataTask *)MXMPOST:(NSString *)URLString
                       parameters:(NSDictionary *)dic
                          success:(void (^)(NSDictionary *content))success
                          failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDataTask *)MXMPOST:(NSString *)URLString
                             data:(NSData *)bodyData
                          success:(void (^)(NSDictionary *content))success
                          failure:(void (^)(NSError *error))failure;

@end
