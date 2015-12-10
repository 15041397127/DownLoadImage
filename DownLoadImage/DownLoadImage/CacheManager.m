//
//  CacheManager.m
//  DownLoadImage
//
//  Created by zhang xu on 15/11/21.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager

static NSCache *s_imageCache = nil;
+ (NSCache *)Cache{
    
    if (s_imageCache==nil) {
        s_imageCache =[[NSCache alloc]init];
        s_imageCache.name  = @"imageCache";

    }
    return s_imageCache;
}


//static NSCache *s_imageCache =nil;
//+(NSCache *)Cache{
//    
//    if (s_imageCache ==nil) {
//        s_imageCache =[[NSCache alloc]init];
//        s_imageCache.name =@"imageCache";
//    }
//    return s_imageCache;
//}



//获取文件夹路径
+(NSString *)cachePath{
    NSString *document =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject ];
    
    
    return document;
}

////获取文件夹路径
//+(NSString *)cachePath{
//    NSString *document =[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
//    
//    return document;
//}



//计算缓存大小

+ (unsigned long long)cacheBytesCount{
//    NSFileManager *manager =[NSFileManager defaultManager];
//    NSEnumerator *chlidFileEnumerator = [[manager subpathsAtPath:[self cachePath]]objectEnumerator];
//    NSString *fileName;
//    
//    unsigned long long folferSize = 0;
//    while ((fileName = [chlidFileEnumerator nextObject])!=nil) {
//        NSString * fileAbusolutePath = [[self cachePath] stringByAppendingString:fileName];
//        
//        folferSize += [[manager attributesOfItemAtPath:fileAbusolutePath error:nil]fileSize];
//        
//        
//    }
//    
//    
//    
//    return folferSize;
    
    NSFileManager *manager =[NSFileManager defaultManager];
    NSEnumerator *childFileEnumerator =[[manager subpathsAtPath:[self  cachePath]]objectEnumerator];
    NSString *fileName;
    unsigned long long folferSize =0;
    while ((fileName =[childFileEnumerator nextObject ])!=nil) {
        
        
        NSString *fileAbuslotePath =[[self cachePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
        
        NSLog(@"%@",fileAbuslotePath);
        
        folferSize += [[manager attributesOfItemAtPath:fileAbuslotePath error:nil] fileSize];
    }
    
    
    return folferSize;
    
    
//    NSFileManager *manager =[NSFileManager defaultManager];
//    NSEnumerator *childEnumerator =[[manager subpathsAtPath:[self cachePath]]objectEnumerator];
////    NSEnumerator *childEnumerator =[[manager subpathsAtPath:[self cachePath]]objectEnumerator ];
//    NSString *fileName;
//    unsigned long long folgerSize =0;
//    while ((fileName =[childEnumerator nextObject]) !=nil) {
//        NSString *fileAbuslotePath =[[self cachePath]stringByAppendingPathComponent:fileName];
//        folgerSize +=[[manager attributesOfItemAtPath:fileAbuslotePath error:nil]fileSize ];
//        
//        
//        
//    }
//    
//    
//    return folgerSize;
    
    

}

//清除缓存
+(void)clearCache{
    
//    [[NSFileManager defaultManager] removeItemAtPath:[self cachePath] error:nil];
//    [[NSFileManager defaultManager] createDirectoryAtPath:[self cachePath] withIntermediateDirectories:YES attributes:nil error:nil];
//    [[self Cache]removeAllObjects];

//    [[NSFileManager defaultManager]removeItemAtPath:[self cachePath] error:nil];
//    
//    [[NSFileManager defaultManager]createDirectoryAtPath:[self cachePath] withIntermediateDirectories:YES attributes:nil error:nil];
//    [[self Cache]removeAllObjects];
    
    [[NSFileManager defaultManager]removeItemAtPath:[self cachePath] error:nil];
    [[NSFileManager defaultManager]createDirectoryAtPath:[self cachePath] withIntermediateDirectories:YES attributes:nil error:nil
     ];
    [[self Cache]removeAllObjects];
    
 
}

@end
