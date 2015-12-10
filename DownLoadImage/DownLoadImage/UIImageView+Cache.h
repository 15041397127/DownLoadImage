//
//  UIImageView+Cache.h
//  DownLoadImage
//
//  Created by zhang xu on 15/11/21.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetImageBlock)(BOOL flag);
@interface UIImageView (Cache)

-(void)setImageWithUrl:(NSURL *)url completion:(SetImageBlock)block;


@end
