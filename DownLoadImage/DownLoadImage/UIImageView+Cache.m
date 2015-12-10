//
//  UIImageView+Cache.m
//  DownLoadImage
//
//  Created by zhang xu on 15/11/21.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "UIImageView+Cache.h"
#import <CommonCrypto/CommonCrypto.h>
#import "CacheManager.h"

@interface NSURL (md5)
-(NSString *)md5;
@end

@implementation NSURL (md5)
-(NSString *)md5
{
//    CC_MD5_CTX md5;
//    CC_MD5_Init(&md5);
//    
//    NSData *data =[self.absoluteString dataUsingEncoding:NSUTF8StringEncoding];
//    CC_MD5_Update(&md5, data.bytes, data.length);
//    
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5_Final(digest, &md5);
//    
//    NSString *s =[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",digest[0],digest[1],digest[2],digest[3],digest[4],digest[5],digest[6],digest[7],digest[8],digest[9],digest[10],digest[11],digest[12],digest[13],digest[14],digest[15]];
//    
//    
//    return s;
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    NSData *data =[self.absoluteString dataUsingEncoding:NSUTF8StringEncoding];
    CC_MD5_Update(&md5, data.bytes, data.length);
    unsigned char digest [CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *s =[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",digest[0],digest[1],digest[2],digest[3],digest[4],digest[5],digest[6],digest[7],digest[8],digest[9],digest[10],digest[11],digest[12],digest[13],digest[14],digest[15]];
    
//    CC_MD5_CTX md5;
//    CC_MD5_Init(&md5);
//    NSData *data =[self.absoluteString dataUsingEncoding:NSUTF8StringEncoding];
//    CC_MD5_Update(&md5, data.bytes, data.length);
//    unsigned char digest [CC_MD5_DIGEST_LENGTH];
//    CC_MD5_Final(digest, &md5);
 
    
    
    
    
    return s ;

}


@end


@implementation UIImageView (Cache)

-(void)setImageWithUrl:(NSURL *)url completion:(SetImageBlock)block{
    
    //从缓存中加载
    __block NSData *imageData= [[CacheManager  Cache]objectForKey:url.md5];
    
    if (imageData !=nil) {
        NSLog(@"缓存加载!");
        UIImage *image =[UIImage imageWithData:imageData];
        self.image =image;
        
        block(YES);
        return;
    }
//    //从本地加载
//    NSString *file =[[CacheManager cachePath]stringByAppendingFormat:@"/%@.jpg",url.md5];
//    imageData =[NSData dataWithContentsOfFile:file];
//    if (imageData !=nil) {
//        NSLog(@"本地加载图片");
//        UIImage *image =[UIImage imageWithData:imageData];
//        self.image = image;
//        [[CacheManager Cache]setObject:imageData forKey:url.md5];
//        block(YES);
//        return;
//    }
    //从本地加载
    NSString *file=[[CacheManager cachePath]stringByAppendingFormat:@"/%@.jpg",url.md5];
    imageData =[NSData dataWithContentsOfFile:file];
    if (imageData !=nil) {
        NSLog(@"本地加载图片");
        UIImage *image =[UIImage imageWithData:imageData];
        self.image =image;
        [[CacheManager Cache]setObject:imageData forKey:url.md5];
        block(YES);
        return;
    }
    //从网络加载
    
//    NSURLSessionDownloadTask *task=[[NSURLSession sharedSession]downloadTaskWithRequest:[NSURLRequest  requestWithURL:url] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSURL *fileUrl =[NSURL fileURLWithPath:file];
//        NSFileManager *manager =[NSFileManager defaultManager];
//        [manager copyItemAtURL:location toURL:fileUrl error:nil];
//        imageData =[NSData dataWithContentsOfURL:location];
//        [[CacheManager Cache]setObject:imageData forKey:url.md5];
//        NSLog(@"网络加载图片");
//       dispatch_async(dispatch_get_main_queue(), ^{
//           self.image =[UIImage imageWithData:imageData];
//           block(YES);
//       });
//
//    }];
//    [task resume];
    
    
    NSURLSessionDownloadTask *task =[[NSURLSession sharedSession]downloadTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSURL *fileUrl =[NSURL fileURLWithPath:file];
        NSFileManager *manager =[NSFileManager defaultManager];
        [manager copyItemAtURL:location toURL:fileUrl error:nil];
        imageData =[NSData dataWithContentsOfURL:location];
        [[CacheManager Cache]setObject:imageData forKey:url.md5];
        NSLog(@"网络加载图片");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image =[UIImage imageWithData:imageData];
            block(YES);
        });

    }];
       [task resume];
}







@end
