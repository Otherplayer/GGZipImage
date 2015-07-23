//
//  GGZipImage.h
//  GGZipImage
//
//  Created by __无邪_ on 15/7/23.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GGZipImage : NSObject

+ (GGZipImage *)sharedImage;

/**
 *  把 originalImage 压缩到200kb以内
 *  目前会存在有些图片压缩到一定大小后，再压缩就没有作用了
 */

- (UIImage *)zipImageWithImage:(UIImage *)originalImagle;






@end
