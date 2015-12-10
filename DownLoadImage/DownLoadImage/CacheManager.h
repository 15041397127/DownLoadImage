//
//  CacheManager.h
//  DownLoadImage
//
//  Created by zhang xu on 15/11/21.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject


+ (NSCache *)Cache;

+ (NSString *)cachePath;

+ (void)clearCache;

+ (unsigned long long)cacheBytesCount;

//+ (NSCache *)Cache;
//+(NSString *)cachePath;
//+(void )clearCache;
//+(unsigned long long)cacheBytesCount;

@end
